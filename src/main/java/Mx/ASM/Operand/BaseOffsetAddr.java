package Mx.ASM.Operand;

public class BaseOffsetAddr extends Address {
    private VirtualReg base;
    private final Immediate offset;

    public BaseOffsetAddr(VirtualReg base, Immediate offset) {
        this.base = base;
        this.offset = offset;
    }

    @Override
    public VirtualReg getBase() {
        return base;
    }
    @Override
    public int getOffset() {
        return offset.getValue();
    }

    @Override
    public String emitCode() {
        return offset.emitCode() + "(" + base.emitCode() + ")";
    }
    @Override
    public String toString() {
        return offset.toString() + "(" + base.toString() + ")";
    }
    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof BaseOffsetAddr)) return false;
        return base==((BaseOffsetAddr)obj).base
                && offset.equals(((BaseOffsetAddr)obj).offset);
    }
}