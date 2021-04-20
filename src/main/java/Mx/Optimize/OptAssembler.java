package Mx.Optimize;

import Mx.IR.IRModule;
import Mx.Optimize.ConstOptim.*;
import Mx.Optimize.FlowAnalysis.*;

public class OptAssembler {
    private final IRModule module;

    public OptAssembler(IRModule module) {
        this.module = module;
    }

    public void run() {
        int cnt = 10;
        while (true) {
            if (--cnt==0) break;

            AliasAnalysis alias = new AliasAnalysis(module);
            LoopAnalysis loop = new LoopAnalysis(module);

            boolean changed = new ADCE(module).run();
            changed |= new SCCP(module).run();
            changed |= new Inliner(module).run();
            changed |= new CFGSimplifier(module).run();

            if (!changed) break;
        }
    }
}
