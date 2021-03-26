package Mx.IR.Operand;

import Mx.IR.TypeSystem.IRType;

public class Parameter extends Operand {
    private String name;

    public Parameter(IRType type, String name) {
        super(type);
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean isConstant() {
        return false;
    }
    @Override
    public String toString() {
        return "%" + name;
    }
}
