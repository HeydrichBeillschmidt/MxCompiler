package Mx.ASM.Operand;

public class GlobalVar extends ASMOperand {
    private final String name;

    public GlobalVar(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String emitCode() {
        return name;
    }
    @Override
    public String toString() {
        return name;
    }
}
