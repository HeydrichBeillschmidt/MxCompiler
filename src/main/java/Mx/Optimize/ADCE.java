package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

import java.util.*;

//"Engineering a Compiler"Ch10.2.1

// aggressive dead code elimination
public class ADCE extends Pass {
    private boolean changed;
    private Queue<IRInst> W;
    private Set<IRInst> liveCode;

    public ADCE(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        W = new LinkedList<>();
        liveCode = new HashSet<>();
        module.getFunctions().values().forEach(this::runForFn);
        return changed;
    }
    private void runForFn(Function f) {
        mark(f);
        sweep(f);
    }

    private void mark(Function f) {
        W.clear();
        liveCode.clear();
        ArrayList<IRBlock> RPO = f.getRPO();
        for (var b: RPO) {
            b.initMark();
            for (var i: b.getAllInst()) {
                if (i instanceof Store || i instanceof Ret
                        || (i instanceof Call && ((Call)i).getCallee().hasSideEffect())
                        || (i instanceof Br && ((Br)i).getCondition()==null)) {
                    markInst(i);
                }
            }
        }
        while (!W.isEmpty()) {
            IRInst i = W.poll();
            Set<Operand> uses = i.getUses();
            for (var u: uses) {
                if (u instanceof Register) {
                    markInst(((Register)u).getDef());
                }
            }
            for (var b: i.getBlock().getRDF()) {
                IRInst j = b.getTailInst();
                if (j instanceof Br && ((Br)j).getCondition()!=null) {
                    markInst(j);
                }
            }
        }
    }
    private void markInst(IRInst inst) {
        if (!liveCode.contains(inst)) {
            liveCode.add(inst);
            W.offer(inst);
            inst.getBlock().mark();
        }
    }

    private void sweep(Function f) {
        ArrayList<IRBlock> RPO = f.getRPO();
        for (var b: RPO) {
            for (var i: b.getAllInst()) {
                if (!liveCode.contains(i)) {
                    changed = true;
                    if (i instanceof Br && ((Br)i).getCondition()!=null) {
                        ((Br) i).rewriteToJump(i.getBlock().nearestMarkedPostDom());
                    }
                    if (!(i instanceof Br && ((Br)i).getCondition()==null)) {
                        i.severDF();
                        i.severCF();
                        i.removeFromBlock();
                    }
                }
            }
        }
    }
}
