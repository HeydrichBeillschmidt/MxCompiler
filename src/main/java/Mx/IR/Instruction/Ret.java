package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;
import Mx.IR.TypeSystem.VoidType;

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Ret extends IRInst {
    private final IRType retType;
    private Operand retValue;

    public Ret(IRBlock block, IRType retType, Operand retValue) {
        super(block);
        this.retType = retType;
        this.retValue = retValue;
        if (!(retType instanceof VoidType)) {
            assert retType.equals(retValue.getType())
                    || (retValue instanceof Null && retType instanceof PointerType);
        }
        else assert retValue==null;
    }

    public IRType getRetType() {
        return retType;
    }
    public Operand getRetValue() {
        return retValue;
    }

    @Override
    public void actuallyWritten() {
        if (!(retType instanceof VoidType)) retValue.addUse(this);
    }
    @Override
    public void severDF() {
        if (!(retType instanceof VoidType)) retValue.removeUse(this);
    }

    @Override
    public Set<Operand> getUses() {
        if (!(retType instanceof VoidType)) {
            return new HashSet<>(Collections.singletonList(retValue));
        }
        return new HashSet<>();
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        if (retValue!=null && retValue==oldUse) {
            retValue.removeUse(this);
            retValue = newUse;
            retValue.addUse(this);
        }
    }
    @Override
    public void refresh(Map<Operand, Operand> os, Map<IRBlock, IRBlock> bs) {
        if (!(retType instanceof VoidType)) {
            if (retValue instanceof Parameter || retValue instanceof Register) retValue = os.get(retValue);
            retValue.addUse(this);
        }
    }

    @Override
    public IRInst copyToBlock(IRBlock block) {
        return new Ret(block, retType, retValue);
    }
    @Override
    public String toString() {
        if (retType instanceof VoidType)
            return "ret void";
        else
            return "ret " + retType.toString() + " " + retValue.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
