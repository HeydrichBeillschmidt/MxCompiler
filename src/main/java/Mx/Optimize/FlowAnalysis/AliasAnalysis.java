package Mx.Optimize.FlowAnalysis;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRLoop;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.PointerType;
import Mx.Optimize.Pass;

import java.util.*;

/* A naive pointer analysis using Anderson's algorithm.
 * trivial, since Mx itself doesn't have much complexity
 * todo: apply advanced algorithms for more C-like language
 * possible ref for further study:
 * - Data structure analysis:
 * https://llvm.org/pubs/2003-11-15-DataStructureAnalysisTR.pdf
 * - Flow-sensitive pointer analysis:
 * https://www.cs.utexas.edu/~lin/papers/cgo11.pdf
 * - for engineering:
 * https://www.researchgate.net/publication/234806662_Fast_interprocedual_alias_analysis
 */

public class AliasAnalysis extends Pass {
    private static class MemNode {
        private final String name;
        public Set<MemNode> basicConstrains;   // a = &b
        public Set<MemNode> simpleConstrains;  // a = b with edge b -> a
        public Set<MemNode> complexUConstrains;// a = *b
        public Set<MemNode> complexDConstrains;// *a = b

        public MemNode(String name) {
            this.name = name;
            basicConstrains = new HashSet<>();
            simpleConstrains = new HashSet<>();
            complexUConstrains = new HashSet<>();
            complexDConstrains = new HashSet<>();
        }

        public String getName() {
            return name;
        }
    }
    private Map<Operand, MemNode> ptrMap; // point to
    private Set<MemNode> nodes;

    private final InterProceduralAnalysis interProc;
    private final LoopAnalysis lpa;
    private Map<Function, Set<MemNode>> funcSTs;
    private Set<MemNode> loopSTs;
    private Set<Operand> loopSAs; // addresses of stores

    public AliasAnalysis(IRModule module, InterProceduralAnalysis interProc, LoopAnalysis lpa) {
        super(module);
        this.interProc = interProc;
        this.lpa = lpa;
    }

    public boolean mayAlias(Operand src1, Operand src2) {
        if (src1 instanceof Null || src2 instanceof Null) return false;
        if (!src1.getType().equals(src2.getType())) return false;
        if (src1==src2) return true;
        MemNode s1 = ptrMap.get(src1), s2 = ptrMap.get(src2);
        Set<MemNode> eq1 = s1.simpleConstrains, eq2 = s2.simpleConstrains;
        if (eq1.contains(s2)||eq2.contains(s1)) return true;
        Set<MemNode> pts1 = s1.basicConstrains, pts2 = s2.basicConstrains;
        return !Collections.disjoint(pts1, pts2);
    }

    @Override
    public boolean run() {
        nodes = new HashSet<>();
        ptrMap = new HashMap<>();
        funcSTs = new HashMap<>();
        loopSTs = new HashSet<>();
        loopSAs = new HashSet<>();

        init();
        solveConstraint();
        analyse();
        collectSTs();

        return false;
    }

    private void init() {
        for (var gv: module.getGlobalVariables().values()) {
            MemNode global = new MemNode("g_"+gv.getName());
            MemNode pt = new MemNode(global.name+"_pointTo");
            global.basicConstrains.add(pt);
            ptrMap.put(gv, global);
            nodes.add(global);
            nodes.add(pt);
        }
        for (var f: module.getFunctions().values()) {
            for (var p: f.getParameterList()) {
                if (p.getType() instanceof PointerType) {
                    MemNode para = new MemNode("p_"
                            +p.getName()+f.getName() );
                    ptrMap.put(p, para);
                    nodes.add(para);
                }
            }
            ArrayList<IRBlock> blockList = f.getRPO();
            for (var b: blockList) {
                for (var i: b.getAllInst()) {
                    Register t = i.getDst();
                    if (t.getType() instanceof PointerType) {
                        MemNode tmp = new MemNode("l_"
                                +t.getName()+f.getName() );
                        ptrMap.put(t, tmp);
                        nodes.add(tmp);
                    }
                }
            }
        }
    }

    private void solveConstraint() {
        for (var f: module.getFunctions().values()) {
            ArrayList<IRBlock> blockList = f.getRPO();
            for (var b: blockList) {
                ArrayList<IRInst> instList = b.getAllInst();
                instList.forEach(this::checkInst);
            }
        }
    }
    private void checkInst(IRInst inst) {
        if (inst instanceof BitCast) {
            BitCast i = (BitCast) inst;
            if (!(i.getSrc() instanceof Null)) {
                ptrMap.get(i.getSrc()).simpleConstrains.add(ptrMap.get(i.getDst()));
            }
        }
        else if (inst instanceof Call) {
            Call i = (Call) inst;
            if (!module.hasNoFunction(i.getCallee().getName())) {
                for (int it = 0, itt = i.getParameterList().size(); it < itt; ++it) {
                    // actual arg
                    Operand aa = i.getParameterList().get(it);
                    if (aa.getType() instanceof PointerType
                            && !(aa instanceof Null)) {
                        // formal arg
                        MemNode fa = ptrMap.get(i.getCallee().getParameterList().get(it));
                        ptrMap.get(aa).simpleConstrains.add(fa);
                    }
                }
                if (i.getDst().getType() instanceof PointerType) {
                    Operand retVal = ((Ret)i.getCallee().getReturnBlock().getTailInst()).getRetValue();
                    ptrMap.get(retVal).simpleConstrains.add(ptrMap.get(i.getDst()));
                }
            }
        }
        else if (inst instanceof GetElementPtr) {
            GetElementPtr i = (GetElementPtr) inst;
            if (!(i.getPtr() instanceof Null)) {
                ptrMap.get(i.getPtr()).simpleConstrains.add(ptrMap.get(i.getDst()));
            }
        }
        else if (inst instanceof Load) {
            Load i = (Load) inst;
            if (i.getDst().getType() instanceof PointerType
                    && !(i.getAddr() instanceof Null) ) {
                ptrMap.get(i.getAddr()).complexUConstrains.add(ptrMap.get(i.getDst()));
            }
        }
        else if (inst instanceof Phi) {
            Phi i = (Phi) inst;
            if (i.getDst().getType() instanceof PointerType) {
                MemNode ph = ptrMap.get(i.getDst());
                i.getValues().stream().filter(v -> !(v instanceof Null)).forEach(
                        v -> ptrMap.get(v).simpleConstrains.add(ph)
                );
            }
        }
        else if (inst instanceof Store) {
            Store i = (Store) inst;
            if (i.getValue().getType() instanceof PointerType
                    && !(i.getValue() instanceof Null) ) {
                ptrMap.get(i.getAddr()).complexDConstrains.add(ptrMap.get(i.getValue()));
            }
        }
    }

    private void analyse() {
        Queue<MemNode> W = new LinkedList<>();
        Set<MemNode> active = new HashSet<>();
        for (var n: nodes) {
            if (!n.basicConstrains.isEmpty()) {
                W.add(n);
                active.add(n);
            }
        }
        while (!W.isEmpty()) {
            MemNode v = W.poll();
            active.remove(v);
            for (var a: v.basicConstrains) {
                for (var p: v.complexUConstrains) {
                    if (!a.simpleConstrains.contains(p)) {
                        a.simpleConstrains.add(p);
                        if (!active.contains(a)) {
                            W.offer(a);
                            active.add(a);
                        }
                    }
                }
                for (var q: v.complexDConstrains) {
                    if (!q.simpleConstrains.contains(a)) {
                        q.simpleConstrains.add(a);
                        if (!active.contains(q)) {
                            W.offer(q);
                            active.add(q);
                        }
                    }
                }
            }
            for (var q: v.simpleConstrains) {
                if (q.basicConstrains.addAll(v.basicConstrains)) {
                    if (!active.contains(q)) {
                        W.offer(q);
                        active.add(q);
                    }
                }
            }
        }
    }

    private void collectSTs() {
        ArrayList<Function> PO = interProc.getPO();
        for (var f: PO) {
            Set<MemNode> STs = new HashSet<>();
            ArrayList<IRBlock> BPO = f.getPO();
            for (var b: BPO) {
                for (var i: b.getAllInst()) {
                    if (i instanceof Store) {
                        STs.addAll(ptrMap.get(((Store)i).getAddr()).basicConstrains);
                    }
                }
            }
            funcSTs.put(f, STs);
        }
        boolean loopCond = true;
        while (loopCond) {
            loopCond = false;
            for (var f: PO) {
                Set<MemNode> STs = funcSTs.get(f);
                if (STs.isEmpty()) continue;
                for (var caller: interProc.getDirectCallers(f)) {
                    loopCond |= funcSTs.get(caller).addAll(STs);
                }
            }
        }
    }

    private void stabilize(IRLoop loop) {
        if (!loop.getChildren().isEmpty()) {
            loop.getChildren().forEach(this::stabilize);
        }
        Set<MemNode> chord = new HashSet<>();
        for (var inst: loop.getPreHeader().getAllInst()) {
            if (inst.getDst().getType() instanceof PointerType) {
                MemNode mem = ptrMap.get(inst.getDst());
                if (!mem.simpleConstrains.isEmpty()) {
                    chord.add(mem);
                    chord.addAll(mem.simpleConstrains);
                }
            }
        }
        for (var b: loop.getBlocks()) {
            for (var inst : b.getAllInst()) {
                if (inst.getDst().getType() instanceof PointerType) {
                    MemNode mem = ptrMap.get(inst.getDst());
                    if (!mem.simpleConstrains.isEmpty()) {
                        chord.add(mem);
                        chord.addAll(mem.simpleConstrains);
                    }
                }
            }
        }
        for (var c: chord) {
            c.simpleConstrains.addAll(chord);
        }
    }

    public void buildST(IRLoop loop) {
        loopSTs.clear();
        loopSAs.clear();
        stabilize(loop);
        for (var b: loop.getBlocks()) {
            for (var inst: b.getAllInst()) {
                if (inst instanceof Store) {
                    loopSAs.add(((Store) inst).getAddr());
                }
                else if (inst instanceof Call) {
                    Call i = (Call) inst;
                    if (!module.hasNoFunction(i.getCallee().getName())) {
                        loopSTs.addAll(funcSTs.get(i.getCallee()));
                    }
                }
            }
        }
    }

    public boolean useLoopST(Load i) {
        Operand addr = i.getAddr();
        Set<MemNode> pointTo = new HashSet<>(ptrMap.get(addr).basicConstrains);
        if (!Collections.disjoint(pointTo, loopSTs)) return true;
        for (var sa: loopSAs) {
            if (mayAlias(sa, addr)) return true;
        }
        return false;
    }
}
