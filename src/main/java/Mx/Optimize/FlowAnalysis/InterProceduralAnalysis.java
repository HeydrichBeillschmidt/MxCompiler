package Mx.Optimize.FlowAnalysis;

import Mx.IR.Function;
import Mx.IR.IRModule;
import Mx.Optimize.Pass;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class InterProceduralAnalysis extends Pass {
    private final Map<Function, Set<Function>> callForward, callBackward;

    public InterProceduralAnalysis(IRModule module) {
        super(module);
        callForward = new HashMap<>();
        callBackward = new HashMap<>();
    }

    public Set<Function> getCallees(Function f) {
        return callForward.get(f);
    }
    public Set<Function> getCallers(Function f) {
        return callBackward.get(f);
    }

    @Override
    public boolean run() {
        for (var f: module.getFunctions().values()) {
            callForward.put(f, new HashSet<>());
            callBackward.put(f, new HashSet<>());
        }
        for (var f: module.getFunctions().values()) {
            for (var cs: f.getCallSites()) {
                Function callee = cs.getCallee();
                callForward.get(f).add(callee);
                callBackward.get(callee).add(f);
            }
        }
        return false;
    }
}
