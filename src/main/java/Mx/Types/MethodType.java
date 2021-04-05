package Mx.Types;

import Mx.IR.Operand.Operand;

public class MethodType extends Type {
    private final Type objectType;

    public MethodType(String name, Type objectType) {
        super(name);
        this.objectType = objectType;
    }

    public Type getObjectType() {
        return objectType;
    }

    @Override
    public Operand getDefaultValue() {
        // shouldn't be called.
        return null;
    }
}
