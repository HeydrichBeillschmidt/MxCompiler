package Mx.IR.Operand;

import Mx.IR.TypeSystem.PointerType;
import Mx.IR.TypeSystem.VoidType;

public class Null extends Constant {
    public Null() {
        super(new PointerType(new VoidType()));
    }

    @Override
    public String toString() {
        return "null";
    }
    @Override
    public boolean equals(Object obj) {
        return obj instanceof Null;
    }
}
