package Mx.IR.TypeSystem;

import Mx.IR.Operand.Operand;

abstract public class IRType {
    public IRType() {}

    public int getDim() {
        return 0;
    }

    abstract public int size();
    abstract public String toString();
    public boolean equals(Object obj) {
        if (obj instanceof IRType)
            return toString().equals(obj.toString());
        return false;
    }

    abstract public Operand getDefaultValue();
}
