package Mx.IR.Operand;

import Mx.IR.Instruction.IRInst;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;

public class GlobalVariable extends Operand {
    private final String name;
    private Operand init;

    public GlobalVariable(IRType type, String name, Operand init) {
        super(type);
        this.name = name;
        this.init = init;
    }

    public String getName() {
        return name;
    }
    public Operand getInit() {
        return init;
    }
    public void setInit(Operand init) {
        this.init = init;
    }
    public String printToString() {
        assert getType() instanceof PointerType;
        if (init instanceof ConstString) {
            return "@" + name
                    + " = private unnamed_addr constant "
                    + init.toString() + ", align 1";
        }
        else {
            return "@" + name + " = global "
                    + ((PointerType) getType()).getBaseType().toString()
                    + " " + init.toString()
                    + ", align " + getType().size() / 8;
        }
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
