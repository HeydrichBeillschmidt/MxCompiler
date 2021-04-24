package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.IntegerType;
import Mx.IR.TypeSystem.PointerType;

import java.util.HashSet;
import java.util.Set;

public class Icmp extends IRInst {
    public enum IcmpOpName {
        eq, ne, slt, sge, sle, sgt
    }
    private final Register dst;
    private final IcmpOpName opName, opNameReversed;
    private final IRType type;
    private Operand op1;
    private Operand op2;

    public Icmp(IRBlock block, Register dst, IcmpOpName opName,
                    IRType type, Operand op1, Operand op2) {
        super(block);
        this.dst = dst;
        this.opName = opName;
        switch (opName) {
            case eq: opNameReversed=IcmpOpName.eq; break;
            case ne: opNameReversed=IcmpOpName.ne; break;
            case slt:opNameReversed=IcmpOpName.sgt;break;
            case sge:opNameReversed=IcmpOpName.sle;break;
            case sle:opNameReversed=IcmpOpName.sge;break;
            default: opNameReversed=IcmpOpName.slt;
        }
        this.type = type;
        this.op1 = op1;
        this.op2 = op2;

        assert type.equals(op1.getType())
                || (op1 instanceof Null && type instanceof PointerType);
        assert type.equals(op2.getType())
                || (op2 instanceof Null && type instanceof PointerType);
        assert dst.getType().equals(new IntegerType(1));
    }

    @Override
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
    public boolean isCommonExpr(IRInst i) {
        if (i instanceof Icmp) {
            Icmp inst = (Icmp) i;
            if (opName==inst.opName) {
                return op1.equals(inst.op1) && op2.equals(inst.op2);
            }
            else if (opName==inst.opNameReversed) {
                return op1.equals(inst.op2) && op2.equals(inst.op1);
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
            op2.removeUse(this);
            op2 = newUse;
            op2.addUse(this);
        }
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
