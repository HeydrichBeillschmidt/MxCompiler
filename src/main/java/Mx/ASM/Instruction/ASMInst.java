package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

abstract public class ASMInst {
    private final ASMBlock block;
    private ASMInst prevInst;
    private ASMInst nextInst;

    //  for liveness analysis
    private final Set<VirtualReg> uses;
    private final Set<VirtualReg> defs;

    public ASMInst(ASMBlock block) {
        this.block = block;
        this.uses = new HashSet<>();
        this.defs = new HashSet<>();
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

    public Set<VirtualReg> getUses() {
        return uses;
    }
    public void addUse(VirtualReg pr) {
        if (pr!=null)
            uses.add(pr);
    }
    public void addUses(ArrayList<VirtualReg> prs) {
        uses.addAll(prs);
    }
    public Set<VirtualReg> getDefs() {
        return defs;
    }
    public void addDef(VirtualReg pr) {
        defs.add(pr);
    }
    public void addDefs(ArrayList<VirtualReg> prs) {
        defs.addAll(prs);
    }

    abstract public String emitCode();
    @Override
    abstract public String toString();
}
