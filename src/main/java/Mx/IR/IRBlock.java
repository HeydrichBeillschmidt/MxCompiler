package Mx.IR;

import Mx.IR.Instruction.IRInst;

import java.util.ArrayList;

public class IRBlock {
    private String name;

    private IRInst headInst;
    private IRInst tailInst;

    private IRBlock prevBlock;
    private IRBlock nextBlock;

    private final ArrayList<IRBlock> predecessors;
    private final ArrayList<IRBlock> successors;

    public IRBlock(String name) {
        this.name = name;
        this.headInst = null;
        this.tailInst = null;
        this.prevBlock = null;
        this.nextBlock = null;
        this.predecessors = new ArrayList<>();
        this.successors = new ArrayList<>();
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public IRInst getHeadInst() {
        return headInst;
    }
    public void setHeadInst(IRInst headInst) {
        this.headInst = headInst;
    }
    public IRInst getTailInst() {
        return tailInst;
    }
    public void setTailInst(IRInst tailInst) {
        this.tailInst = tailInst;
    }
    public void addInst(IRInst inst) {
        if (headInst==null) headInst = tailInst = inst;
        else {
            tailInst.setNextInst(inst);
            inst.setPrevInst(tailInst);
            tailInst = inst;
        }
    }
    public void addInstAtHead(IRInst inst) {
        if (headInst==null) headInst = tailInst = inst;
        else {
            headInst.setPrevInst(inst);
            inst.setNextInst(headInst);
            headInst = inst;
        }
    }
    public void addPrevInst(IRInst target, IRInst instToAdd) {
        if (target.getPrevInst()==null) headInst = instToAdd;
        else {
            target.getPrevInst().setNextInst(instToAdd);
            instToAdd.setPrevInst(target.getPrevInst());
        }
        target.setPrevInst(instToAdd);
        instToAdd.setNextInst(target);
    }
    public void addNextInst(IRInst target, IRInst instToAdd) {
        assert target.getNextInst()!=null;
        target.getNextInst().setPrevInst(instToAdd);
        instToAdd.setNextInst(target.getNextInst());
        target.setNextInst(instToAdd);
        instToAdd.setPrevInst(target);
    }
    public ArrayList<IRInst> getAllInst() {
        ArrayList<IRInst> ans = new ArrayList<>();
        IRInst tmp = headInst;
        while (tmp!=null) {
            ans.add(tmp);
            tmp = tmp.getNextInst();
        }
        return ans;
    }
    public boolean endWithTerminalInst() {
        return tailInst!=null && tailInst.isTerminalInst();
    }

    public IRBlock getPrevBlock() {
        return prevBlock;
    }
    public void setPrevBlock(IRBlock prevBlock) {
        this.prevBlock = prevBlock;
    }
    public boolean hasNextBlock() {return nextBlock!=null;}
    public IRBlock getNextBlock() {
        return nextBlock;
    }
    public void setNextBlock(IRBlock nextBlock) {
        this.nextBlock = nextBlock;
    }
    public void addBlock(IRBlock block) {
        this.nextBlock = block;
        block.prevBlock = this;
    }

    public boolean hasPredecessors() {
        return predecessors.size()!=0;
    }
    public ArrayList<IRBlock> getPredecessors() {
        return predecessors;
    }
    public void addPredecessor(IRBlock predecessor) {
        predecessors.add(predecessor);
    }
    public boolean hasSuccessors() {
        return successors.size()!=0;
    }
    public ArrayList<IRBlock> getSuccessors() {
        return successors;
    }
    public void addSuccessor(IRBlock successor) {
        successors.add(successor);
    }

    @Override
    public String toString() {
        return "%" + name;
    }
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
