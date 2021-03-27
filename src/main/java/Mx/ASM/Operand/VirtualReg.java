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

    public VirtualReg(String name) {
        super(name);

        adjList = new ArrayList<>();
        degree = 0;
        moveList = new HashSet<>();
        alias = null;
        color = null;
    }

    public boolean hasColor() {
        return color !=null;
    }
    public PhysicalReg getColor() {
        assert color !=null;
        return color;
    }
    public void setColor(PhysicalReg pr) {
        this.color = pr;
    }

    @Override
    public String emitCode() {
        assert color!=null;
        return color.getName();
    }
}
