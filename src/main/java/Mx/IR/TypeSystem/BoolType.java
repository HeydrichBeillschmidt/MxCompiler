package Mx.IR.TypeSystem;

import Mx.IR.Operand.ConstBool;
import Mx.IR.Operand.Operand;

public class BoolType extends IRType {
    public BoolType() {
        super();
    }

    @Override
    public int size() {
        return 1;
    }
    @Override
    public String toString() {
        return "i1";
    }

    @Override
    public Operand getDefaultValue() {
        return new ConstBool(false);
    }
}
