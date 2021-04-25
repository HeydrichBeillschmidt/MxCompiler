package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class BinaryOp extends IRInst {
    public enum BinaryOpName {
        add, sub, mul, sdiv, srem,
        shl, ashr, and, or, xor
    }
    private final Register dst;
    private BinaryOpName opName;
    private Operand op1;
    private Operand op2;
    private final boolean commutable;

    public BinaryOp(IRBlock block, Register dst, BinaryOpName opName,
                    Operand op1, Operand op2) {
        super(block);
        this.dst = dst;
        this.opName = opName;
        this.op1 = op1;
        this.op2 = op2;
        this.commutable = opName==BinaryOpName.add || opName==BinaryOpName.mul
                || opName==BinaryOpName.and || opName==BinaryOpName.or
                || opName==BinaryOpName.xor;

        assert op1.getType().equals(dst.getType());
        assert op2.getType().equals(dst.getType());
    }

    @Override
    public Register getDst() {
        return dst;
    }
    public BinaryOpName getOpName() {
        return opName;
    }
    public void setOpName(BinaryOpName opName) {
        this.opName = opName;
    }
    public Operand getOp1() {
        return op1;
    }
    public void setOp1(Operand op1) {
        this.op1 = op1;
    }
    public void replaceOp1(Operand op1) {
        this.op1.removeUse(this);
        this.op1 = op1;
        this.op1.addUse(this);
    }
    public Operand getOp2() {
        return op2;
    }
    public void setOp2(Operand op2) {
        this.op2 = op2;
    }
    public void replaceOp2(Operand op2) {
        this.op2.removeUse(this);
        this.op2 = op2;
        this.op2.addUse(this);
    }
    public void rewrite(BinaryOpName opName, Operand op1, Operand op2) {
        this.opName = opName;
        this.op1.removeUse(this);
        this.op2.removeUse(this);
        this.op1 = op1;
        this.op2 = op2;
        op1.addUse(this);
        op2.addUse(this);
    }
    public boolean isCommutable() {
        return commutable;
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public boolean isCommonExpr(IRInst i) {
        if (i instanceof BinaryOp) {
            BinaryOp inst = (BinaryOp) i;
            if (opName==inst.opName) {
                if (commutable) {
                    return (op1.equals(inst.op1) && op2.equals(inst.op2))
                            || (op1.equals(inst.op2) && op2.equals(inst.op1));
                }
                return op1.equals(inst.op1) && op2.equals(inst.op2);
            }
        }
        return false;
    }
    @Override
    public void actuallyWritten() {
        dst.setDef(this);
        op1.addUse(this);
        op2.addUse(this);
    }
    @Override
    public void severDF() {
        op1.removeUse(this);
        op2.removeUse(this);
    }

    @Override
    public Set<Operand> getUses() {
        Set<Operand> ans = new HashSet<>();
        ans.add(op1);
        ans.add(op2);
        return ans;
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        if (op1==oldUse) {
            op1.removeUse(this);
            op1 = newUse;
            op1.addUse(this);
        }
        if (op2==oldUse) {
            op1.removeUse(this);
            op2 = newUse;
            op2.addUse(this);
        }
    }
    @Override
    public void refresh(Map<Operand, Operand> os, Map<IRBlock, IRBlock> bs) {
        if (op1 instanceof Parameter || op1 instanceof Register) op1 = os.get(op1);
        if (op2 instanceof Parameter || op2 instanceof Register) op2 = os.get(op2);
        op1.addUse(this);
        op2.addUse(this);
    }

    @Override
    public IRInst copyToBlock(IRBlock block) {
        BinaryOp ans = new BinaryOp(block, dst.getCopy(), opName, op1, op2);
        ans.dst.setDef(ans);
        return ans;
    }
    @Override
    public String toString() {
        return dst.toString() + " = " + opName.toString() + " " + dst.getType().toString()
                + " " + op1.toString() + ", " + op2.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
