package Mx.Optimize;

import Mx.IR.IRModule;
import Mx.IR.IRPrinter;
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

            InterProceduralAnalysis interProc = new InterProceduralAnalysis(module);
            SideEffectAnalysis sideEffect = new SideEffectAnalysis(module, interProc);
            LoopAnalysis loop = new LoopAnalysis(module);

            boolean changed = new TailRecursionEliminator(module).run();
            changed |= new SCCP(module).run();
            changed |= new CFGSimplifier(module).run();
            interProc.run();
            sideEffect.run();
            changed |= new ADCE(module).run();
            changed |= new CFGSimplifier(module).run();
            changed |= new CSE(module).run();
            loop.run();
            changed |= new LICM(module, loop).run();
            if (cnt==9) changed |= new OSR(module).run();
            interProc.run();
            changed |= new Inliner(module, interProc).run();
            changed |= new AlgebraicSimplifier(module).run();
            changed |= new PeepholeOpt(module).run();
            changed |= new CFGSimplifier(module).run();

            if (!changed) break;
            //new IRPrinter("inOpt_"+(10-cnt)+".ll").run(module);
        }
    }
}
