package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

import java.util.HashSet;
import java.util.Set;

public class BinaryOp extends IRInst {
    public enum BinaryOpName {
        add, sub, mul, sdiv, srem,
        shl, ashr, and, or, xor
    }
    private final Register dst;
    private final BinaryOpName opName;
    private final Operand op1;
    private final Operand op2;
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
    public Operand getOp1() {
        return op1;
    }
    public Operand getOp2() {
        return op2;
    }
    public boolean isCommutable() {
        return commutable;
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public void actuallyWritten() {
        dst.setDef(this);
        op1.addUse(this);
        op2.addUse(this);
    }

    @Override
    public Set<Operand> getUses() {
        Set<Operand> ans = new HashSet<>();
        ans.add(op1);
        ans.add(op2);
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
