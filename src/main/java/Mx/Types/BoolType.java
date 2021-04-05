package Mx.Types;

import Mx.IR.Operand.ConstBool;
import Mx.IR.Operand.Operand;

public class BoolType extends Type {
    public BoolType() {
        super("bool");
    }

    @Override
    public Operand getDefaultValue() {
        return new ConstBool(false);
    }
}
