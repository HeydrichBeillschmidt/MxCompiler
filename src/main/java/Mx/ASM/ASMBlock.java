package Mx.ASM;

import Mx.ASM.Instruction.ASMInst;
import Mx.IR.IRBlock;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class ASMBlock {
    private final String name;
    private final String asmName;

    private final IRBlock irBlock;

    private ASMInst headInst;
    private ASMInst tailInst;

    private ASMBlock prevBlock;
    private ASMBlock nextBlock;

    //  for liveness analysis
    private final ArrayList<ASMBlock> predecessors;
    private final ArrayList<ASMBlock> successors;
    private final Set<ASMBlock> uses;
    private final Set<ASMBlock> defs;

    public ASMBlock(String name, String asmName, IRBlock irBlock) {
        this.name = name;
        this.asmName = asmName;
        this.irBlock = irBlock;
        this.prevBlock = null;
        this.nextBlock = null;
        this.predecessors = new ArrayList<>();
        this.successors = new ArrayList<>();
        this.uses = new HashSet<>();
        this.defs = new HashSet<>();
    }

    public String getName() {
        return name;
    }
    public String getAsmName() {
        return asmName;
    }
    public IRBlock getIRBlock() {
        return irBlock;
    }

    public ASMInst getHeadInst() {
        return headInst;
    }
    public void setHeadInst(ASMInst headInst) {
        this.headInst = headInst;
    }
    public ASMInst getTailInst() {
        return tailInst;
    }
    public void setTailInst(ASMInst tailInst) {
        this.tailInst = tailInst;
    }
    public void addInst(ASMInst inst) {
        if (headInst==null) headInst = tailInst = inst;
        else {
            tailInst.setNextInst(inst);
            inst.setPrevInst(tailInst);
            tailInst = inst;
        }
    }
    public void addInstAtHead(ASMInst inst) {
        if (headInst==null) headInst = tailInst = inst;
        else {
            headInst.setPrevInst(inst);
            inst.setNextInst(headInst);
            headInst = inst;
        }
    }
    public void addPrevInst(ASMInst target, ASMInst instToAdd) {
        if (target.getPrevInst()==null) headInst = instToAdd;
        else {
            target.getPrevInst().setNextInst(instToAdd);
            instToAdd.setPrevInst(target.getPrevInst());
        }
        target.setPrevInst(instToAdd);
        instToAdd.setNextInst(target);
    }
    public void addNextInst(ASMInst target, ASMInst instToAdd) {
        assert target.getNextInst()!=null;
        target.getNextInst().setPrevInst(instToAdd);
        instToAdd.setNextInst(target.getNextInst());
        target.setNextInst(instToAdd);
        instToAdd.setPrevInst(target);
    }

    public ASMBlock getPrevBlock() {
        return prevBlock;
    }
    public void setPrevBlock(ASMBlock prevBlock) {
        this.prevBlock = prevBlock;
    }
    public ASMBlock getNextBlock() {
        return nextBlock;
    }
    public void setNextBlock(ASMBlock nextBlock) {
        this.nextBlock = nextBlock;
    }
    public boolean hasNextBlock() {
        return nextBlock!=null;
    }
    public void addBlock(ASMBlock block) {
        this.nextBlock = block;
        block.prevBlock = this;
    }

    public boolean hasPredecessors() {
        return predecessors.size()!=0;
    }
    public ArrayList<ASMBlock> getPredecessors() {
        return predecessors;
    }
    public void addPredecessor(ASMBlock predecessor) {
        predecessors.add(predecessor);
    }
    public boolean hasSuccessors() {
        return successors.size()!=0;
    }
    public ArrayList<ASMBlock> getSuccessors() {
        return successors;
    }
    public void addSuccessor(ASMBlock successor) {
        successors.add(successor);
    }

    public Set<ASMBlock> getUses() {
        return uses;
    }
    public void addUse(ASMBlock b) {
        uses.add(b);
    }
    public Set<ASMBlock> getDefs() {
        return defs;
    }
    public void addDef(ASMBlock b) {
        defs.add(b);
    }

    public String emitCode() {
        return asmName;
    }
    @Override
    public String toString() {
        return name;
    }
}
