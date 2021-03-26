package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

public class BinaryOp extends IRInst {
    public enum BinaryOpName {
        add, sub, mul, sdiv, srem,
        shl, ashr, and, or, xor
    }
    private final Register dst;
    private final BinaryOpName opName;
    private final Operand op1;
    private final Operand op2;

    public BinaryOp(IRBlock block, Register dst, BinaryOpName opName,
                    Operand op1, Operand op2) {
        super(block);
        this.dst = dst;
        this.opName = opName;
        this.op1 = op1;
        this.op2 = op2;
        dst.setDef(this);

        assert op1.getType().equals(dst.getType());
        assert op2.getType().equals(dst.getType());
    }

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

    @Override
    public boolean isTerminalInst() {
        return false;
    }
    @Override
    public String toString() {
        return dst.toString() + " = " + opName.toString() + dst.getType().toString()
                + op1.toString() + ", " + op2.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
