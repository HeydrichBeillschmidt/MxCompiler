package Mx.Optimize.FlowAnalysis;

import Mx.IR.IRBlock;
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
    private Map<Operand, MemNode> pts; // point to
    private Set<MemNode> nodes;

    public AliasAnalysis(IRModule module) {
        super(module);
    }

    public boolean mayAlias(Operand src1, Operand src2) {
        if (src1 instanceof Null || src2 instanceof Null) return false;
        if (!src1.getType().equals(src2.getType())) return false;
        Set<MemNode> pts1 = pts.get(src1).basicConstrains,
                pts2 = pts.get(src2).basicConstrains;
        return Collections.disjoint(pts1, pts2);
    }

    @Override
    public boolean run() {
        nodes = new HashSet<>();
        pts = new HashMap<>();

        init();
        solveConstraint();
        analyse();

        return false;
    }

    private void init() {
        for (var gv: module.getGlobalVariables().values()) {
            MemNode global = new MemNode("g_"+gv.getName());
            MemNode pt = new MemNode(global.name+"_pointTo");
            global.basicConstrains.add(pt);
            pts.put(gv, global);
            nodes.add(global);
            nodes.add(pt);
        }
        for (var f: module.getFunctions().values()) {
            for (var p: f.getParameterList()) {
                if (p.getType() instanceof PointerType) {
                    MemNode para = new MemNode("p_"
                            +p.getName()+f.getName() );
                    pts.put(p, para);
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
                        pts.put(t, tmp);
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
                pts.get(i.getSrc()).simpleConstrains.add(pts.get(i.getDst()));
            }
        }
        else if (inst instanceof Call) {
            Call i = (Call) inst;
            if (module.hasNoFunction(i.getCallee().getName())) {
                if (i.getDst().getType() instanceof PointerType) {
                    MemNode retPtr = pts.get(i.getDst());
                    MemNode pt = new MemNode(retPtr.name+"_pointTo");
                    retPtr.basicConstrains.add(pt);
                    nodes.add(pt);
                }
            }
            else {
                for (int it = 0, itt = i.getParameterList().size(); it < itt; ++it) {
                    // actual arg
                    Operand aa = i.getParameterList().get(it);
                    if (aa.getType() instanceof PointerType
                            && !(aa instanceof Null)) {
                        // formal arg
                        MemNode fa = pts.get(i.getCallee().getParameterList().get(it));
                        pts.get(aa).simpleConstrains.add(fa);
                    }
                }
                if (i.getDst().getType() instanceof PointerType) {
                    Operand retVal = ((Ret)i.getCallee().getReturnBlock().getTailInst()).getRetValue();
                    pts.get(retVal).simpleConstrains.add(pts.get(i.getDst()));
                }
            }
        }
        else if (inst instanceof GetElementPtr) {
            GetElementPtr i = (GetElementPtr) inst;
            if (!(i.getPtr() instanceof Null)) {
                pts.get(i.getPtr()).simpleConstrains.add(pts.get(i.getDst()));
            }
        }
        else if (inst instanceof Load) {
            Load i = (Load) inst;
            if (i.getDst().getType() instanceof PointerType
                    && !(i.getAddr() instanceof Null) ) {
                pts.get(i.getAddr()).complexUConstrains.add(pts.get(i.getDst()));
            }
        }
        else if (inst instanceof Phi) {
            Phi i = (Phi) inst;
            if (i.getDst().getType() instanceof PointerType) {
                MemNode ph = pts.get(i.getDst());
                i.getValues().stream().filter(v -> !(v instanceof Null)).forEach(
                        v -> pts.get(v).simpleConstrains.add(ph)
                );
            }
        }
        else if (inst instanceof Store) {
            Store i = (Store) inst;
            if (i.getValue().getType() instanceof PointerType
                    && !(i.getValue() instanceof Null) ) {
                pts.get(i.getAddr()).complexDConstrains.add(pts.get(i.getValue()));
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
                for (var p: a.complexUConstrains) {
                    if (!a.simpleConstrains.contains(p)) {
                        a.simpleConstrains.add(p);
                        if (!active.contains(a)) {
                            W.offer(a);
                            active.add(a);
                        }
                    }
                }
                for (var q: a.complexDConstrains) {
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
                if (q.simpleConstrains.addAll(v.simpleConstrains)) {
                    if (!active.contains(q)) {
                        W.offer(q);
                        active.add(q);
                    }
                }
            }
        }
    }
}
