package Mx.ASM.Operand;

public class GlobalVar extends ASMOperand {
    private final String name;
    private final int size;

    public GlobalVar(String name, int size) {
        this.name = name;
        this.size = size;
    }

    public String getName() {
        return name;
    }
    public int getSize() {
        return size;
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
