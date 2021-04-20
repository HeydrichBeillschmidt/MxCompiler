package Mx.Optimize;

import Mx.IR.IRModule;

public class Inliner extends Pass {
    private final int thresholdInstNum = 64;

    public Inliner(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        return false;
    }
}
