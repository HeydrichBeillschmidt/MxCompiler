package Mx.IR.Instruction;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRBuilder;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.VoidType;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class Call extends IRInst {
    private final Register dst;
    private final Function callee;
    private final ArrayList<Operand> parameterList;
    private final boolean voidCall;

    public Call(IRBlock block, Register dst, Function callee,
                ArrayList<Operand> parameterList) {
        super(block);
        this.dst = dst;
        this.callee = callee;
        this.parameterList = parameterList;

        if (dst.getType().equals(new VoidType())) {
            assert callee.getFunctionType().getReturnType().equals(new VoidType());
            this.voidCall = true;
        }
        else {
            assert dst.getType().equals(callee.getFunctionType().getReturnType());
            this.voidCall = false;
        }
        assert parameterList.size()==callee.getParameterList().size();
        for (int i = 0, it = parameterList.size(); i < it; ++i) {
            if (parameterList.get(i) instanceof Null)
                assert callee.getFunctionType().getParameterTypes().get(i) instanceof VoidType;
            else {
                assert parameterList.get(i).getType().equals(
                        callee.getFunctionType().getParameterTypes().get(i) );
            }
        }
    }

    @Override
    public Register getDst() {
        return dst;
    }
    public Function getCallee() {
        return callee;
    }
    public ArrayList<Operand> getParameterList() {
        return parameterList;
    }
    public boolean isVoidCall() {
        return voidCall;
    }

    @Override
    public boolean needWriteBack() {
        return dst!=IRBuilder.pseudoReg;
    }
    @Override
    public void actuallyWritten() {
        if (!voidCall) dst.setDef(this);
        parameterList.forEach(p -> p.addUse(this));
    }
    @Override
    public void severDF() {
        parameterList.forEach(p -> p.removeUse(this));
    }

    @Override
    public Set<Operand> getUses() {
        return new HashSet<>(parameterList);
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        for (int i = 0, it = parameterList.size(); i < it; ++i) {
            Operand p = parameterList.get(i);
            if (p==oldUse) {
                p.removeUse(this);
                parameterList.set(i, newUse);
                parameterList.get(i).addUse(this);
            }
        }
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder();
        if (!(dst.equals(IRBuilder.pseudoReg))) {
            string.append(dst.toString()).append(" = ");
        }
        string.append("call ");
        if (callee.getFunctionType().getReturnType()!=null) {
            string.append(callee.getFunctionType().getReturnType().toString());
        }
        else string.append("void");
        string.append(" @").append(callee.getName()).append("(");
        int it = parameterList.size();
        for (int i = 0; i < it; ++i) {
            string.append(callee.getParameterList().get(i).getType()).append(" ");
            string.append(parameterList.get(i).toString());
            if (i < it-1) string.append(", ");
        }
        string.append(")");
        return string.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
