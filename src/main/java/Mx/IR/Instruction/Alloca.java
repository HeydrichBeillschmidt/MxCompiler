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
        dst.setDef(this);

        assert (new PointerType(allocType)).equals(dst.getType());
    }

    public Register getDst() {
        return dst;
    }
    public IRType getAllocType() {
        return allocType;
    }

    @Override
    public boolean isTerminalInst() {
        return false;
    }
    @Override
    public String toString() {
        return dst.toString() + " = alloca " + allocType.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
