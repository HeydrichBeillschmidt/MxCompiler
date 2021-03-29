package Mx.ASM.Operand;

public class GlobalVar extends VirtualReg {
    private final int size;

    public GlobalVar(String name, int size) {
        super(name);
        this.size = size;
    }

    public int getSize() {
        return size;
    }

    @Override
    public String emitCode() {
        return getName();
    }
}
