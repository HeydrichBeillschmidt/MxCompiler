package Mx.IR.Operand;

import Mx.IR.Instruction.IRInst;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;

public class GlobalVariable extends Operand {
    private final String name;

    public GlobalVariable(IRType type, String name) {
        super(type);
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public String printToString() {
        assert getType() instanceof PointerType;
        return "@" + name + " = global "
                + ((PointerType)getType()).getBaseType().toString()
                + " zeroinitializer, align " + getType().size()/8;
    }

    @Override
    public boolean isConstant() {
        return false;
    }
    @Override
    public String toString() {
        return "@" + name;
    }
}
