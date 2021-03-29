package Mx.ASM.Operand;

public class Address {
    private final VirtualReg base;
    private final Immediate offset;

    public Address(VirtualReg base, Immediate offset) {
        this.base = base;
        this.offset = offset;
    }

    public VirtualReg getBase() {
        return base;
    }
    public int getOffset() {
        return offset.getValue();
    }

    public String emitCode() {
        return offset.emitCode() + "(" + base.emitCode() + ")";
    }
    @Override
    public String toString() {
        return offset.toString() + "(" + base.toString() + ")";
    }
    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Address)) return false;
        return base==((Address)obj).base
                && offset.equals(((Address)obj).offset);
    }
}