package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.TypeSystem.PointerType;

import java.util.HashSet;
import java.util.Set;

public class Store extends IRInst {
    private Operand value;
    private Operand addr;

    public Store(IRBlock block, Operand value, Operand addr) {
        super(block);
        this.value = value;
        this.addr = addr;

        assert addr.getType() instanceof PointerType;
        assert ((PointerType)addr.getType()).getBaseType().equals(value.getType())
                || value instanceof Null;
    }

    public Operand getValue() {
        return value;
    }
    public Operand getAddr() {
        return addr;
    }

    @Override
    public void actuallyWritten() {
        value.addUse(this);
        addr.addUse(this);
    }

    @Override
    public Set<Operand> getUses() {
        Set<Operand> ans = new HashSet<>();
        ans.add(value);
        ans.add(addr);
        return ans;
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        if (value==oldUse) {
            value.removeUse(this);
            value = newUse;
            value.addUse(this);
        }
        if (addr==oldUse) {
            addr.removeUse(this);
            addr = newUse;
            addr.addUse(this);
        }
    }

    @Override
    public String toString() {
        return "store " + ((PointerType)addr.getType()).getBaseType().toString() + " "
                + value.toString() + ", "
                + addr.getType().toString() + " " + addr.toString()
                + ", align " + value.getType().size();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
