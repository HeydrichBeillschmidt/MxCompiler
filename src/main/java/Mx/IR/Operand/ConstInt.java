package Mx.IR.Operand;

import Mx.IR.TypeSystem.IntegerType;

public class ConstInt extends Constant {
    private final int value;

    public ConstInt(int value, int size) {
        super(new IntegerType(size));
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "" + value;
    }
    @Override
    public boolean equals(Object obj) {
        return obj instanceof ConstInt
                && value==((ConstInt)obj).value;
    }
}
