package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.*;
import Mx.IR.TypeSystem.PointerType;

public class Move extends IRInst {
    private final Register dst;
    private final Operand src;

    public Move(IRBlock block, Register dst, Operand src, boolean doAddUse) {
        super(block);
        this.dst = dst;
        this.src = src;
        if (doAddUse) {
            src.addUse(this);
            dst.setDef(this);
        }
        addUse(src);
        assert src.getType().equals(dst.getType())
                || (dst.getType() instanceof PointerType
                    && src instanceof Null);
        assert src instanceof Register
                || src instanceof Parameter
                || src instanceof Constant;
    }

    public Register getDst() {
        return dst;
    }
    public Operand getSrc() {
        return src;
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
        return "move " + dst.toString() + " " + src.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
