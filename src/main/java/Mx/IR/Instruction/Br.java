package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Br extends IRInst {
    private Operand condition;
    private IRBlock thenBlock;
    private IRBlock elseBlock;

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

    public void rewriteToJump(IRBlock dstBlock) {
        severDF();
        severCF();
        this.condition = null;
        this.thenBlock = dstBlock;
        this.elseBlock = null;
        actuallyWritten();
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
    public void severDF() {
        if (condition!=null) condition.removeUse(this);
    }
    @Override
    public void severCF() {
        getBlock().severCF(thenBlock);
        if (condition!=null) getBlock().severCF(elseBlock);
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
    public void refresh(Map<Operand, Operand> os, Map<IRBlock, IRBlock> bs) {
        if (condition!=null) {
            if (condition instanceof Parameter || condition instanceof Register) condition = os.get(condition);
            condition.addUse(this);
            elseBlock = bs.get(elseBlock);
        }
        thenBlock = bs.get(thenBlock);
    }

    @Override
    public IRInst copyToBlock(IRBlock block) {
        return new Br(block, condition, thenBlock, elseBlock);
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
