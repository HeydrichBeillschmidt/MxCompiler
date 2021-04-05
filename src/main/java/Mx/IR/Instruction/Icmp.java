package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.IntegerType;
import Mx.IR.TypeSystem.PointerType;

public class Icmp extends IRInst {
    public enum IcmpOpName {
        eq, ne, slt, sge, sle, sgt
    }
    private final Register dst;
    private final IcmpOpName opName;
    private final IRType type;
    private final Operand op1;
    private final Operand op2;

    public Icmp(IRBlock block, Register dst, IcmpOpName opName,
                    IRType type, Operand op1, Operand op2) {
        super(block);
        this.dst = dst;
        this.opName = opName;
        this.type = type;
        this.op1 = op1;
        this.op2 = op2;
        op1.addUse(this);
        op2.addUse(this);
        dst.setDef(this);
        addUse(op1);
        addUse(op2);

        assert type.equals(op1.getType())
                || (op1 instanceof Null && type instanceof PointerType);
        assert type.equals(op2.getType())
                || (op2 instanceof Null && type instanceof PointerType);
        assert dst.getType().equals(new IntegerType(1));
    }

    public Register getDst() {
        return dst;
    }
    public IcmpOpName getOpName() {
        return opName;
    }
    public IRType getType() {
        return type;
    }
    public Operand getOp1() {
        return op1;
    }
    public Operand getOp2() {
        return op2;
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
        return dst.toString() +" = icmp " + opName.toString() +" " + type.toString()
                + " " + op1.toString() + ", " + op2.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
