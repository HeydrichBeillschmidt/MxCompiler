package Mx.ASM.Operand;

public class Address {
    private VirtualReg base;
    private Immediate offset;

    public Address(VirtualReg base, Immediate offset) {
        this.base = base;
        this.offset = offset;
    }

    public VirtualReg getBase() {
        return base;
    }
    public void setBase(VirtualReg base) {
        this.base = base;
    }
    public Immediate getOffset() {
        return offset;
    }
    public void setOffset(Immediate offset) {
        this.offset = offset;
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