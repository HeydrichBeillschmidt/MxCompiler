package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMVisitor;

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
    @Override
    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
