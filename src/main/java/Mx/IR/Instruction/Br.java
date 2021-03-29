package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRBuilder;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

public class Br extends IRInst {
    private final Operand condition;
    private final IRBlock thenBlock;
    private final IRBlock elseBlock;

    public Br(IRBlock block, Operand condition,
              IRBlock thenBlock, IRBlock elseBlock) {
        super(block);
        this.condition = condition;
        this.thenBlock = thenBlock;
        this.elseBlock = elseBlock;

        condition.addUse(this);
        addUse(condition);
    }

    public Operand getCondition() {
        return condition;
    }
    public IRBlock getElseBlock() {
        return elseBlock;
    }
    public IRBlock getThenBlock() {
        return thenBlock;
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
        if (condition!=null)
            return "br i1 " + condition.toString()
                    + ", label " + thenBlock.toString()
                    + ", label " + elseBlock.toString();
        else
            return "br label " + thenBlock.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
