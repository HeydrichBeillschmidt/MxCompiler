package Mx.Backend;

import Mx.ASM.ASMFunction;
import Mx.ASM.ASMModule;
import Mx.ASM.Instruction.ASMInst;
import Mx.ASM.Instruction.LD;
import Mx.ASM.Instruction.MV;
import Mx.ASM.Instruction.ST;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.PhysicalReg;
import Mx.ASM.Operand.StackPtr;
import Mx.ASM.Operand.VirtualReg;

import java.util.*;

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
/*
    private Edge es1;
    private Edge es2;
    private int cnt = 0;
    private void detect(String msg) {
        es1 = new Edge(curFunc.getSymbol(".s1.save"), curFunc.getSymbol(".s0.save"));
        es2 = new Edge(curFunc.getSymbol(".s0.save"), curFunc.getSymbol(".s1.save"));
        cnt = 0;
        for (var e: adjSet) {
            if (es1.equals(e)) {
                ++cnt;
                if (cnt>=2) break;
            }
            if (es2.equals(e)) {
                ++cnt;
                if (cnt>=2) break;
            }
        }
        System.out.println(msg+": "+cnt);
    }
*/
    //  Data structures.
    //  --  node work lists, sets, and stacks. always mutually disjoint.
    //      -- machine registers, preassigned a color
    private final Set<VirtualReg> precolored;
    //      -- temporary registers, not precolored and not yet processed
    private final Set<VirtualReg> initial;
    //      -- low-degree non-move-related nodes
    private final Set<VirtualReg> simplifyWorklist;
    //      -- low-degree move-related nodes
    private final Set<VirtualReg> freezeWorklist;
    //      -- high-degree nodes
    private final Set<VirtualReg> spillWorklist;
    //      -- nodes marked for spilling during this round; initially empty
    private final Set<VirtualReg> spilledNodes;
    //      -- registers that have been coalesced; when u <- v is coalesced,
    //          v is added to this set and u put back on some work list (or vice versa)
    private final Set<VirtualReg> coalescedNodes;
    //      -- nodes successfully colored
    private final Set<VirtualReg> coloredNodes;
    //      -- stack containing temporaries removed from the graph
    private final Stack<VirtualReg> selectStack;

    //  --  move sets. mutually disjoint.
    //      (will, the first 3 sets just collect useless moves)
    //      -- moves that have been coalesced
    @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
    private final Set<MV> coalescedMoves;
    //      -- moves whose source and target interfere
    @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
    private final Set<MV> constrainedMoves;
    //      -- moves that will no longer be considered for coalescing
    @SuppressWarnings("MismatchedQueryAndUpdateOfCollection")
    private final Set<MV> frozenMoves;
    //      -- moves enable for possible coalescing
    private final Set<MV> worklistMoves;
    //      -- moves not yet ready for coalescing
    private final Set<MV> activeMoves;

    //  --  other data structures.
    //      -- the set of interference edges in the graph; if (u, v) in adjSet, then so does (v, u)
    private final Set<Edge> adjSet;
    //      adjList, degree, moveList, alias and color are attributes of VR.
    //      -- adjList: adjacency list representation of the graph; for each non-precolored temporary u,
    //          adjList[u] is the set of nodes that interfere with u
    //      -- degree: an array containing the current degree of each node
    //      -- moveList: a mapping from a node to the list of moves it is associated with
    //      -- alias: when a move (u, v) has been coalesced, and v put in coalescedNodes, alias(v) = u
    //      -- color: the color chosen by the algorithm for a node

    private final ASMModule module;
    private final int K = PhysicalReg.assignablePhyRegs.size();
    private ASMFunction curFunc;
    private int stackLen;

    public RegisterAllocator(ASMModule module) {
        this.module = module;

        precolored = new HashSet<>(PhysicalReg.virtualRegs.values());
        initial = new HashSet<>();
        simplifyWorklist = new HashSet<>();
        freezeWorklist = new HashSet<>();
        spillWorklist = new HashSet<>();
        spilledNodes = new HashSet<>();
        coalescedNodes = new HashSet<>();
        coloredNodes = new HashSet<>();
        selectStack = new Stack<>();

        coalescedMoves = new HashSet<>();
        constrainedMoves = new HashSet<>();
        frozenMoves = new HashSet<>();
        worklistMoves = new HashSet<>();
        activeMoves = new HashSet<>();

        adjSet = new HashSet<>();
    }

    public void run() {
        for (var f: module.getFunctions().values()) {
            stackLen = 0;
            curFunc = f;
            runForFn(f);
        }
    }
    private void runForFn(ASMFunction f) {
        while (true) {
            initDS();
            new LivenessAnalysis(module).run();
            build();
            //detect("after build");
            makeWorkList();

            while (!(simplifyWorklist.isEmpty() && worklistMoves.isEmpty()
                    && freezeWorklist.isEmpty() && spillWorklist.isEmpty())) {
                if (!simplifyWorklist.isEmpty()) simplify();
                else if (!worklistMoves.isEmpty()) coalesce();
                else if (!freezeWorklist.isEmpty()) freeze();
                else /* if (!spillWorklist.isEmpty()) */ selectSpill();
            }
            assignColors();

            if (spilledNodes.isEmpty()) break;
            rewriteProgram();
        }

        stackLen += f.getStackedParmsSize();
        if (stackLen % 16 != 0) stackLen = (stackLen/16+1) * 16;
        f.countStackLen(stackLen);
        f.removeRedundantMV();
    }

    private void initDS() {
        initial.clear();
        simplifyWorklist.clear();
        freezeWorklist.clear();
        spillWorklist.clear();
        spilledNodes.clear();
        coalescedNodes.clear();
        coloredNodes.clear();
        selectStack.clear();

        coalescedMoves.clear();
        constrainedMoves.clear();
        frozenMoves.clear();
        worklistMoves.clear();
        activeMoves.clear();

        adjSet.clear();

        for (var b: curFunc.getBlocks().values()) {
            for (ASMInst i = b.getHeadInst(); i != null; i = i.getNextInst()) {
                initial.addAll(i.getDefs());
                initial.addAll(i.getUses());
            }
        }
        initial.removeAll(precolored);
        initial.forEach(VirtualReg::resetColoringInfo);

        precolored.forEach(VirtualReg::resetForPreColoredVRs);
        // todo: calculate spill costs
    }

    // build interference graph and init workistMoves by static liveness analysis
    // interference graph is instance of graph<VR, MV>
    private void build() {
        for (var b: curFunc.getBlocks().values()) {
            Set<VirtualReg> curLive = b.getLiveOut();
            ArrayList<ASMInst> rOrder = b.getAllInst();
            Collections.reverse(rOrder);
            for (var i: rOrder) {
                if (i instanceof MV) {
                    curLive.removeAll(i.getUses());
                    Set<VirtualReg> toMove = i.getUses();
                    toMove.addAll(i.getDefs());
                    for (var n: toMove) n.getMoveList().add((MV) i);
                    worklistMoves.add((MV) i);
                }
                curLive.add(PhysicalReg.zeroVR);
                curLive.addAll(i.getDefs());
                for (var d: i.getDefs()) {
                    for (var l : curLive) addEdge(l, d);
                }
                curLive.removeAll(i.getDefs());
                curLive.addAll(i.getUses());
            }
        }
    }
    // add edge to the interference graph
    private void addEdge(VirtualReg u, VirtualReg v) {
        if (!adjSet.contains(new Edge(u, v)) && u!=v) {
            adjSet.add(new Edge(u, v));
            adjSet.add(new Edge(v, u));
            if (!precolored.contains(u)) {
                u.getAdjList().add(v);
                u.increaseDegree();
            }
            if (!precolored.contains(v)) {
                v.getAdjList().add(u);
                v.increaseDegree();
            }
        }
    }

    // classify nodes into initial to spill/freeze/frozen worklist
    private void makeWorkList() {
        for (var n: initial) {
            if (n.getDegree()>=K) spillWorklist.add(n);
            else if (moveRelated(n)) freezeWorklist.add(n);
            else simplifyWorklist.add(n);
        }
    }
    private boolean moveRelated(VirtualReg n) {
        return !nodeMoves(n).isEmpty();
    }
    // get interference edges of n
    private Set<MV> nodeMoves(VirtualReg n) {
        Set<MV> ans = new HashSet<>(activeMoves);
        ans.addAll(worklistMoves);
        ans.retainAll(n.getMoveList());
        return ans;
    }

    // remove one node with degree <= K from the graph
    private void simplify() {
        VirtualReg n = simplifyWorklist.iterator().next();
        simplifyWorklist.remove(n);
        selectStack.push(n);
        for (var m: adjacent(n)) decrementDegree(m);
    }
    // get adjacent nodes of n
    private Set<VirtualReg> adjacent(VirtualReg n) {
        Set<VirtualReg> ans = new HashSet<>(n.getAdjList());
        ans.removeAll(selectStack);
        ans.removeAll(coalescedNodes);
        return ans;
    }
    private void decrementDegree(VirtualReg m) {
        int d = m.getDegree();
        m.setDegree(d - 1);
        if (d == K) {
            // re-classify m
            Set<VirtualReg> nodes = new HashSet<>(adjacent(m));
            nodes.add(m);
            enableMoves(nodes);
            spillWorklist.remove(m);
            if (moveRelated(m)) freezeWorklist.add(m);
            else simplifyWorklist.add(m);
        }
    }
    // enable some moves to be considered for coalescing
    private void enableMoves(Set<VirtualReg> nodes) {
        nodes.forEach(n -> nodeMoves(n).forEach(m -> {
            if (activeMoves.contains(m)) {
                activeMoves.remove(m);
                worklistMoves.add(m);
            }
        }));
    }

    // coalesce rd and rs of a move inst
    private void coalesce() {
        MV m = worklistMoves.iterator().next();
        VirtualReg x, y, u, v;
        x = getAlias(m.getRd());
        y = getAlias(m.getRs());
        if (precolored.contains(y)) { u = y; v = x; }
        else { u = x; v = y; }
        worklistMoves.remove(m);
        if (u==v) {
            coalescedMoves.add(m);
            addWorkList(u);
        }
        else if (precolored.contains(v) || adjSet.contains(new Edge(u, v))) {
            constrainedMoves.add(m);
            addWorkList(u);
            addWorkList(v);
        }
        else if ( (precolored.contains(u) && allAdjacentOK(v, u))
                || (!precolored.contains(u) && conservative(adjacent(u, v)) ) ) {
            coalescedMoves.add(m);
            combine(u, v);
            addWorkList(u);
        }
        else {
            activeMoves.add(m);
        }
    }
    // get the root of the union-find disjoint set alias[n]
    private VirtualReg getAlias(VirtualReg n) {
        if (coalescedNodes.contains(n)) {
            VirtualReg alias = getAlias(n.getAlias());
            n.setAlias(alias);
            return alias;
        }
        else return n;
    }
    // move node u: freeze -> simplify worklist
    private void addWorkList(VirtualReg u) {
        if (!precolored.contains(u) && !moveRelated(u) && u.getDegree() < K) {
            freezeWorklist.remove(u);
            simplifyWorklist.add(u);
        }
    }
    // judge whether forall t in adjacent(v), OK(t, u)
    private boolean allAdjacentOK(VirtualReg v, VirtualReg u) {
        for (var t: adjacent(v)) {
            if (!OK(t, u)) return false;
        }
        return true;
    }
    // George's coalescence heuristic for coalescing a precolored reg
    private boolean OK(VirtualReg t, VirtualReg r) {
        return t.getDegree() < K || precolored.contains(t) || adjSet.contains(new Edge(t, r));
    }
    // Briggs's conservative coalescence heuristic
    private boolean conservative(Set<VirtualReg> nodes) {
        int k = 0;
        for (var n: nodes) {
            if (n.getDegree() >= K) ++k;
        }
        return k < K;
    }
    // get coset of adjacent(u) and adjacent(v)
    private Set<VirtualReg> adjacent(VirtualReg u, VirtualReg v) {
        Set<VirtualReg> nodes = new HashSet<>(adjacent(u));
        nodes.addAll(adjacent(v));
        return nodes;
    }
    // coalesce u and v with u possibly precolored
    private void combine(VirtualReg u, VirtualReg v) {
        if (freezeWorklist.contains(v)) freezeWorklist.remove(v);
        else spillWorklist.remove(v);
        coalescedNodes.add(v);
        v.setAlias(u);
        u.getMoveList().addAll(v.getMoveList());
        enableMoves(new HashSet<>(Collections.singletonList(v)));
        for (var t: adjacent(v)) {
            addEdge(t, u);
            decrementDegree(t);
        }
        if (u.getDegree() >= K && freezeWorklist.contains(u)) {
            freezeWorklist.remove(u);
            spillWorklist.add(u);
        }
    }

    // giving up coalescing a VR
    private void freeze() {
        VirtualReg u = freezeWorklist.iterator().next();
        freezeWorklist.remove(u);
        simplifyWorklist.add(u);
        freezeMoves(u);
    }
    private void freezeMoves(VirtualReg u) {
        for (var m: nodeMoves(u)) {
            VirtualReg x, y, v;
            x = m.getRd();
            y = m.getRs();
            v = getAlias(y)==getAlias(u) ? getAlias(x) : getAlias(y);
            activeMoves.remove(m);
            frozenMoves.add(m);
            if (freezeWorklist.contains(v) && nodeMoves(v).isEmpty()) {
                freezeWorklist.remove(v);
                simplifyWorklist.add(v);
            }
        }
    }

    // spill a VR to stack
    private void selectSpill() {
        VirtualReg m = getSpill();
        spillWorklist.remove(m);
        simplifyWorklist.add(m);
        freezeMoves(m);
    }
    private VirtualReg getSpill() {
        // todo: select using favorite heuristic
        ArrayList<VirtualReg> list = new ArrayList<>(spillWorklist);
        int index = new Random().nextInt(list.size());
        return list.get(index);
    }

    private void assignColors() {
        //detect("at assign");
        while (!selectStack.isEmpty()) {
            VirtualReg n = selectStack.pop();
            ArrayList<PhysicalReg> okColors = new ArrayList<>(PhysicalReg.assignablePhyRegs);
            Set<VirtualReg> colored = new HashSet<>(coloredNodes);
            colored.addAll(precolored);
            for (var w: n.getAdjList()) {
                VirtualReg wAliasRoot = getAlias(w);
                if (colored.contains(wAliasRoot)) okColors.remove(wAliasRoot.getColor());
            }
            if (okColors.isEmpty()) spilledNodes.add(n);
            else {
                coloredNodes.add(n);
                n.setColor(okColors.get(0));
            }
        }
        coalescedNodes.forEach(n -> n.setColor(getAlias(n).getColor()));
    }

    private void rewriteProgram() {
        for (var v: spilledNodes) {
            v.setStackOffset(new StackPtr(-1 * stackLen - 4));
            stackLen += 4;
        }
        for (var b: curFunc.getBlocks().values()) {
            for (var i: b.getAllInst()) {
                if (i.getRd()!=null) getAlias(i.getRd());
            }
        }
        int cnt = 0;
        for (var b: curFunc.getBlocks().values()) {
            for (var i: b.getAllInst()) {
                for (VirtualReg u: i.getUses()) {
                    if (u.getStackOffset()!=null) {
                        if (i.getDefs().contains(u)) {
                            VirtualReg tmp = new VirtualReg(u.getSize(),
                                    u.getName() + ".spill" + cnt++);
                            curFunc.addSymbolMultiple(tmp);
                            curFunc.removeSymbol(u);
                            i.replaceRs(u, tmp);
                            i.replaceRd(u, tmp);
                            b.addPrevInst(i, new LD(b, tmp.getSize(), tmp,
                                    new Address(PhysicalReg.spVR, u.getStackOffset()) ) );
                            b.addNextInst(i, new ST(b, tmp.getSize(), tmp,
                                    new Address(PhysicalReg.spVR, u.getStackOffset()) ) );
                        }
                        else {
                            if (i instanceof MV && ((MV)i).getRs()==u && i.getRd().getStackOffset()==null) {
                                ASMInst iToReplace = new LD(b, u.getSize(), i.getRd(),
                                        new Address(PhysicalReg.spVR, u.getStackOffset()) );
                                i.replaceByInst(iToReplace);
                                i = iToReplace;
                            }
                            else {
                                VirtualReg tmp = new VirtualReg(u.getSize(),
                                        u.getName() + ".spill" + cnt++);
                                curFunc.addSymbolMultiple(tmp);
                                curFunc.removeSymbol(u);
                                i.replaceRs(u, tmp);
                                b.addPrevInst(i, new LD(b, tmp.getSize(), tmp,
                                        new Address(PhysicalReg.spVR, u.getStackOffset()) ) );
                            }
                        }
                    }
                }
                for (VirtualReg d: i.getDefs()) {
                    if (d.getStackOffset()!=null) {
                        if (!i.getUses().contains(d)) {
                            if (i instanceof MV && ((MV)i).getRs().getStackOffset()==null) {
                                ASMInst iToReplace = new ST(b, d.getSize(), ((MV)i).getRs(),
                                        new Address(PhysicalReg.spVR, d.getStackOffset()) );
                                i.replaceByInst(iToReplace);
                                i = iToReplace;
                            }
                            else {
                                VirtualReg tmp = new VirtualReg(d.getSize(),
                                        d.getName() + ".spill" + cnt++);
                                curFunc.addSymbolMultiple(tmp);
                                curFunc.removeSymbol(d);
                                i.replaceRd(d, tmp);
                                b.addNextInst(i, new ST(b, tmp.getSize(), tmp,
                                        new Address(PhysicalReg.spVR, d.getStackOffset()) ) );
                            }
                        }
                    }
                }
            }
        }
    }
}
