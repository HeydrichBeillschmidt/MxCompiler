package Mx.Types;

import Mx.IR.Operand.ConstInt;
import Mx.IR.Operand.Operand;

public class IntType extends Type {
    public IntType() {
        super("int");
    }

    @Override
    public Operand getDefaultValue() {
        return new ConstInt(0, 32);
    }
}
