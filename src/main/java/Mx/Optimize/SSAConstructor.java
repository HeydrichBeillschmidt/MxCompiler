package Mx.Optimize;

import Mx.IR.IRModule;

public class SSAConstructor extends Pass {
    public SSAConstructor(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return true;
    }
}
