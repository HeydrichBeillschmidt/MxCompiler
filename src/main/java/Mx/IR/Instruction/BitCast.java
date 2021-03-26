package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;

public class BitCast extends IRInst {
    private final Register dst;
    private final Operand src;
    private final IRType castType;

    public BitCast(IRBlock block, Register dst, Operand src, IRType castType) {
        super(block);
        this.dst = dst;
        this.src = src;
        this.castType = castType;
        dst.setDef(this);
    }

    public Register getDst() {
        return dst;
    }
    public Operand getSrc() {
        return src;
    }
    public IRType getCastType() {
        return castType;
    }

    @Override
    public boolean isTerminalInst() {
        return false;
    }
    @Override
    public String toString() {
        return dst.toString() + " = bitcast "
                + src.getType().toString() + " " + src.toString()
                + " to " + castType.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
