package Mx.Optimize.LoopOptim;

import Mx.IR.IRModule;
import Mx.Optimize.FlowAnalysis.LoopAnalysis;
import Mx.Optimize.Pass;

public class StrengthReduction extends Pass {
    private final LoopAnalysis lpa;

    public StrengthReduction(IRModule module, LoopAnalysis lpa) {
        super(module);
        this.lpa = lpa;
    }

    @Override
    public boolean run() {
        return false;
    }
}
