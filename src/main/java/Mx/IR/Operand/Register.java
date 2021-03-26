package Mx.IR.Operand;

import Mx.IR.Instruction.IRInst;
import Mx.IR.TypeSystem.IRType;

public class Register extends Operand {
    private String name;
    private IRInst def;

    public Register(IRType type, String name) {
        super(type);
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public IRInst getDef() {
        return def;
    }
    public void setDef(IRInst def) {
        this.def = def;
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
