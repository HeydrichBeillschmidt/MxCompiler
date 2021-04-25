package Mx.IR.Operand;

import Mx.IR.IRBlock;
import Mx.IR.Instruction.Br;
import Mx.IR.Instruction.IRInst;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.VoidType;

public class Register extends Operand {
    private String name;
    private IRInst def;

    public static Register pseudoReg = new Register(new VoidType(), "");

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
    public boolean isForBranch(IRBlock block) {
        if (getUses().size()==1) {
            for (var u: getUses()) {
                if (u instanceof Br) return true;
            }
        }
        return false;
    }
    public Register getCopy() {
        return new Register(getType(), name);
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
