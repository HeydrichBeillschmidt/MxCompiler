package Mx.IR.Operand;

import Mx.IR.Instruction.BinaryOp;
import Mx.IR.Instruction.IRInst;
import Mx.IR.TypeSystem.IRType;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

abstract public class Operand {
    private final IRType type;

    private final Set<IRInst> uses;

    public Operand(IRType type) {
        this.type = type;

        this.uses = new HashSet<>();
    }

    public String getName() {
        return null;
    }
    public IRType getType() {
        return type;
    }

    public Set<IRInst> getUses() {
        return uses;
    }
    public void addUse(IRInst inst) {
        if (inst!=null) uses.add(inst);
    }
    public void addUses(ArrayList<IRInst> insts) {
        uses.addAll(insts);
    }
    public void removeUse(IRInst inst) {
        uses.remove(inst);
    }
    public void replaceUse(Operand newUse) {
        ArrayList<IRInst> instList = new ArrayList<>(uses);
        instList.forEach(u -> u.replaceUse(this, newUse));
        uses.clear();
    }

    public boolean genByCommutativeIType() {
        if (!(this instanceof Register)) return false;
        IRInst defInst = ((Register)this).getDef();
        if (!(defInst instanceof BinaryOp)) return false;
        BinaryOp bi = (BinaryOp) defInst;
        if (!bi.isCommutable()) return false;
        return (bi.getOp1() instanceof ConstInt && bi.getOp2() instanceof Register)
                || (bi.getOp2() instanceof ConstInt && bi.getOp1() instanceof Register);
    }

    abstract public boolean isConstant();
    abstract public String toString();
    public boolean equals(Object obj) {
        if (obj instanceof Operand)
            return toString().equals(obj.toString());
        return false;
    }
}
