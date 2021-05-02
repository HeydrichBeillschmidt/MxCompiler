package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Br;
import Mx.IR.Instruction.Call;
import Mx.IR.Instruction.Ret;
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
            ArrayList<IRBlock> PO = f.getPO();
            for (var b: PO) {
                cnt += b.getAllInst().size();
            }
            instCnt.put(f, cnt);
        }
    }

    private void funcInsert(Function caller, Call cs) {
        ArrayList<IRBlock> inlineBlocks = cs.getCallee().inlineToFunc(caller, cs.getParameterList());
        IRBlock inlineTail = null;
        for (var b: inlineBlocks) {
            if (b.getTailInst() instanceof Ret) {
                inlineTail = b;
                break;
            }
        }
        assert inlineTail!=null;
        Ret instRet = (Ret) inlineTail.getTailInst();
        if (cs.isNotVoidCall()) cs.getDst().replaceUse(instRet.getRetValue());

        IRBlock inlineEntrance = cs.getBlock();
        IRBlock inlineExit = inlineEntrance.split(caller, cs);
        caller.insertBlocks(inlineEntrance, inlineBlocks);

        cs.severDF();
        cs.removeFromBlock();
        caller.removeCallSite(cs);
        inlineEntrance.addInst(new Br(inlineEntrance, null, inlineBlocks.get(0), null));

        instRet.severDF();
        instRet.removeFromBlock();
        inlineTail.addInst(new Br(inlineTail, null, inlineExit, null));
    }
    private boolean inlineBasic() {
        boolean changed = false;

        ArrayList<Function> cPO = interProc.getPO();
        for (var f: cPO) {
            ArrayList<Call> css = new ArrayList<>(f.getCallSites());
            for (var cs: css) {
                Function callee = cs.getCallee();
                if (module.hasNoFunction(callee.getName())) continue;
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
                ArrayList<Call> css = new ArrayList<>(f.getCallSites());
                for (var cs: css) {
                    Function callee = cs.getCallee();
                    if (module.hasNoFunction(callee.getName())) continue;
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
