package Mx.IR.TypeSystem;

import Mx.IR.Operand.Operand;

public class VoidType extends IRType {
    public VoidType() {
        super();
    }

    @Override
    public int size() {
        return 0;
    }
    @Override
    public String toString() {
        return "void";
    }

    @Override
    public Operand getDefaultValue() {
        return null;
    }
}
