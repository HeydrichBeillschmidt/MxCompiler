package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Br extends IRInst {
    private Operand condition;
    private final IRBlock thenBlock;
    private final IRBlock elseBlock;

    public Br(IRBlock block, Operand condition,
              IRBlock thenBlock, IRBlock elseBlock) {
        super(block);
        this.condition = condition;
        this.thenBlock = thenBlock;
        this.elseBlock = elseBlock;
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
    public void actuallyWritten() {
        getBlock().addSuccessor(thenBlock);
        thenBlock.addPredecessor(getBlock());
        if (condition!=null) {
            getBlock().addSuccessor(elseBlock);
            elseBlock.addPredecessor(getBlock());

            condition.addUse(this);
        }
    }
    @Override
    public Set<Operand> getUses() {
        return new HashSet<>(Collections.singletonList(condition));
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        if (condition==oldUse) {
            condition.removeUse(this);
            condition = newUse;
            condition.addUse(this);
        }
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
