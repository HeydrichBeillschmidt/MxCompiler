package Mx.ASM.Operand;

import Mx.ASM.ASMVisitor;

public class GlobalVar extends VirtualReg {
    public GlobalVar(String name, int size) {
        super(size, name);
    }

    @Override
    public String emitCode() {
        return getName();
    }

    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
