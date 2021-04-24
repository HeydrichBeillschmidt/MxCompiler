package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRBuilder;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

import java.util.HashSet;
import java.util.Set;

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
    // sever data / control flow
    public void severDF() {}
    public void severCF() {}

    public boolean hasDst() {
        return getDst()!=Register.pseudoReg;
    }
    public Register getDst() {
        return Register.pseudoReg;
    }
    public boolean needWriteBack() {
        return false;
    }
    public boolean isNotTerminalInst() {
        return !(this instanceof Br || this instanceof Ret);
    }
    public boolean isCommonExpr(IRInst i) {
        return false;
    }
    public boolean hasNoSideEffect() {
        return this instanceof BinaryOp || this instanceof BitCast
                || this instanceof GetElementPtr || this instanceof Icmp;
    }
    abstract public void actuallyWritten();

    public Set<Operand> getUses() {
        return new HashSet<>();
    }
    public void replaceUse(Operand oldUse, Operand newUse) {}

    abstract public String toString();
    abstract public void accept(IRVisitor visitor);
}
