package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class BitCast extends IRInst {
    private final Register dst;
    private Operand src;
    private final IRType castType;

    public BitCast(IRBlock block, Register dst, Operand src, IRType castType) {
        super(block);
        this.dst = dst;
        this.src = src;
        this.castType = castType;
    }

    @Override
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
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public boolean isCommonExpr(IRInst i) {
        if (i instanceof BitCast) {
            BitCast inst = (BitCast) i;
            return src.equals(inst.src) && castType.equals(inst.castType);
        }
        return false;
    }
    @Override
    public void actuallyWritten() {
        src.addUse(this);
        dst.setDef(this);
    }
    @Override
    public void severDF() {
        src.removeUse(this);
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
    public void refresh(Map<Operand, Operand> os, Map<IRBlock, IRBlock> bs) {
        if (src instanceof Parameter || src instanceof Register) src = os.get(src);
        src.addUse(this);
    }

    @Override
    public IRInst copyToBlock(IRBlock block) {
        BitCast ans = new BitCast(block, dst.getCopy(), src, castType);
        ans.dst.setDef(ans);
        return ans;
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
