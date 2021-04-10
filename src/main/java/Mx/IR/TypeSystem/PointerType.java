package Mx.IR.TypeSystem;

import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;

public class PointerType extends IRType {
    private final IRType baseType;
    private final int dim;

    public PointerType(IRType baseType) {
        super();
        this.baseType = baseType;
        this.dim = baseType.getDim() + 1;
    }

    public IRType getBaseType() {
        return baseType;
    }
    @Override
    public int getDim() {
        return dim;
    }

    @Override
    public int size() {
        return 4;
    }
    @Override
    public String toString() {
        return baseType.toString() + "*";
    }

    @Override
    public Operand getDefaultValue() {
        return new Null();
    }
}
