package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Call;
import Mx.Optimize.FlowAnalysis.DominanceAnalysis;
import Mx.Optimize.FlowAnalysis.InterProceduralAnalysis;

import java.util.*;

public class Inliner extends Pass {
    private final InterProceduralAnalysis interProc;
    private Map<Function, Integer> instCnt;
    private final int thresholdInstNum = 128;

    public Inliner(IRModule module, InterProceduralAnalysis interProc) {
        super(module);
        this.interProc = interProc;
    }

    @Override
    public boolean run() {
        countInst();
        boolean changed = inlineBasic();
        changed |= inlineRecursive();
        removeRedundantFunc();
        return changed;
    }

    private void countInst() {
        instCnt = new HashMap<>();
        for (var f: module.getFunctions().values()) {
            int cnt = 0;
            ArrayList<IRBlock> RPO = f.getRPO();
            for (var b: RPO) {
                cnt += b.getAllInst().size();
            }
            instCnt.put(f, cnt);
        }
    }

    private void funcInsert(Function caller, Call cs) {
        //todo
    }
    private boolean inlineBasic() {
        boolean changed = false;

        ArrayList<Function> cPO = interProc.getPO();
        for (var f: cPO) {
            Set<Call> css = new HashSet<>(f.getCallSites());
            for (var cs: css) {
                Function callee = cs.getCallee();
                if (instCnt.get(callee)<thresholdInstNum && callee!=f
                        && !interProc.recursiveFunc(callee)) {
                    funcInsert(f, cs);
                    instCnt.put(f, instCnt.get(f)+instCnt.get(callee));
                    changed = true;
                }
            }
        }

        return changed;
    }
    private boolean inlineRecursive() {
        boolean changed = false;

        ArrayList<Function> cPO = interProc.getPO();
        int thresholdRecursive = 3;
        for (int i = 0; i < thresholdRecursive; ++i) {
            for (var f: cPO) {
                Set<Call> css = new HashSet<>(f.getCallSites());
                for (var cs: css) {
                    Function callee = cs.getCallee();
                    if (instCnt.get(callee)<thresholdInstNum && callee==f) {
                        funcInsert(f, cs);
                        instCnt.put(f, instCnt.get(f)+instCnt.get(callee));
                        changed = true;
                    }
                }
            }
        }

        return changed;
    }

    private void removeRedundantFunc() {
        interProc.run();
        Set<Function> unusedFunc = new HashSet<>(module.getFunctions().values());
        unusedFunc.removeAll(interProc.getPO());
        unusedFunc.forEach(f -> module.getFunctions().remove(f.getName()));
        new DominanceAnalysis(module).run();
    }
}
