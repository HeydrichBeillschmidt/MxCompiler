package Mx.Optimize.FlowAnalysis;

import Mx.IR.Function;
import Mx.IR.IRModule;
import Mx.Optimize.Pass;

//https://www.cs.rice.edu/~keith/EMBED/dom.pdf

public class DominanceAnalysis extends Pass {
    public DominanceAnalysis(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        module.getFunctions().values().forEach(this::runForFn);
        return true;
    }
    private void runForFn(Function f) {
        f.solveDominance();
        f.solveDF();
    }
}
