package Mx.IR.Operand;

import Mx.IR.TypeSystem.BoolType;

public class ConstBool extends Constant {
    private final boolean value;

    public ConstBool(boolean value) {
        super(new BoolType());
        this.value = value;
    }

    public boolean getValue() {
        return value;
    }

    @Override
    public String toString() {
        return value ? "1" : "0";
    }
    @Override
    public boolean equals(Object obj) {
        return obj instanceof ConstBool
                && value==((ConstBool)obj).value;
    }
}
