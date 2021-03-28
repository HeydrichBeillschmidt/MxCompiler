package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;

public class RET extends ASMInst {
    public RET(ASMBlock block) {
        super(block);
    }

    @Override
    public String emitCode() {
        return "\tret";
    }
    @Override
    public String toString() {
        return "ret";
    }
}
