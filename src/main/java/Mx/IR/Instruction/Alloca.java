package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;

public class Alloca extends IRInst {
    private final Register dst;
    private final IRType allocType;

    public Alloca(IRBlock block, Register dst, IRType allocType) {
        super(block);
        this.dst = dst;
        this.allocType = allocType;

        assert (new PointerType(allocType)).equals(dst.getType());
    }

    @Override
    public Register getDst() {
        return dst;
    }
    public IRType getAllocType() {
        return allocType;
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public void actuallyWritten() {
        dst.setDef(this);
    }

    @Override
    public String toString() {
        return dst.toString() + " = alloca " + allocType.toString()
                + ", align " + allocType.size()/8;
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
