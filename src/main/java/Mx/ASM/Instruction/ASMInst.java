package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMVisitor;
import Mx.ASM.Operand.PhysicalReg;
import Mx.ASM.Operand.VirtualReg;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

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
    public void replaceByInst(ASMInst inst) {
        inst.prevInst = prevInst;
        if (prevInst!=null) prevInst.setNextInst(inst);
        else block.setHeadInst(inst);
        inst.nextInst = nextInst;
        if (nextInst!=null) nextInst.setPrevInst(inst);
        else block.setTailInst(inst);
    }
    public void removeSelfFromBlock() {
        if (nextInst!=null) nextInst.setPrevInst(prevInst);
        else block.setTailInst(prevInst);
        if (prevInst!=null) prevInst.setNextInst(nextInst);
        else block.setHeadInst(nextInst);
    }

    public boolean isUselessAddSP() {
        if (!(this instanceof IAL)) return false;
        IAL i = (IAL) this;
        return i.getOpName()==IAL.OpName.addi && i.getImm().getValue()==0
                && i.getRd().equals(PhysicalReg.spVR)
                && i.getRs1().equals(PhysicalReg.spVR);
    }

    public VirtualReg getRd() {
        return null;
    }
    public void setRd(VirtualReg rd) {}
    public void replaceRd(VirtualReg oldRd, VirtualReg newRd) {
        if (getRd()==oldRd) setRd(newRd);
    }
    public void replaceRs(VirtualReg oldRs, VirtualReg newRs) {}

    public Set<VirtualReg> getUses() {
        return new HashSet<>();
    }
    public Set<VirtualReg> getDefs() {
        return new HashSet<>();
    }

    public void countStackLen(int stackLen) {}

    abstract public String emitCode();
    @Override
    abstract public String toString();

    abstract public void accept(ASMVisitor visitor);
}
