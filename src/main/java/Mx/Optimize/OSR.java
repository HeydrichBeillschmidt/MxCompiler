package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.BinaryOp;
import Mx.IR.Instruction.IRInst;
import Mx.IR.Instruction.Phi;
import Mx.IR.Operand.*;
import Mx.Optimize.FlowAnalysis.DominanceAnalysis;

import java.util.*;

//https://www.cs.rice.edu/~keith/EMBED/OSR.pdf

// operator strength reduction
public class OSR extends Pass {
    private class IExpr {
        public Operand IV, RC; // inductive variable, region constant
        public BinaryOp.BinaryOpName opName;

        public IExpr(BinaryOp bi) {
            if (bi.getOp2() instanceof Register &&
                    RegionConst(bi.getOp1(), header.get((Register) bi.getOp2())) ) {
                IV = bi.getOp2();
                RC = bi.getOp1();
            }
            else {
                IV = bi.getOp1();
                RC = bi.getOp2();
            }
            opName = bi.getOpName();
        }
        public IExpr(Operand IV, Operand RC, BinaryOp.BinaryOpName opName) {
            this.IV = IV;
            this.RC = RC;
            this.opName = opName;
        }
        public IExpr(IExpr other) {
            this.IV = other.IV;
            this.RC = other.RC;
            this.opName = other.opName;
        }

        @Override
        public boolean equals(Object o) {
            if (o instanceof IExpr) {
                if (this==o) return true;
                IExpr iExpr = (IExpr) o;
                return IV.equals(iExpr.IV) && RC.equals(iExpr.RC) && opName==iExpr.opName;
            }
            return false;
        }
        @Override
        public int hashCode() {
            return Objects.hash(IV, RC, opName);
        }
    }
    private Map<IExpr, Operand> iExprMap;

    private Map<Register, IRBlock> header;
    private Map<Register, Integer> DFN, low;
    private int nextDFSNum;
    private Map<IRBlock, Integer> RPONum;
    private Stack<Register> stack;
    private Set<Register> visited;

    private Function curFunc;
    private boolean changed;

    public OSR(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        new DominanceAnalysis(module).run();
        module.getFunctions().values().forEach(this::runForFn);
        return changed;
    }
    private void runForFn(Function f) {
        curFunc = f;
        iExprMap = new HashMap<>();
        header = new HashMap<>();
        DFN = new HashMap<>();
        low = new HashMap<>();
        nextDFSNum = 0;
        ArrayList<IRBlock> RPO = f.getRPO();
        RPONum = new HashMap<>();
        for (int i = 0, it = RPO.size(); i < it; ++i) {
            RPONum.put(RPO.get(i), i);
        }
        stack = new Stack<>();
        visited = new HashSet<>();

        Set<Register> nodes = new HashSet<>();
        for (var b: RPO) {
            for (var i: b.getAllInst()) {
                if (i.hasDst()) nodes.add(i.getDst());
            }
        }
        for (var n: nodes) if (!DFN.containsKey(n)) DFS(n);
    }

    private void DFS(Register n) {
        DFN.put(n, nextDFSNum);
        low.put(n, nextDFSNum++);
        visited.add(n);
        stack.push(n);

        if (n.getDef()!=null) {
            for (var u: n.getDef().getUses()) {
                if (u instanceof Register) {
                    Register r = (Register) u;
                    if (!DFN.containsKey(r)) {
                        DFS(r);
                        low.put(n, Math.min(low.get(n), low.get(r)));
                    }
                    else if (visited.contains(r)) {
                        low.put(n, Math.min(low.get(n), DFN.get(r)));
                    }
                }
            }
        }
        if (DFN.get(n).equals(low.get(n))) {
            Set<Register> SCC = new HashSet<>(); // strongly connected component
            Register x;
            do {
                x = stack.pop();
                visited.remove(x);
                SCC.add(x);
            } while (x != n);
            ProcessSCC(SCC);
        }
    }

    private void ProcessSCC(Set<Register> SCC) {
        if (SCC.size()==1) {
            Register n = SCC.iterator().next();
            if (n.getDef()!=null && checkPossibleIV(n, n.getDef().getBlock()))
                Replace((BinaryOp) n.getDef());
            header.put(n, null);
        }
        else ClassifyIV(SCC);
    }
    private boolean checkPossibleIV(Register n, IRBlock curHeader) {
        IRInst defInst = n.getDef();
        if (defInst instanceof BinaryOp) {
            BinaryOp bi = (BinaryOp) defInst;
            switch (bi.getOpName()) {
                case add: case sub: case mul: {
                    IRBlock header1 = bi.getOp1() instanceof Register ? header.get((Register) bi.getOp1()) : null,
                            header2 = bi.getOp2() instanceof Register ? header.get((Register) bi.getOp2()) : null;
                    return (header1!=null && curHeader.isDomed(header1) && RegionConst(bi.getOp2(), header1))
                            || (header2!=null && curHeader.isDomed(header2) && RegionConst(bi.getOp1(), header2)
                            && bi.getOpName()!=BinaryOp.BinaryOpName.sub);
                }
                default:
            }
        }
        return false;
    }

    private void ClassifyIV(Set<Register> SCC) {
        IRBlock curHeader = null;
        for (var n: SCC) {
            if (curHeader==null || RPONum.get(curHeader)>RPONum.get(n.getDef().getBlock())) {
                curHeader = n.getDef().getBlock();
            }
        }
        if (InductiveVariable(SCC, curHeader)) {
            for (var n: SCC) header.put(n, curHeader);
        }
        else {
            for (var n : SCC) {
                if (checkPossibleIV(n, n.getDef().getBlock()))
                    Replace((BinaryOp) n.getDef());
                else header.put(n, null);
            }
        }
    }

    private boolean RegionConst(Operand v, IRBlock curHeader) {
        if (curHeader==null) return false;
        if (v instanceof Parameter) return false;
        if (v instanceof ConstInt) return true;
        if (v instanceof ConstBool) return false;
        IRBlock defBlock = ((Register)v).getDef().getBlock();
        return curHeader!=defBlock && curHeader.isDomed(defBlock);
    }
    private boolean InductiveVariable(Set<Register> SCC, IRBlock curHeader) {
        for (var n: SCC) {
            IRInst defInst = n.getDef();
            if (defInst instanceof Phi) {
                if (isNotIV(defInst, SCC, curHeader)) return false;
            }
            else if (defInst instanceof BinaryOp) {
                BinaryOp.BinaryOpName opName = ((BinaryOp)defInst).getOpName();
                if (opName==BinaryOp.BinaryOpName.add
                        || opName==BinaryOp.BinaryOpName.sub) {
                    if (isNotIV(defInst, SCC, curHeader)) return false;
                }
                else return false;
            }
            else return false;
        }
        return true;
    }
    private boolean isNotIV(IRInst inst, Set<Register> SCC, IRBlock curHeader) {
        Set<Operand> uses = inst.getUses();
        for (var u: uses) {
            if (!(u instanceof Register && SCC.contains((Register) u))
                    && !RegionConst(u, curHeader)) return true;
        }
        return false;
    }

    private void Replace(BinaryOp bi) {
        IExpr iExpr = new IExpr(bi);
        Operand result = Reduce(iExpr);
        if (bi.getOp1().getType().equals(IRModule.int32T)) {
            bi.getBlock().replaceInst(bi, new BinaryOp(bi.getBlock(),
                    bi.getDst(), BinaryOp.BinaryOpName.add,
                    result, new ConstInt(0, 4)));
        }
        else {
            assert bi.getOp1().getType().equals(IRModule.boolT);
            bi.getBlock().replaceInst(bi, new BinaryOp(bi.getBlock(),
                    bi.getDst(), BinaryOp.BinaryOpName.or,
                    result, new ConstBool(false)));
        }
        header.put(bi.getDst(), header.get((Register) iExpr.IV) );
        changed = true;
    }
    private Operand Reduce(IExpr iExpr) {
        if (iExprMap.containsKey(iExpr)) return iExprMap.get(iExpr);
        changed = true;
        IRInst defInst = ((Register)iExpr.IV).getDef();
        IRInst newDef;
        Register result;
        newDef = defInst.copyToBlock(defInst.getBlock());
        result = newDef.getDst();
        curFunc.addSymbol(result);
        iExprMap.put(iExpr, result);
        defInst.getBlock().addNextInst(defInst, newDef);
        Set<Operand> uses = newDef.getUses();
        for (var u: uses) {
            if (u instanceof Register && header.get((Register) u)!=null &&
                    header.get((Register) u)==header.get((Register) iExpr.IV) ) {
                newDef.replaceUse(u, Reduce(new IExpr(u, iExpr.RC, iExpr.opName) ) );
            }
            else if (iExpr.opName==BinaryOp.BinaryOpName.mul
                    || newDef instanceof Phi) {
                if (!(u instanceof Parameter) && !(iExpr.RC instanceof Parameter))
                    newDef.replaceUse(u, Apply(new IExpr(u, iExpr.RC, iExpr.opName) ) );
            }
        }
        header.put(result, header.get((Register)iExpr.IV));
        return result;
    }
    private Operand Apply(IExpr iExpr) {
        if (iExprMap.containsKey(iExpr)) return iExprMap.get(iExpr);
        changed = true;
        if (iExpr.IV instanceof Register &&
                RegionConst(iExpr.RC, header.get((Register) iExpr.IV)))
            return Reduce(new IExpr(iExpr));
        else if (iExpr.RC instanceof Register &&
                RegionConst(iExpr.IV, header.get((Register) iExpr.RC)))
            return Reduce(new IExpr(iExpr.RC, iExpr.IV, iExpr.opName));
        else {
            if (iExpr.IV instanceof ConstInt && iExpr.RC instanceof ConstInt) {
                int v;
                int c1 = ((ConstInt)iExpr.IV).getValue(),
                        c2 = ((ConstInt)iExpr.RC).getValue();
                switch (iExpr.opName) {
                    case add: v = c1 + c2;break;
                    case sub: v = c1 - c2;break;
                    default:  v = c1 * c2;
                }
                return new ConstInt(v, 4);
            }
            else {
                Register result = new Register(iExpr.IV.getType(), "reduced");
                curFunc.addSymbol(result);
                iExprMap.put(iExpr, result);
                IRInst newDef = new BinaryOp(curFunc.getEntranceBlock(),
                        result, iExpr.opName, iExpr.IV, iExpr.RC);
                if (iExpr.IV instanceof ConstInt) {
                    IRInst defInst = ((Register)iExpr.RC).getDef();
                    newDef.setBlock(defInst.getBlock());
                    defInst.getBlock().addNextInst(defInst, newDef);
                }
                else if (iExpr.RC instanceof ConstInt) {
                    IRInst defInst = ((Register)iExpr.IV).getDef();
                    newDef.setBlock(defInst.getBlock());
                    defInst.getBlock().addNextInst(defInst, newDef);
                }
                else {
                    IRInst ivDef = ((Register)iExpr.IV).getDef(),
                            rcDef = ((Register)iExpr.RC).getDef();
                    IRBlock ivBlock = ivDef.getBlock(), rcBlock = rcDef.getBlock();
                    if (rcBlock.isDomed(ivBlock)) {
                        newDef.setBlock(rcBlock);
                        rcBlock.addNextInst(rcDef, newDef);
                    }
                    else {
                        newDef.setBlock(ivBlock);
                        ivBlock.addNextInst(ivDef, newDef);
                    }
                }
                header.put(result, null);
                return result;
            }
        }
    }
}
