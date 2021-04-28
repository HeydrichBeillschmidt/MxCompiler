package Mx.Optimize.FlowAnalysis;

import Mx.IR.Function;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Call;
import Mx.Optimize.Pass;

import java.util.*;

public class InterProceduralAnalysis extends Pass {
    private Map<Function, Set<Function>> callForward, callBackward;
    private Map<Function, Set<Function>> callees;

    public InterProceduralAnalysis(IRModule module) {
        super(module);
    }

    public Set<Function> getDirectCallees(Function f) {
        return callForward.get(f);
    }
    public Set<Function> getDirectCallers(Function f) {
        return callBackward.get(f);
    }
    public Set<Function> getAllCallees(Function f) {
        return callees.get(f);
    }
    public boolean recursiveFunc(Function f) {
        return callees.get(f).contains(f);
    }

    @Override
    public boolean run() {
        callForward = new HashMap<>();
        callBackward = new HashMap<>();
        callees = new HashMap<>();

        for (var f: module.getFunctions().values()) {
            if (module.hasNoFunction(f.getName())) continue;
            callForward.put(f, new HashSet<>());
            callBackward.put(f, new HashSet<>());
        }
        for (var f: module.getFunctions().values()) {
            for (var cs: f.getCallSites()) {
                Function callee = cs.getCallee();
                if (module.hasNoFunction(callee.getName())) continue;
                callForward.get(f).add(callee);
                callBackward.get(callee).add(f);
            }
        }
        // compute overall callees
        ArrayList<Function> PO = getPO();
        for (var f: PO) callees.put(f, new HashSet<>(callForward.get(f)));
        for (var f: PO) {
            Queue<Function> W = new LinkedList<>();
            Set<Function> fCallees = callees.get(f);
            fCallees.forEach(W::offer);
            while (!W.isEmpty()) {
                Function fn = W.poll();
                for (var callee: callees.get(fn)) {
                    if (!fCallees.contains(callee)) {
                        fCallees.add(callee);
                        W.offer(callee);
                    }
                }
            }
        }
        return false;
    }

    public ArrayList<Function> getPO() {
        ArrayList<Function> order = new ArrayList<>();
        _dfsRecursive(module.getFunction("_main$$YGHXZ"),
                order, new HashSet<>());
        return order;
    }
    private void _dfsRecursive(Function f, ArrayList<Function> order,
                               Set<Function> visited) {
        visited.add(f);
        for (var s: callForward.get(f)) {
            if (!visited.contains(s)) {
                _dfsRecursive(s, order, visited);
            }
        }
        order.add(f);
    }
}
