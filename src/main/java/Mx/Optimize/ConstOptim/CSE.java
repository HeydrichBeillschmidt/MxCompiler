package Mx.Optimize.ConstOptim;

import Mx.IR.IRModule;
import Mx.Optimize.Pass;

// constant-subexpression evaluation / constant folding
public class CSE extends Pass {
    public CSE(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return false;
    }
}
