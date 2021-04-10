package Mx.IR.TypeSystem;

import Mx.IR.Operand.ConstInt;
import Mx.IR.Operand.Operand;

public class IntegerType extends IRType {
    private final int size;

    public IntegerType(int size) {
        super();
        this.size = size;
    }

    @Override
    public int size() {
        return Math.max(size, 1);
    }
    @Override
    public String toString() {
        return "i" + size*8;
    }

    @Override
    public Operand getDefaultValue() {
        return new ConstInt(0, size);
    }
}
