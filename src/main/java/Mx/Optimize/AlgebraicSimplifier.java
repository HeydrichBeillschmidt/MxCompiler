package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.*;
import Mx.IR.TypeSystem.ArrayType;
import Mx.IR.TypeSystem.BoolType;
import Mx.IR.TypeSystem.PointerType;

import java.util.*;

// Whale Ch12.3 / "Engineering a Compiler"Ch8.4.2

public class AlgebraicSimplifier extends Pass {
    private Queue<IRInst> W;
    private Set<IRInst> inQueue;
    private Function curFunc;
    private boolean changed;

    public AlgebraicSimplifier(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        W = new LinkedList<>();
        inQueue = new HashSet<>();
        module.getFunctions().values().forEach(this::runForFn);
        return changed;
    }
    private void runForFn(Function f) {
        curFunc = f;
        ArrayList<IRBlock> PO = f.getPO();
        for (var b: PO) {
            treeBalance(b);
            for (var i: b.getAllInst()) {
                if (i.hasNoSideEffect()) {
                    W.offer(i);
                    inQueue.add(i);
                }
            }
        }

        while (!W.isEmpty()) {
            IRInst i = W.poll();
            inQueue.remove(i);

            if (i instanceof BinaryOp) changed |= checkBinary((BinaryOp) i);
            else if (i instanceof BitCast) changed |= checkCast((BitCast) i);
            else if (i instanceof Icmp) changed |= checkCmp((Icmp) i);
            else if (i instanceof GetElementPtr) changed |= checkGEP((GetElementPtr) i);
        }
    }

    private Set<Register> isRoot;
    private Map<Operand, Integer> rank;
    private Set<Operand> UEVar;
    private void treeBalance(IRBlock block) {
        UEVar = new HashSet<>();
        Set<Operand> VarKills = new HashSet<>();
        ArrayList<IRInst> instList = block.getAllInst();
        for (var i: instList) {
            Set<Operand> curUse = i.getUses();
            curUse.removeAll(VarKills);
            UEVar.addAll(curUse);
            if (i instanceof BinaryOp) VarKills.add(i.getDst());
        }

        Queue<Register> roots = new LinkedList<>();
        isRoot = new HashSet<>();
        rank = new HashMap<>();
        for (var i: instList) {
            if (i instanceof BinaryOp) {
                BinaryOp inst = (BinaryOp) i;
                Register dst = inst.getDst();
                rank.put(dst, -1);
                Set<IRInst> uses = dst.getUses();
                if (inst.isCommutable() && uses.size()>=1) {
                    if (uses.size()==1) {
                        IRInst instUse = uses.iterator().next();
                        if (!(instUse instanceof BinaryOp) ||
                                ((BinaryOp)instUse).getOpName()==inst.getOpName()) break;
                    }
                    isRoot.add(dst);
                    roots.offer(dst);
                }
            }
        }
        while (!roots.isEmpty()) {
            Register var = roots.poll();
            balance(var);
        }
    }
    private void balance(Register root) {
        if (rank.get(root)>=0) return;
        Queue<Operand> q = new LinkedList<>();
        BinaryOp op = (BinaryOp) root.getDef();
        rank.put(root, flatten(op.getOp1(),q)+flatten(op.getOp2(),q));
        rebuild(q, op.getOpName(), root);
    }
    private int flatten(Operand var, Queue<Operand> q) {
        if (var instanceof Constant) { // cannot recur further
            rank.put(var, 0);
            q.offer(var);
        }
        else if (UEVar.contains(var)) { // cannot recur past top of block
            rank.put(var, 1);
            q.offer(var);
        }
        else if (var instanceof Register) {
            if (isRoot.contains(var)) {
                balance((Register) var);
                q.offer(var);
            }
            else {
                IRInst inst = ((Register)var).getDef();
                if (inst instanceof BinaryOp) {
                    BinaryOp bi = (BinaryOp) inst;
                    flatten(bi.getOp1(), q);
                    flatten(bi.getOp2(), q);
                }
            }
        }
        return rank.get(var);
    }
    private void rebuild(Queue<Operand> q, BinaryOp.BinaryOpName op, Register root) {
        while (!q.isEmpty()) {
            Operand NL = q.poll();
            Operand NR = q.poll();
            if (NL instanceof Constant && NR instanceof Constant) {
                Constant NT = fold(op, (Constant)NL, (Constant)NR);
                if (q.isEmpty()) {
                    root.replaceUse(NT);
                    rank.put(root, 0);
                }
                else {
                    q.offer(NT);
                    rank.put(NT, 0);
                }
            }
            else {
                Register NT;
                if (q.isEmpty()) NT = root;
                else {
                    NT = new Register(root.getType(), "NT");
                    curFunc.addSymbol(NT);
                }
                IRInst instDef = root.getDef();
                IRBlock blockDef = instDef.getBlock();
                assert NR != null;
                blockDef.addPrevInst(instDef, new BinaryOp(blockDef, NT, op, NL, NR));
                rank.put(NT, rank.get(NL) + rank.get(NR));
                if (!q.isEmpty()) q.offer(NT);
            }
        }
    }
    private Constant fold(BinaryOp.BinaryOpName opName, Constant NL, Constant NR) {
        if (NL instanceof ConstInt) {
            assert NR instanceof ConstInt;
            int vt;
            int vl = ((ConstInt) NL).getValue(), vr = ((ConstInt) NR).getValue();
            switch (opName) {
                case add: vt = vl + vr;break;
                case sub: vt = vl - vr;break;
                case mul: vt = vl * vr;break;
                case sdiv:vt = vl / vr;break;
                case srem:vt = vl % vr;break;
                case shl: vt = vl << vr;break;
                case ashr:vt = vl >> vr;break;
                case and: vt = vl & vr;break;
                case or:  vt = vl | vr;break;
                default:  vt = vl ^ vr;
            }
            return new ConstInt(vt, 4);
        }
        else {
            assert NL instanceof ConstBool;
            assert NR instanceof ConstBool;
            boolean vt;
            boolean vl = ((ConstBool) NL).getValue(), vr = ((ConstBool) NR).getValue();
            switch (opName) {
                case and: vt = vl & vr;break;
                case or:  vt = vl | vr;break;
                case xor: vt = vl ^ vr;break;
                default: throw new RuntimeException();
            }
            return new ConstBool(vt);
        }
    }

    private void exploit(IRInst inst) {
        for (var u: inst.getDst().getUses()) {
            if (u.hasNoSideEffect() && !inQueue.contains(u)) {
                W.offer(u);
                inQueue.add(u);
            }
        }
    }

    private boolean checkBinary(BinaryOp i) {
        if (i.getOpName() == BinaryOp.BinaryOpName.add) {
            if (i.getOp1()==i.getOp2()) {
                i.setOpName(BinaryOp.BinaryOpName.shl);
                i.setOp2(new ConstInt(1, 4));
                i.getOp2().addUse(i);
                exploit(i);
                return true;
            }
            if (i.getOp1().equals(new ConstInt(0, 4))) {
                i.replaceOp1(i.getOp2());
                exploit(i);
                return true;
            }
            if (i.getOp2().equals(new ConstInt(0, 4))) {
                i.replaceOp2(i.getOp1());
                exploit(i);
                return true;
            }
            return false;
        }
        if (i.getOpName() == BinaryOp.BinaryOpName.mul) {
            int srNum = -1;
            Operand src = null;
            if (i.getOp1() instanceof ConstInt) {
                int value = ((ConstInt)i.getOp1()).getValue();
                if (value==0) {
                    i.getDst().replaceUse(new ConstInt(0, 4));
                    exploit(i);
                    i.severDF();
                    i.removeFromBlock();
                    return true;
                }
                if (value==1) {
                    i.getDst().replaceUse(i.getOp2());
                    exploit(i);
                    i.severDF();
                    i.removeFromBlock();
                    return true;
                }
                srNum = mulToSllOrNot(value);
                src = i.getOp2();
            }
            if (i.getOp2() instanceof ConstInt) {
                int value = ((ConstInt)i.getOp2()).getValue();
                if (value==0) {
                    i.getDst().replaceUse(new ConstInt(0, 4));
                    exploit(i);
                    i.severDF();
                    i.removeFromBlock();
                    return true;
                }
                if (value==1) {
                    i.getDst().replaceUse(i.getOp1());
                    exploit(i);
                    i.severDF();
                    i.removeFromBlock();
                    return true;
                }
                srNum = mulToSllOrNot(value);
                src = i.getOp1();
            }
            if (srNum > 0) {
                i.rewrite(BinaryOp.BinaryOpName.shl, src, new ConstInt(srNum, 4));
                return true;
            }
            return false;
        }
        Operand src = null;
        switch (i.getOpName()) {
            case sub: {
                if (i.getOp1()==i.getOp2()) src = new ConstInt(0, 4);
                else if (i.getOp2().equals(new ConstInt(0, 4))) src = i.getOp1();
                break;
            }
            case sdiv: {
                if (i.getOp1().equals(new ConstInt(0, 4))) src = new ConstInt(0, 4);
                else if (i.getOp2().equals(new ConstInt(1, 4))) src = i.getOp1();
                break;
            }
            case srem: {
                if (i.getOp1().equals(new ConstInt(0, 4))) src = new ConstInt(0, 4);
                break;
            }
            case shl: case ashr: {
                if (i.getOp1().equals(new ConstInt(0, 4))) src = new ConstInt(0, 4);
                else if (i.getOp2().equals(new ConstInt(0, 4))) src = i.getOp1();
                break;
            }
            case and: {
                if (i.getOp2().equals(new ConstInt(0, 4))) src = i.getOp1();
                else if (i.getOp2().equals(new ConstInt(-1, 4))
                        || i.getOp2()==i.getOp1()) src = i.getOp1();
                break;
            }
            case or: {
                if (i.getOp2().equals(new ConstInt(0, 4))
                        || i.getOp2()==i.getOp1()) src = i.getOp1();
                else if (i.getOp2().equals(new ConstInt(-1, 4))) src = new ConstInt(-1, 4);
                break;
            }
            case xor: {
                if (i.getOp1().getType() instanceof BoolType) return false;
                if (i.getOp2().equals(new ConstInt(0, 4))) src = i.getOp1();
                else if (i.getOp2()==i.getOp1()) src = new ConstInt(0, 4);
            }
            default:;
        }
        if (src!=null) {
            i.getDst().replaceUse(src);
            exploit(i);
            i.severDF();
            i.removeFromBlock();
            return true;
        }
        return false;
    }
    private int mulToSllOrNot(int n) {
        if (n<=0) return -1;
        int ans = 0;
        while (n > 1) {
            if (n % 2 == 0) {
                n /= 2;
                ++ans;
            }
            else return -1;
        }
        return ans;
    }

    private boolean checkCast(BitCast i) {
        if (i.getCastType().equals(i.getSrc().getType())) {
            exploit(i);
            i.getDst().replaceUse(i.getSrc());
            i.severDF();
            i.removeFromBlock();
            return true;
        }
        return false;
    }

    private boolean checkGEP(GetElementPtr i) {
        for (var idx: i.getIndex()) {
            if (!idx.equals(new ConstInt(0, 4))) return false;
        }

        Operand replace;
        if (i.getIndex().size()==1) replace = i.getPtr();
        else if (((PointerType)i.getPtr().getType()).getBaseType() instanceof ArrayType) {
            return false;
        }
        else {
            Register dst = new Register(i.getDst().getType(), i.getDst().getName());
            curFunc.addSymbol(dst);
            BitCast cast = new BitCast(i.getBlock(), dst, i.getPtr(), dst.getType());
            i.getBlock().addNextInst(i, cast);
            W.offer(cast);
            inQueue.add(cast);
            replace = dst;
        }
        if (replace!=null) {
            exploit(i);
            i.getDst().replaceUse(replace);
            i.severDF();
            i.removeFromBlock();
            return true;
        }
        return false;
    }

    private boolean checkCmp(Icmp i) {
        i.balance();
        if (i.getOp1()==i.getOp2()) {
            Operand replace;
            switch (i.getOpName()) {
                case eq: case sle: case sge: replace = new ConstBool(true);break;
                default: replace = new ConstBool(false);
            }
            exploit(i);
            i.getDst().replaceUse(replace);
            i.severDF();
            i.removeFromBlock();
            return true;
        }
        return false;
    }
}
