package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Br;
import Mx.IR.Instruction.Move;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

import java.util.*;

public class SSADestructor extends Pass {
    private static class cEdge {
        public IRBlock pre, suc;

        public cEdge(IRBlock pre, IRBlock suc) {
            this.pre = pre;
            this.suc = suc;
        }
    }
    private static class parallelCopy {
        public Set<Move> copies;
        public parallelCopy() {
            copies = new HashSet<>();
        }

        public void addMove(Move mv) {
            if (mv.getDst().equals(mv.getSrc())) return;
            copies.add(mv);
        }
        public Move getValidMove() {
            for (var mv: copies) {
                boolean found = true;
                for (var cmp: copies) {
                    if (mv.getDst().equals(cmp.getSrc())) {
                        found = false;
                        break;
                    }
                }
                if (found) return mv;
            }
            return null;
        }
    }

    private Map<IRBlock, parallelCopy> copyMap;
    private Function curFunc;

    public SSADestructor(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        module.getFunctions().values().forEach(this::runForFn);
        return false;
    }
    private void runForFn(Function f) {
        curFunc = f;
        splitCriticalEdge(f);
        copyMap.forEach(this::resolvePC);
    }

    private void splitCriticalEdge(Function f) {
        Set<cEdge> criticalEdges = new HashSet<>();
        for (var b: f.getAllBlocks()) {
            if (b.getPredecessors().size()==1) {
                for (var ph: b.getAllPhi()) {
                    ph.getDst().replaceUse(ph.getValues().get(0));
                    ph.removeFromBlock();
                }
            }
            else if (b.getPredecessors().size()>1) {
                for (var pred: b.getPredecessors()) {
                    if (pred.getSuccessors().size() > 1) {
                        criticalEdges.add(new cEdge(pred, b));
                    }
                }
            }
        }
        for (var critical: criticalEdges) {
            IRBlock pre = critical.pre;
            IRBlock suc = critical.suc;
            IRBlock mid = new IRBlock("criticalBlock");
            f.addSymbol(mid);

            mid.addInst(new Br(mid, null, suc, null));

            for (var ph: suc.getAllPhi()) {
                for (int i = 0, it = ph.getBlocks().size(); i < it; ++i) {
                    if (ph.getBlocks().get(i)==pre) ph.getBlocks().set(i, mid);
                }
            }
            pre.replaceSuccessor(suc, mid);
        }

        copyMap = new HashMap<>();
        f.getAllBlocks().forEach(b -> copyMap.put(b, new parallelCopy()));
        for (var b: f.getAllBlocks()) {
            for (var ph: b.getAllPhi()) {
                for (int i = 0, it = ph.getBlocks().size(); i < it; ++i) {
                    IRBlock pre = ph.getBlocks().get(i);
                    Operand value = ph.getValues().get(i);
                    copyMap.get(pre).addMove(new Move(pre, ph.getDst(), value));
                }
            }
            b.removeAllPhi();
        }
    }

    private void resolvePC(IRBlock block, parallelCopy PC) {
        ArrayList<Move> seq = new ArrayList<>();
        while (!PC.copies.isEmpty()) {
            Move validMV = PC.getValidMove();
            if (validMV!=null) {
                seq.add(validMV);
                PC.copies.remove(validMV);
            }
            else {
                validMV = PC.copies.iterator().next();
                Operand src = validMV.getSrc();
                Register fresh = new Register(src.getType(), "breakCycle");
                curFunc.addSymbol(fresh);
                seq.add(new Move(block, fresh, src));
                validMV.setSrc(fresh);
            }
        }
        seq.forEach(mv -> block.addPrevInst(block.getTailInst(), mv));
    }
}
