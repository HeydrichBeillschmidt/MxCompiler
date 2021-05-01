package Mx.Optimize;

import Mx.IR.IRBlock;
import Mx.IR.IRLoop;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.Constant;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.Optimize.FlowAnalysis.AliasAnalysis;
import Mx.Optimize.FlowAnalysis.DominanceAnalysis;
import Mx.Optimize.FlowAnalysis.LoopAnalysis;

import java.util.*;

//http://www.cs.toronto.edu/~pekhimenko/courses/cscd70-w18/docs/Lecture%205%20[LICM%20and%20Strength%20Reduction]%2002.08.2018.pdf

// loop invariant code motion
public class LICM extends Pass {
    private final AliasAnalysis alias;
    private final LoopAnalysis lpa;

    private Map<IRLoop, Set<Store>> loopSTs;
    private Set<IRLoop> hasSideEffect;
    private Set<IRBlock> candidate;
    private Set<Register> loopInvariant;

    private boolean changed;

    public LICM(IRModule module, AliasAnalysis alias, LoopAnalysis lpa) {
        super(module);
        this.alias = alias;
        this.lpa = lpa;
    }

    @Override
    public boolean run() {
        changed = false;

        loopSTs = new HashMap<>();
        hasSideEffect = new HashSet<>();
        candidate = new HashSet<>();
        loopInvariant = new HashSet<>();
        new DominanceAnalysis(module).run();
        lpa.getExteriorLoops().forEach(this::runForLoop);

        return changed;
    }
    private void runForLoop(IRLoop loop) {
        Set<Store> lpST = new HashSet<>();
        boolean sideEffect = false;

        if (!loop.getChildren().isEmpty()) {
            for (var c: loop.getChildren()) {
                runForLoop(c);
                lpST.addAll(loopSTs.get(c));
                sideEffect |= hasSideEffect.contains(c);
            }
        }

        candidate.clear();
        for (var b: loop.getUniqueBlocks()) {
            for (var i: b.getAllInst()) {
                if (i instanceof Store) lpST.add((Store)i);
                else if (i instanceof Call &&
                        ((Call)i).getCallee().hasSideEffect() ) {
                    sideEffect = true;
                }
            }

            boolean isCandidate = true;
            for (var t: loop.getTails()) {
                if (!t.isDomed(b)) isCandidate = false;break;
            }
            if (isCandidate) candidate.add(b);
        }
        loopSTs.put(loop, lpST);
        if (sideEffect) hasSideEffect.add(loop);

        Queue<IRInst> W = new LinkedList<>();
        while (true) {
            boolean loopCond = false;
            for (var b: loop.getUniqueBlocks()) {
                for (var i: b.getAllInst()) {
                    if (checkLPI(i, loop)) {
                        W.offer(i);
                        loopCond = true;
                    }
                }
            }
            if (loopCond) changed = true;
            else break;
        }

        Set<IRInst> secondVisit = new HashSet<>();
        while (!W.isEmpty()) {
            IRInst inst = W.poll();
            if (canHoist(inst, loop)) hoistInst(loop.getPreHeader(), inst);
            else if (!secondVisit.contains(inst)) {
                secondVisit.add(inst);
                W.offer(inst);
            }
        }
    }

    // loop invariant
    private boolean checkLPI(IRInst inst, IRLoop loop) {
        if (inst.hasNoSideEffect()
                || inst instanceof Call
                || inst instanceof Load) {
            if (!candidate.contains(inst.getBlock())) return false;
            if (isLPI(inst.getDst(), loop)) return false;
            for (var u: inst.getDst().getUses()) {
                IRBlock block = u.getBlock();
                if (!loop.getBlocks().contains(block)) continue;
                if (!block.isDomed(inst.getBlock())) return false;
            }

            if (inst instanceof Call) {
                Call i = (Call) inst;
                if (i.isVoidCall()) return false;
                if (i.getCallee().hasSideEffect()) return false;
            }
            else if (inst instanceof Load) {
                Set<Store> lpST = loopSTs.get(loop);
                for (var i: lpST) {
                    if (alias.mayAlias( ((Load)inst).getAddr(),
                            i.getAddr() ) ) return false;
                }
            }
            else if (inst instanceof BinaryOp) {
                BinaryOp i = (BinaryOp) inst;
                if (i.getOpName()==BinaryOp.BinaryOpName.sdiv
                        && !(i.getOp2() instanceof Constant)) {
                    IRBlock block = i.getBlock();
                    for (var e: loop.getTails()) {
                        if (!e.isDomed(block)) return false;
                    }
                }
            }

            for (var u: inst.getUses()) {
                if (!isLPI(u, loop)) return false;
            }
            loopInvariant.add(inst.getDst());
            return true;
        }
        return false;
    }
    private boolean isLPI(Operand o, IRLoop loop) {
        if (loop.notDefinedInLoop(o)) return true;
        assert o instanceof Register;
        return loopInvariant.contains(o);
    }

    private boolean canHoist(IRInst inst, IRLoop loop) {
        if (inst.hasNoSideEffect()
                || inst instanceof Call
                || inst instanceof Load) {
            for (var u: inst.getUses()) {
                if (!loop.notDefinedInLoop(u)) return false;
            }
            return true;
        }
        return false;
    }
    private void hoistInst(IRBlock preHeader, IRInst inst) {
        inst.removeFromBlock();
        inst.setBlock(preHeader);

        IRInst tail = preHeader.getTailInst();
        if (tail.getPrevInst()==null) {
            preHeader.setHeadInst(inst);
            inst.setPrevInst(null);
        }
        else {
            tail.getPrevInst().setNextInst(inst);
            inst.setPrevInst(tail.getPrevInst());
        }
        tail.setPrevInst(inst);
        inst.setNextInst(tail);
    }
}
