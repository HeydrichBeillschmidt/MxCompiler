package Mx.Optimize.FlowAnalysis;

import Mx.IR.IRModule;
import Mx.Optimize.Pass;

public class LoopAnalysis extends Pass {
    public LoopAnalysis(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return false;
    }
}
