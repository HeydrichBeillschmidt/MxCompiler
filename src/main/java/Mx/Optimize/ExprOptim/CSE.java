package Mx.Optimize.ExprOptim;

import Mx.IR.IRModule;
import Mx.Optimize.Pass;

// common subexpression elimination
public class CSE extends Pass {
    public CSE(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return false;
    }
}
