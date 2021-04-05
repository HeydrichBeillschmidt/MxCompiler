package Mx.Types;

import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;

public class NullType extends Type {
    public NullType() {
        super("null");
    }

    @Override
    public Operand getDefaultValue() {
        return new Null();
    }
}
