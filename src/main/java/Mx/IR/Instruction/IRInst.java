package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

abstract public class IRInst {
    private IRBlock block;
    private IRInst prevInst;
    private IRInst nextInst;

    private final Set<Operand> uses;

    public IRInst(IRBlock block) {
        this.block = block;

        this.uses = new HashSet<>();
    }

    public IRBlock getBlock() {
        return block;
    }
    public void setBlock(IRBlock block){
        this.block = block;
    }
    public IRInst getPrevInst() {
        return prevInst;
    }
    public void setPrevInst(IRInst prevInst) {
        this.prevInst = prevInst;
    }
    public IRInst getNextInst() {
        return nextInst;
    }
    public void setNextInst(IRInst nextInst) {
        this.nextInst = nextInst;
    }
    public void removeFromBlock() {
        if (prevInst==null) block.setHeadInst(nextInst);
        else prevInst.setNextInst(nextInst);
        if (nextInst==null) block.setTailInst(prevInst);
        else nextInst.setPrevInst(prevInst);
    }

    public Set<Operand> getUses() {
        return uses;
    }
    public void addUse(Operand opr) {
        if (opr!=null)
            uses.add(opr);
    }
    public void addUses(ArrayList<Operand> oprs) {
        uses.addAll(oprs);
    }

    abstract public Register getDst();
    abstract public boolean needWriteBack();
    abstract public boolean isTerminalInst();
    abstract public String toString();
    abstract public void accept(IRVisitor visitor);
}
