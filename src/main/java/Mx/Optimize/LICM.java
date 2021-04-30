package Mx.Optimize;

import Mx.IR.IRBlock;
import Mx.IR.IRLoop;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.Constant;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.Optimize.FlowAnalysis.AliasAnalysis;
import Mx.Optimize.FlowAnalysis.LoopAnalysis;

import java.util.*;

// loop invariant code motion
public class LICM extends Pass {
    private final AliasAnalysis alias;
    private final LoopAnalysis lpa;
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

        loopInvariant = new HashSet<>();
        lpa.getExteriorLoops().forEach(this::runForLoop);

        return changed;
    }
    private void runForLoop(IRLoop loop) {
        if (!loop.getChildren().isEmpty()) {
            loop.getChildren().forEach(this::runForLoop);
        }

        alias.buildST(loop);

        Set<Register> loopDef = new HashSet<>();
        for (var b: loop.getBlocks()) {
            for (var i: b.getAllInst()) {
                if (i.hasDst()) loopDef.add(i.getDst());
            }
        }
        Queue<IRInst> W = new LinkedList<>();
        for (var b: loop.getBlocks()) {
            for (var i: b.getAllInst()) checkHoist(i, loopDef, W);
        }
        changed |= !W.isEmpty();

        while (!W.isEmpty()) {
            IRInst inst = W.poll();
            hoistInst(loop.getPreHeader(), inst);
            for (var u: inst.getDst().getUses()) {
                if (loopDef.contains(u.getDst())) checkHoist(u, loopDef, W);
            }
        }
    }

    private void checkHoist(IRInst inst, Set<Register> loopDef, Queue<IRInst> W) {
        if (inst instanceof Load) {
            Set<Operand> uses = inst.getUses();
            uses.retainAll(loopDef);
            if (uses.isEmpty() && !alias.useLoopST((Load) inst)) {
                loopDef.remove(inst.getDst());
                W.offer(inst);
            }
        }
        else if (inst.hasNoSideEffect()) {
            Set<Operand> uses = inst.getUses();
            uses.retainAll(loopDef);
            if (uses.isEmpty()) {
                loopDef.remove(inst.getDst());
                W.offer(inst);
            }
        }
    }

    // loop invariant
    private boolean checkLPI(IRInst inst, IRLoop loop) {
        if (inst.hasNoSideEffect()
                || inst instanceof Call
                || inst instanceof Load) {
            if (isLPI(inst.getDst(), loop)) return false;

            if (inst instanceof Call) {
                Call i = (Call) inst;
                if (i.isVoidCall()) return false;
                if (i.getCallee().hasSideEffect()) return false;
            }
            else if (inst instanceof Load) {
                if (alias.useLoopST((Load) inst)) return false;
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
