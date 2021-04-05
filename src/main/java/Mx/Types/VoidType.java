package Mx.Types;

import Mx.IR.Operand.Operand;

public class VoidType extends Type {
    public VoidType() {
        super("void");
    }

    @Override
    public Operand getDefaultValue() {
        // shouldn't be called.
        return null;
    }
}
