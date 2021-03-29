package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRBuilder;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;
import Mx.IR.TypeSystem.VoidType;

public class Ret extends IRInst {
    private final IRType retType;
    private final Operand retValue;

    public Ret(IRBlock block, IRType retType, Operand retValue) {
        super(block);
        this.retType = retType;
        this.retValue = retValue;
        if (!(retType instanceof VoidType)) {
            assert retType.equals(retValue.getType())
                    || (retValue instanceof Null && retType instanceof PointerType);
            retValue.addUse(this);
            addUse(retValue);
        }
        else {
            assert retValue==null;
        }
    }

    public IRType getRetType() {
        return retType;
    }
    public Operand getRetValue() {
        return retValue;
    }

    @Override
    public boolean needWriteBack() {
        return false;
    }
    @Override
    public Register getDst() {
        return IRBuilder.pseudoReg;
    }
    @Override
    public boolean isTerminalInst() {
        return true;
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
