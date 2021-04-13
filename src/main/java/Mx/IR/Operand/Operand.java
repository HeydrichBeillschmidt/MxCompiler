package Mx.IR.Operand;

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

    abstract public boolean isConstant();
    abstract public String toString();
    public boolean equals(Object obj) {
        if (obj instanceof Operand)
            return toString().equals(obj.toString());
        return false;
    }
}
