package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.*;
import Mx.IR.TypeSystem.PointerType;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Move extends IRInst {
    private final Register dst;
    private Operand src;

    public Move(IRBlock block, Register dst, Operand src) {
        super(block);
        this.dst = dst;
        this.src = src;

        assert src.getType().equals(dst.getType())
                || (dst.getType() instanceof PointerType
                    && src instanceof Null);
        assert src instanceof Register
                || src instanceof Parameter
                || src instanceof Constant;
    }

    @Override
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
    public void actuallyWritten() {
        dst.setDef(this);
        src.addUse(this);
    }

    @Override
    public Set<Operand> getUses() {
        return new HashSet<>(Collections.singletonList(src));
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        if (src==oldUse) {
            src.removeUse(this);
            src = newUse;
            src.addUse(this);
        }
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
