package Mx.IR;

import Mx.IR.Instruction.Alloca;
import Mx.IR.Instruction.Br;
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

    private int loopDepth;

    // for dominance analysis
    private int blockCnt;
    //     -- dominance frontier
    private Set<IRBlock> DF;
    //     -- immediate dominator
    private IRBlock iDom;
    //     -- reversed dominance frontier
    private Set<IRBlock> RDF;
    //     -- post immediate dominator
    private IRBlock postIDom;
    // for SSA
    private Map<Alloca, Phi> phiMap;
    private Map<Alloca, Operand> renameTable;
    // for ADCE
    private boolean marked;

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
    public void replaceInst(IRInst oldInst, IRInst newInst) {
        if (oldInst.getPrevInst()!=null) {
            IRInst prev = oldInst.getPrevInst();
            oldInst.severDF();
            oldInst.severCF();
            oldInst.removeFromBlock();
            if (prev.getNextInst()!=null) addNextInst(prev, newInst);
            else addInst(newInst);
        }
        else if (oldInst.getNextInst()!=null) {
            IRInst next = oldInst.getNextInst();
            oldInst.severDF();
            oldInst.severCF();
            oldInst.removeFromBlock();
            addPrevInst(next, newInst);
        }
        else {
            oldInst.severDF();
            oldInst.severCF();
            oldInst.removeFromBlock();
            addInst(newInst);
        }
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
        block.nextBlock = nextBlock;
        if (nextBlock!=null) {
            nextBlock.prevBlock = block;
        }
        nextBlock = block;
        block.prevBlock = this;
    }

    public ArrayList<IRBlock> getPredecessors() {
        return predecessors;
    }
    public void addPredecessor(IRBlock predecessor) {
        predecessors.add(predecessor);
    }
    public void replacePredecessor(IRBlock oldPre, IRBlock newPre) {
        if (predecessors.contains(oldPre)) {
            predecessors.remove(oldPre);
            predecessors.add(newPre);
            getAllPhi().forEach(ph -> ph.replaceEntry(oldPre, newPre));
        }
    }
    public ArrayList<IRBlock> getSuccessors() {
        return successors;
    }
    public void addSuccessor(IRBlock successor) {
        successors.add(successor);
    }
    public void replaceSuccessor(IRBlock oldSuc, IRBlock newSuc) {
        assert tailInst instanceof Br;
        Br oldTail = (Br) tailInst;
        Br newTail;
        if (oldTail.getCondition()==null) {
            newTail = new Br(this, null, newSuc, null);
        }
        else {
            if (oldTail.getThenBlock()==oldSuc) {
                newTail = new Br(this, oldTail.getCondition(), newSuc, oldTail.getElseBlock());
            }
            else {
                newTail = new Br(this, oldTail.getCondition(), oldTail.getThenBlock(), newSuc);
            }
        }
        replaceInst(oldTail, newTail);
    }
    public boolean checkAndMerge(Function f) {
        if (predecessors.size()==1) {
            IRBlock merged = predecessors.get(0);
            if (merged.getSuccessors().size()==1) {
                // deal with inst
                merged.tailInst.removeFromBlock();
                ArrayList<IRInst> instList = getAllInst();
                for (var i: instList) {
                    if (i instanceof Phi) {
                        i.getDst().replaceUse(((Phi) i).getValues().get(0));
                        i.severDF();
                        i.removeFromBlock();
                    }
                    else {
                        i.setBlock(merged);
                        if (i==headInst) {
                            i.setPrevInst(merged.tailInst);
                            if (merged.headInst==null) merged.headInst = i;
                            else merged.tailInst.setNextInst(i);
                        }
                    }
                }
                merged.tailInst = tailInst;
                // deal with linked list
                if (this==f.getEntranceBlock()) f.setEntranceBlock(nextBlock);
                else prevBlock.setNextBlock(nextBlock);
                if (this==f.getExitBlock()) f.setExitBlock(prevBlock);
                else nextBlock.setPrevBlock(prevBlock);
                // deal with control flow
                merged.successors.clear();
                merged.successors.addAll(successors);
                merged.successors.forEach(suc -> suc.replacePredecessor(this, merged));
                return true;
            }
        }
        return false;
    }
    public IRBlock split(Function f, IRInst inst) {
        IRBlock splitBlock = new IRBlock("inline.end");

        splitBlock.headInst = inst.getNextInst();
        splitBlock.tailInst = tailInst;
        tailInst = inst;
        inst.getNextInst().setPrevInst(null);
        inst.setNextInst(null);
        splitBlock.getAllInst().forEach(i -> i.setBlock(splitBlock));

        // notice: the control flows between the split blocks are blank for following options
        splitBlock.successors.addAll(successors);
        successors.forEach(s -> s.replacePredecessor(this, splitBlock));
        successors.clear();

        f.addNextBlock(this, splitBlock);
        return splitBlock;
    }
    // sever the control flow with a particular successor
    public void severCF(IRBlock successor) {
        successor.predecessors.remove(this);
        successor.getAllPhi().forEach(ph -> ph.removeEntry(this));
        successors.remove(successor);
    }
    // sever all control flow
    public void severCF() {
        for (var s: successors) {
            s.predecessors.remove(this);
            s.getAllPhi().forEach(ph -> ph.removeEntry(this));
        }
        predecessors.forEach(p -> p.successors.remove(this));
    }

    public int getLoopDepth() {
        return loopDepth;
    }
    public void setLoopDepth(int loopDepth) {
        this.loopDepth = loopDepth;
    }

    // for dominance analysis
    //     forward control flow analysis
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
    public boolean isDomed(IRBlock query) {
        IRBlock dom = iDom;
        while (dom!=null) {
            if (dom==query) return true;
            dom = dom.iDom;
        }
        return false;
    }
    //     backward control flow analysis
    public void initPostDomInfo() {
        RDF = new HashSet<>();
        postIDom = null;
    }
    public Set<IRBlock> getRDF() {
        return RDF;
    }
    public void addRDF(IRBlock rdf) {
        RDF.add(rdf);
    }
    public IRBlock getPostIDom() {
        return postIDom;
    }
    public void setPostIDom(IRBlock postIDom) {
        this.postIDom = postIDom;
    }
    public boolean isPostDomed(IRBlock query) {
        IRBlock dom = postIDom;
        while (dom!=null) {
            if (dom==query) return true;
            dom = dom.postIDom;
        }
        return false;
    }

    // for ADCE
    public void initMark() {
        marked = false;
    }
    public void mark() {
        marked = true;
    }
    public IRBlock nearestMarkedPostDom() {
        assert !marked;
        IRBlock ans = postIDom;
        while (ans!=null && !ans.marked) {
            ans = ans.getPostIDom();
        }
        return ans;
    }

    // for SSA
    //     SSA construct
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
    public boolean hasNoRename(Alloca a) {
        return !renameTable.containsKey(a);
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
    //     SSA destruct
    public ArrayList<Phi> getAllPhi() {
        ArrayList<Phi> ans = new ArrayList<>();
        IRInst ptr = headInst;
        while (ptr instanceof Phi) {
            ans.add((Phi) ptr);
            ptr = ptr.getNextInst();
        }
        return ans;
    }
    public void removeAllPhi() {
        ArrayList<Phi> phiList = getAllPhi();
        for (var ph: phiList) {
            ph.severDF();
            ph.removeFromBlock();
        }
    }

    // for inline
    public IRBlock getCopy() {
        IRBlock ans = new IRBlock("inline_"+name);
        getAllInst().forEach(i -> ans.addInstAtCopy(i.copyToBlock(ans)));
        ans.successors.addAll(successors);
        ans.predecessors.addAll(predecessors);
        return ans;
    }
    private void addInstAtCopy(IRInst inst) {
        if (headInst==null) headInst = tailInst = inst;
        else {
            tailInst.setNextInst(inst);
            inst.setPrevInst(tailInst);
            tailInst = inst;
        }
    }
    @Override
    public String toString() {
        return "%" + name;
    }
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
