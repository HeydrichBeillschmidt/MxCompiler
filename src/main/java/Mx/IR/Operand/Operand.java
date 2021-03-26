package Mx.IR.Operand;

import Mx.IR.TypeSystem.IRType;

abstract public class Operand {
    private final IRType type;

    public Operand(IRType type) {
        this.type = type;
    }

    public IRType getType() {
        return type;
    }

    abstract public boolean isConstant();
    abstract public String toString();
    public boolean equals(Object obj) {
        if (obj instanceof Operand)
            return toString().equals(obj.toString());
        return false;
    }
}
