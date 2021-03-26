package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;

abstract public class IRInst {
    private IRBlock block;
    private IRInst prevInst;
    private IRInst nextInst;

    public IRInst(IRBlock block) {
        this.block = block;
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

    abstract public boolean isTerminalInst();
    abstract public String toString();
    abstract public void accept(IRVisitor visitor);
}
