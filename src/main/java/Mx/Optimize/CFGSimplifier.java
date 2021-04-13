package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRModule;

public class CFGSimplifier extends Pass {
    public CFGSimplifier(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        boolean changed = false;
        for (var f: module.getFunctions().values()) changed |= runForFn(f);
        return changed;
    }
    private boolean runForFn(Function f) {
        ;
        return false;
    }

    private boolean removeRedundantJP(Function f) {
        boolean changed = false;

        return changed;
    }
}
