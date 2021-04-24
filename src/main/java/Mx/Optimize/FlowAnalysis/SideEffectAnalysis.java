package Mx.Optimize.FlowAnalysis;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Call;
import Mx.IR.Instruction.Ret;
import Mx.IR.Instruction.Store;
import Mx.Optimize.Pass;

import java.util.ArrayList;

public class SideEffectAnalysis extends Pass {
    private final InterProceduralAnalysis interProc;

    public SideEffectAnalysis(IRModule module, InterProceduralAnalysis interProc) {
        super(module);
        this.interProc = interProc;
    }

    @Override
    public boolean run() {
        ArrayList<Function> PO = interProc.getPO();
        PO.forEach(this::runForFn);
        return false;
    }
    private void runForFn(Function f) {
        f.setSideEffect(false);
        ArrayList<IRBlock> RPO = f.getRPO();
        for (var b: RPO) {
            for (var i: b.getAllInst()) {
                if (i instanceof Store) {
                    f.setSideEffect(true);
                    return;
                }
                else if (i instanceof Call) {
                    if (((Call)i).getCallee().hasSideEffect()) {
                        f.setSideEffect(true);
                        return;
                    }
                }
                else if (i instanceof Ret) {
                    if (((Ret)i).getRetValue()!=null) {
                        f.setSideEffect(true);
                        return;
                    }
                }
            }
        }
    }
}
