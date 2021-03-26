package Mx.IR.Operand;

import Mx.IR.TypeSystem.IRType;

abstract public class Constant extends Operand {
    public Constant(IRType type) {
        super(type);
    }

    @Override
    public boolean isConstant() {return true;}
    @Override
    abstract public boolean equals(Object obj);
}
