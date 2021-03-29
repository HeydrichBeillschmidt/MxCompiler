package Mx.ASM.Operand;

public class StackPtr extends Immediate {
    private boolean reversed;

    public StackPtr(int value) {
        super(value);
        reversed = false;
    }

    public void reverse() {
        reversed = true;
    }
    public boolean isReversed() {
        return reversed;
    }
}
