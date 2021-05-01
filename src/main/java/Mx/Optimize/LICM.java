package Mx.Optimize;

import Mx.IR.IRBlock;
import Mx.IR.IRLoop;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.Constant;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.Optimize.FlowAnalysis.LoopAnalysis;

import java.util.*;

// loop invariant code motion
public class LICM extends Pass {
    private final LoopAnalysis lpa;

    private Set<Register> loopInvariant;

    private boolean changed;

    public LICM(IRModule module, LoopAnalysis lpa) {
        super(module);
        this.lpa = lpa;
    }

    @Override
    public boolean run() {
        changed = false;
        loopInvariant = new HashSet<>();
        lpa.getExteriorLoops().forEach(this::runForLoop);

        return changed;
    }
    private void runForLoop(IRLoop loop) {

        if (!loop.getChildren().isEmpty()) {
            for (var c: loop.getChildren()) {
                runForLoop(c);
            }
        }

        Queue<IRInst> W = new LinkedList<>();
        while (true) {
            boolean loopCond = false;
            for (var b: loop.getBlocks()) {
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

        while (!W.isEmpty()) {
            IRInst inst = W.poll();
            if (canHoist(inst, loop)) hoistInst(loop.getPreHeader(), inst);
            else W.offer(inst);
        }
    }

    // loop invariant
    private boolean checkLPI(IRInst inst, IRLoop loop) {
        if (inst.hasNoSideEffect()) {
            if (isLPI(inst.getDst(), loop)) return false;

            if (inst instanceof BinaryOp) {
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
        if (inst.hasNoSideEffect()) {
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
