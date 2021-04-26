package Mx.Optimize.FlowAnalysis;

import Mx.IR.IRModule;
import Mx.Optimize.Pass;

//https://www.cs.rice.edu/~keith/EMBED/dom.pdf

public class DominanceAnalysis extends Pass {
    public DominanceAnalysis(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        for (var f: module.getFunctions().values()) {
            f.solveDominance();
            f.solveDF();
        }
        return false;
    }

    public void runBackward() {
        for (var f: module.getFunctions().values()) {
            f.solvePostDominance();
            f.solveRDF();
        }
    }
}
