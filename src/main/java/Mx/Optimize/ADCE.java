package Mx.Optimize;

import Mx.IR.IRModule;

// aggressive dead code elimination
public class ADCE extends Pass {
    public ADCE(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return false;
    }
}
