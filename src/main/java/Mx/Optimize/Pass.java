package Mx.Optimize;

import Mx.IR.IRModule;

abstract public class Pass {
    protected IRModule module;

    public Pass(IRModule module) {
        this.module = module;
    }

    abstract public boolean run();
}
