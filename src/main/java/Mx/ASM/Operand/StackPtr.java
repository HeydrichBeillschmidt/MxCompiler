package Mx.ASM.Operand;

public class StackPtr extends Address {
    private final String name;
    private int offset;

    public StackPtr(String name) {
        this.name = name;
        this.offset = -1;
    }

    public void setOffset(int offset) {
        assert this.offset==-1;
        this.offset = offset;
    }

    @Override
    public VirtualReg getBase() {
        return null;
    }
    @Override
    public int getOffset() {
        return offset;
    }

    @Override
    public String emitCode() {
        return offset + "(sp)";
    }
    @Override
    public String toString() {
        return name + "(sp)";
    }
    @Override
    public boolean equals(Object obj) {
        return this==obj;
    }
}
