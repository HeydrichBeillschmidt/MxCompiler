package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.PointerType;

import java.util.HashSet;
import java.util.Map;
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
    public void severDF() {
        value.removeUse(this);
        addr.removeUse(this);
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
    public void refresh(Map<Operand, Operand> os, Map<IRBlock, IRBlock> bs) {
        if (value instanceof Parameter || value instanceof Register) value = os.get(value);
        if (addr instanceof Parameter || addr instanceof Register) addr = os.get(addr);
        value.addUse(this);
        addr.addUse(this);
    }

    @Override
    public IRInst copyToBlock(IRBlock block) {
        return new Store(block, value, addr);
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
