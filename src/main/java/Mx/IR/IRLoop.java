package Mx.IR;

import Mx.IR.Instruction.IRInst;
import Mx.IR.Operand.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class IRLoop {
    private final Set<IRBlock> blocks;
    private final Set<IRBlock> tails;
    private final Set<IRLoop> children;
    private IRBlock preHeader;

    public IRLoop() {
        blocks = new HashSet<>();
        tails = new HashSet<>();
        children = new HashSet<>();
    }

    public Set<IRBlock> getBlocks() {
        return blocks;
    }
    public void addBlocks(Set<IRBlock> blocks) {
        this.blocks.addAll(blocks);
    }
    public Set<IRBlock> getTails() {
        return tails;
    }
    public void addTail(IRBlock tail) {
        tails.add(tail);
    }

    public Set<IRLoop> getChildren() {
        return children;
    }
    public void addChild(IRLoop child) {
        children.add(child);
    }

    public IRBlock getPreHeader() {
        return preHeader;
    }
    public void setPreHeader(IRBlock preHeader) {
        this.preHeader = preHeader;
    }

    public boolean notDefinedInLoop(Operand o) {
        if (o instanceof Constant || o instanceof Parameter
                || o instanceof GlobalVariable) return true;
        if (o==Register.pseudoReg) return false;
        IRInst defInst = ((Register) o).getDef();
        return !blocks.contains(defInst.getBlock());
    }
}
