package Mx.IR;

import Mx.IR.Instruction.Alloca;
import Mx.IR.Instruction.IRInst;
import Mx.IR.Instruction.Phi;
import Mx.IR.Operand.Operand;

import java.util.*;

public class IRBlock {
    private String name;

    private IRInst headInst;
    private IRInst tailInst;

    private IRBlock prevBlock;
    private IRBlock nextBlock;

    private final ArrayList<IRBlock> predecessors;
    private final ArrayList<IRBlock> successors;

    // for dominance analysis
    private int blockCnt;
    //     -- dominance frontier
    private Set<IRBlock> DF;
    //     -- immediate dominator
    private IRBlock iDom;
    // for SSA
    private Map<Alloca, Phi> phiMap;
    private Map<Alloca, Operand> renameTable;

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
        boolean actuallyWritten = true;
        if (headInst==null) headInst = tailInst = inst;
        else if (tailInst.isNotTerminalInst()) {
            tailInst.setNextInst(inst);
            inst.setPrevInst(tailInst);
            tailInst = inst;
        }
        else actuallyWritten = false;
        if (actuallyWritten) inst.actuallyWritten();
    }
    public void addInstAtHead(IRInst inst) {
        if (headInst==null) headInst = tailInst = inst;
        else {
            headInst.setPrevInst(inst);
            inst.setNextInst(headInst);
            headInst = inst;
        }
        inst.actuallyWritten();
    }
    public void addPrevInst(IRInst target, IRInst instToAdd) {
        if (target.getPrevInst()==null) headInst = instToAdd;
        else {
            target.getPrevInst().setNextInst(instToAdd);
            instToAdd.setPrevInst(target.getPrevInst());
        }
        target.setPrevInst(instToAdd);
        instToAdd.setNextInst(target);
        instToAdd.actuallyWritten();
    }
    public void addNextInst(IRInst target, IRInst instToAdd) {
        assert target.getNextInst()!=null;
        target.getNextInst().setPrevInst(instToAdd);
        instToAdd.setNextInst(target.getNextInst());
        target.setNextInst(instToAdd);
        instToAdd.setPrevInst(target);
        instToAdd.actuallyWritten();
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
    public boolean endWithNonTerminalInst() {
        return tailInst == null || tailInst.isNotTerminalInst();
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

    // for dominance analysis
    public int getBlockCnt() {
        return blockCnt;
    }
    public void setBlockCnt(int blockCnt) {
        this.blockCnt = blockCnt;
    }
    public void initDomInfo() {
        DF = new HashSet<>();
        iDom = null;
    }
    public Set<IRBlock> getDF() {
        return DF;
    }
    public void addDF(IRBlock df) {
        DF.add(df);
    }
    public IRBlock getIDom() {
        return iDom;
    }
    public void setIDom(IRBlock iDom) {
        this.iDom = iDom;
    }

    // for SSA
    public void initSSA() {
        phiMap = new HashMap<>();
        renameTable = new HashMap<>();
    }
    public Set<Alloca> getPseudoDefs() {
        return phiMap.keySet();
    }
    public boolean hasPseudoDef(Alloca a) {
        return phiMap.containsKey(a);
    }
    public void addPhi(Alloca a, Phi p) {
        phiMap.put(a, p);
    }
    public Phi getPhi(Alloca a) {
        return phiMap.get(a);
    }
    public boolean hasRename(Alloca a) {
        return renameTable.containsKey(a);
    }
    public void addRename(Alloca a, Operand n) {
        renameTable.put(a, n);
    }
    public Operand getRename(Alloca a) {
        return renameTable.get(a);
    }
    public void replaceRename(Alloca a, Operand n) {
        renameTable.replace(a, n);
    }
    public void instantiatePhi() {
        phiMap.values().forEach(this::addInstAtHead);
    }

    @Override
    public String toString() {
        return "%" + name;
    }
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
