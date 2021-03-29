package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRBuilder;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.PointerType;

public class Store extends IRInst {
    private final Operand value;
    private final Operand addr;

    public Store(IRBlock block, Operand value, Operand addr) {
        super(block);
        this.value = value;
        this.addr = addr;
        value.addUse(this);
        addr.addUse(this);
        addUse(value);
        addUse(addr);

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
    public boolean needWriteBack() {
        return false;
    }
    @Override
    public Register getDst() {
        return IRBuilder.pseudoReg;
    }
    @Override
    public boolean isTerminalInst() {
        return false;
    }
    @Override
    public String toString() {
        return "store " + ((PointerType)addr.getType()).getBaseType().toString() + " "
                + value.toString() + ", "
                + addr.getType().toString() + " " + addr.toString()
                + ", align " + value.getType().size()/8;
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
