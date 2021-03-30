package Mx.Backend;

import Mx.ASM.ASMModule;

public class LivenessAnalysis {
    private final ASMModule module;

    public LivenessAnalysis(ASMModule module) {
        this.module = module;
    }

    public void run() {
        for (var f: module.getFunctions().values())
            f.performLvnAnalysis();
    }
}
