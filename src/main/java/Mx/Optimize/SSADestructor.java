package Mx.Optimize;

import Mx.IR.IRModule;

public class SSADestructor extends Pass {
    public SSADestructor(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return false;
    }
}
