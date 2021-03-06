package Mx.ASM.Operand;

public class Immediate extends ASMOperand {
    private final int value;

    public Immediate(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    @Override
    public String emitCode() {
        return String.valueOf(value);
    }
    @Override
    public String toString() {
        return String.valueOf(value);
    }
    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Immediate)) return false;
        return value==((Immediate)obj).value;
    }
}
