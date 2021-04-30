package Mx.Optimize.FlowAnalysis;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRLoop;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Br;
import Mx.IR.Instruction.Phi;
import Mx.IR.Operand.Register;
import Mx.Optimize.Pass;

import java.util.*;

public class LoopAnalysis extends Pass {
    private Map<IRBlock, IRLoop> loopMap; // header -> loop
    private Set<IRLoop> exteriorLoops;

    private Function curFunc;

    public LoopAnalysis(IRModule module) {
        super(module);
    }

    public Set<IRLoop> getExteriorLoops() {
        return exteriorLoops;
    }

    @Override
    public boolean run() {
        loopMap = new HashMap<>();
        exteriorLoops = new HashSet<>();
        module.getFunctions().values().forEach(this::runForFn);
        return false;
    }
    private void runForFn(Function f) {
        curFunc = f;
        ArrayList<IRBlock> RPO = f.getRPO();
        // detect natural loops
        for (var b: RPO) {
            for (var s: b.getSuccessors()) {
                if (b.isDomed(s)) {
                    if (!loopMap.containsKey(s)) {
                        loopMap.put(s, new IRLoop());
                    }
                    loopMap.get(s).addTail(b);
                    break;
                }
            }
        }
        // construct loops
        loopMap.forEach((head, loop) ->
                loop.getTails().forEach(tail ->
                        collectLoopBlocks(head, tail)));

        // prepare pre-headers for followup opt
        loopMap.forEach(this::addPreHeader);

        solveLoopDepth(f.getEntranceBlock(), new Stack<>(), new HashSet<>());

        exteriorLoops.forEach(IRLoop::solveUniqueBlocks);
    }

    private void collectLoopBlocks(IRBlock head, IRBlock tail) {
        Set<IRBlock> visited = new HashSet<>();
        visited.add(head);
        visited.add(tail);
        Queue<IRBlock> W = new LinkedList<>();
        W.offer(tail);

        while (!W.isEmpty()) {
            IRBlock curBlock = W.poll();
            for (var p: curBlock.getPredecessors()) {
                if (!visited.contains(p)) {
                    visited.add(p);
                    W.offer(p);
                }
            }
        }

        loopMap.get(head).addBlocks(visited);
    }

    private void addPreHeader(IRBlock header, IRLoop loop) {
        ArrayList<IRBlock> pres = new ArrayList<>(header.getPredecessors());
        pres.removeAll(loop.getTails());
        if (pres.size()==1) loop.setPreHeader(pres.get(0));
        else {
            IRBlock preHeader = new IRBlock(header.getName()+"_preHeader");
            curFunc.addPrevBlock(header, preHeader);

            // split phis by whether their entries are from loop blocks or otherwise
            // move the latter phis to the preHeader
            ArrayList<Phi> phiList = header.getAllPhi();
            for (var ph: phiList) {
                Phi nonLoopPart = null;
                boolean noEntryInLoop = true;

                for (int i = 0; i < ph.getBlocks().size(); ++i) {
                    if (!loop.getTails().contains(ph.getBlocks().get(i))) {
                        if (nonLoopPart==null) {
                            nonLoopPart = new Phi(preHeader,
                                    new Register(ph.getDst().getType(),
                                            ph.getDst().getName()+"_preHeader"),
                                    new ArrayList<>(), new ArrayList<>());
                            preHeader.addInstAtHead(nonLoopPart);
                        }
                        ph.conveyEntry(nonLoopPart, i--);
                    }
                    else noEntryInLoop = false;
                }

                if (noEntryInLoop) {
                    assert nonLoopPart != null;
                    ph.getDst().replaceUse(nonLoopPart.getDst());
                    ph.severDF();
                    ph.removeFromBlock();
                }
                else if (nonLoopPart!=null) {
                    ph.addEntry(nonLoopPart.getDst(), preHeader);
                }
            }

            pres.forEach(p -> p.replaceSuccessor(header, preHeader));
            preHeader.addInst(new Br(preHeader, null, header, null));
            loop.setPreHeader(preHeader);
        }
    }

    private void solveLoopDepth(IRBlock block, Stack<IRLoop> stack, Set<IRBlock> visited) {
        visited.add(block);

        while (!stack.isEmpty() &&
                !stack.peek().getBlocks().contains(block)) {
            stack.pop();
        }
        if (loopMap.containsKey(block)) {
            IRLoop loop = loopMap.get(block);
            if (stack.isEmpty()) exteriorLoops.add(loop);
            else stack.peek().addChild(loop);
            stack.push(loop);
        }
        block.setLoopDepth(stack.size());

        for (var s: block.getSuccessors()) {
            if (!visited.contains(s)) {
                solveLoopDepth(s, stack, visited);
            }
        }
    }
}
