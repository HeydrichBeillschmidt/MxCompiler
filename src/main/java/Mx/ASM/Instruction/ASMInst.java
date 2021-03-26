package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;

abstract public class ASMInst {
    private final ASMBlock block;
    private ASMInst prevInst;
    private ASMInst nextInst;

    public ASMInst(ASMBlock block) {
        this.block = block;
    }

    public ASMBlock getBlock() {
        return block;
    }
    public ASMInst getPrevInst() {
        return prevInst;
    }
    public void setPrevInst(ASMInst prevInst) {
        this.prevInst = prevInst;
    }
    public ASMInst getNextInst() {
        return nextInst;
    }
    public void setNextInst(ASMInst nextInst) {
        this.nextInst = nextInst;
    }
}
