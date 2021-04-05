package Mx.ASM;

import Mx.ASM.Instruction.ASMInst;
import Mx.ASM.Operand.VirtualReg;
import Mx.IR.IRBlock;
import Mx.IR.Instruction.IRInst;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class ASMBlock {
    private final String name;
    private final String asmName;

    private final IRBlock irBlock;

    private final ASMFunction func;

    private ASMInst headInst;
    private ASMInst tailInst;

    private ASMBlock prevBlock;
    private ASMBlock nextBlock;

    //  for liveness analysis
    private final ArrayList<ASMBlock> predecessors;
    private final ArrayList<ASMBlock> successors;
    private Set<VirtualReg> uses;
    private Set<VirtualReg> defs;
    private Set<VirtualReg> liveIn;
    private Set<VirtualReg> liveOut;

    public ASMBlock(String name, String asmName, IRBlock irBlock, ASMFunction func) {
        this.name = name;
        this.asmName = asmName;
        this.irBlock = irBlock;
        this.func = func;
        this.prevBlock = null;
        this.nextBlock = null;
        this.predecessors = new ArrayList<>();
        this.successors = new ArrayList<>();
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
    public ASMFunction getFunc() {
        return func;
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
    public ArrayList<ASMInst> getAllInst() {
        ArrayList<ASMInst> ans = new ArrayList<>();
        ASMInst tmp = headInst;
        while (tmp!=null) {
            ans.add(tmp);
            tmp = tmp.getNextInst();
        }
        return ans;
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

    public void solveUsesAndDefs() {
        uses = new HashSet<>();
        defs = new HashSet<>();

        for (ASMInst inst = headInst; inst!=null; inst = inst.getNextInst()) {
            /* consider liveness analysis formula:
             * -- in[n] = use[n] U (out[n] - def[n])
             * -- out[n] = {U in[s] for s in successor[n]}
             * inside a basic block,
             * consider the sub-block p of all prev insts of current inst n,
             * we have out[p] = in[n], which would induce
             * -- in[p] = use[p] U ( (use[n] U (out[n]-def[n])) - def[p])
             * we have formula
             * -- (A U B) - C = (A - C) U (B - C)
             * -- (A - B) - C = A - (B U C)
             * which would induce
             * -- in[p] = use[p] U (use[n] - def[p]) U (out[n] - (def[n] U def[p]))
             * notice that in[p] and out[n] is also in[pn] and out[pn], so
             * -- use[pn] = use[p] U (use[n] - def[p])
             * -- def[pn] = def[n] U def[p]
             * so just traverse the block to get uses and defs of the total block.
             */
            Set<VirtualReg> curUse = new HashSet<>(inst.getUses());
            curUse.removeAll(defs);
            uses.addAll(curUse);
            defs.addAll(inst.getDefs());
        }

        liveIn = new HashSet<>();
        liveOut = new HashSet<>();
    }
    public Set<VirtualReg> getUses() {
        return uses;
    }
    public Set<VirtualReg> getDefs() {
        return defs;
    }
    public void collectLiveInsAndOuts(Set<VirtualReg> liveInNewer, Set<VirtualReg> liveOutNewer) {
        for (var s: successors) liveOutNewer.addAll(s.liveIn);
        liveInNewer.addAll(liveOutNewer);
        liveInNewer.removeAll(defs);
        liveInNewer.addAll(uses);
    }
    public Set<VirtualReg> getLiveIn() {
        return liveIn;
    }
    public void setLiveIn(Set<VirtualReg> liveIn) {
        this.liveIn = liveIn;
    }
    public Set<VirtualReg> getLiveOut() {
        return liveOut;
    }
    public void setLiveOut(Set<VirtualReg> liveOut) {
        this.liveOut = liveOut;
    }

    public String emitCode() {
        return asmName;
    }
    @Override
    public String toString() {
        return name;
    }

    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
