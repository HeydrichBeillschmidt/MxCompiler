package Mx.Optimize;

import Mx.IR.IRModule;
import Mx.Optimize.ExprOptim.*;
import Mx.Optimize.FlowAnalysis.*;
import Mx.Optimize.LoopOptim.*;

public class OptAssembler {
    private final IRModule module;

    public OptAssembler(IRModule module) {
        this.module = module;
    }

    public void run() {
        int cnt = 10;
        while (true) {
            if (--cnt==0) break;

            InterProceduralAnalysis interProc = new InterProceduralAnalysis(module);
            SideEffectAnalysis sideEffect = new SideEffectAnalysis(module, interProc);
            AliasAnalysis alias = new AliasAnalysis(module, interProc);
            LoopAnalysis loop = new LoopAnalysis(module);

            boolean changed = new SCCP(module).run();
            interProc.run();
            sideEffect.run();
            changed |= new ADCE(module).run();
            changed |= new CFGSimplifier(module).run();
            changed |= new CSE(module).run();
            interProc.run();
            sideEffect.run();
            alias.run();
            loop.run();
            changed |= new LICM(module, alias, loop).run();
            changed |= new StrengthReduction(module, loop).run();
            changed |= new Inliner(module, interProc).run();
            changed |= new CFGSimplifier(module).run();

            if (!changed) break;
        }
    }
}
