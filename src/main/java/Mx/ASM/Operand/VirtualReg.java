package Mx.ASM.Operand;

import Mx.ASM.Instruction.MV;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class VirtualReg extends Register {
    //  Some attributes for graph coloring.
    private ArrayList<VirtualReg> adjList;
    private int degree;
    private Set<MV> moveList;
    private VirtualReg alias;
    private PhysicalReg color;

    private boolean colorFixed;
    private double spillCost;

    public VirtualReg(String name) {
        super(name);

        adjList = new ArrayList<>();
        degree = 0;
        moveList = new HashSet<>();
        alias = null;
        color = null;
        colorFixed = false;
        spillCost = 0;
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
        this.color = color;
    }
    public void fixColor(PhysicalReg color) {
        this.colorFixed = true;
        this.color = color;
    }

    @Override
    public String emitCode() {
        assert color!=null;
        return color.getName();
    }
}
