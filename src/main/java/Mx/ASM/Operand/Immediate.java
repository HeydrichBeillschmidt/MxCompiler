package Mx.ASM.Operand;

public class Immediate extends ASMOperand {
    private int value;

    public Immediate(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}
