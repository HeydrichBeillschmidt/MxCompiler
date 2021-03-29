package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;

public class Load extends IRInst {
    private final Register dst;
    private final IRType loadType;
    private final Operand addr;

    public Load(IRBlock block, Register dst,
                IRType loadType, Operand addr) {
        super(block);
        this.dst = dst;
        this.loadType = loadType;
        this.addr = addr;
        addr.addUse(this);
        dst.setDef(this);
        addUse(addr);

        assert addr.getType() instanceof PointerType;
        assert ((PointerType)addr.getType()).getBaseType().equals(loadType);
        assert dst.getType().equals(loadType);
    }

    public Register getDst() {
        return dst;
    }
    public IRType getLoadType() {
        return loadType;
    }
    public Operand getAddr() {
        return addr;
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public boolean isTerminalInst() {
        return false;
    }
    @Override
    public String toString() {
        return dst.toString() + " = load " + loadType.toString() + ", "
                + addr.getType().toString() + " " + addr.toString()
                + ", align " + dst.getType().size()/8;
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
