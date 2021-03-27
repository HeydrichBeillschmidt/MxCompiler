package Mx.Backend;

import Mx.ASM.Instruction.MV;
import Mx.ASM.Operand.VirtualReg;

import java.util.Set;
import java.util.Stack;

public class RegisterAllocator {
    /*  Allocate virtual registers to assignable physical registers.
     *  Algorithm: graph coloring
     */

    private static class Edge {
        public VirtualReg u, v;

        public Edge(VirtualReg u, VirtualReg v) {
            this.u = u;
            this.v = v;
        }

        @Override
        public boolean equals(Object o) {
            if (!(o instanceof Edge)) return false;
            return toString().equals(o.toString());
        }
        @Override
        public String toString() {
            return "Edge{" + u.toString() + ", " + v.toString() + "}";
        }
    }

    //  Data structures.
    //  --  Node work lists, sets, and stacks. Always mutually disjoint.
    private Set<VirtualReg> precolored;
    private Set<VirtualReg> initial;
    private Set<VirtualReg> simplifyWorklist;
    private Set<VirtualReg> freezeWorklist;
    private Set<VirtualReg> spillWorklist;
    private Set<VirtualReg> spilledNodes;
    private Set<VirtualReg> coalescedNodes;
    private Set<VirtualReg> coloredNodes;
    private Stack<VirtualReg> selectStack;

    //  --  Move sets. Mutually disjoint.
    private Set<MV> coalescedMoves;
    private Set<MV> constrainedMoves;
    private Set<MV> frozenMoves;
    private Set<MV> worklistMoves;
    private Set<MV> activeMoves;

    //  --  Other data structures.
    private Set<Edge> adjSet;
    //      adjList, degree, moveList, alias and color are attributes of VR.


}
