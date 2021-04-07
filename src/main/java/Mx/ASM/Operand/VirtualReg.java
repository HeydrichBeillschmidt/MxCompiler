package Mx.ASM.Operand;

import Mx.ASM.Instruction.MV;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class VirtualReg extends Reg {
    private int size;
    private Immediate stackOffset;
    //  Some attributes for graph coloring.
    private final ArrayList<VirtualReg> adjList;
    private int degree;
    private final Set<MV> moveList;
    private VirtualReg alias;
    private PhysicalReg color;

    private boolean colorFixed;
    // the num of extra instructions needed when VR is in memory rather than in regs
    // todo: calculate spill cost after performing loop analysis
    private double spillCost;

    // before opt Allocas still block in
    // VRs as Rds of Allocas must be spilled to stack
    private boolean mustBeSpilled;

    public VirtualReg(int size, String name) {
        super(name);

        this.size = size;
        stackOffset = null;

        adjList = new ArrayList<>();
        degree = 0;
        moveList = new HashSet<>();
        alias = null;
        color = null;
        colorFixed = false;
        spillCost = 0;

        mustBeSpilled = false;
    }

    public int getSize() {
        return size;
    }
    public void setSize(int size) {
        this.size = size;
    }
    public Immediate getStackOffset() {
        return stackOffset;
    }
    public void setStackOffset(Immediate stackOffset) {
        this.stackOffset = stackOffset;
    }

    public ArrayList<VirtualReg> getAdjList() {
        return adjList;
    }
    public int getDegree() {
        return degree;
    }
    public void increaseDegree() {
        ++degree;
    }
    public void setDegree(int degree) {
        this.degree = degree;
    }
    public Set<MV> getMoveList() {
        return moveList;
    }
    public VirtualReg getAlias() {
        return alias;
    }
    public void setAlias(VirtualReg alias) {
        this.alias = alias;
    }
    public boolean hasColor() {
        return color !=null;
    }
    public PhysicalReg getColor() {
        assert color !=null;
        return color;
    }
    public void setColor(PhysicalReg color) {
        assert !colorFixed;
        this.color = color;
    }
    public void fixColor(PhysicalReg color) {
        this.colorFixed = true;
        this.color = color;
    }
    public void resetColoringInfo() {
        adjList.clear();
        degree = 0;
        moveList.clear();
        alias = null;
        color = null;
        spillCost = 0;
    }
    public void resetForPreColoredVRs() {
        adjList.clear();
        degree = 0x3f3f3f3f;
        moveList.clear();
        alias = null;
    }

    public boolean mustBeSpilled() {
        return mustBeSpilled;
    }
    public void forceSpilled() {
        mustBeSpilled = true;
    }

    @Override
    public String emitCode() {
        if (color!=null) return color.getName();
        return getName();
    }
}
