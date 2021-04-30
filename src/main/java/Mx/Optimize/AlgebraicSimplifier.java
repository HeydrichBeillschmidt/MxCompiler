package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.*;
import Mx.IR.TypeSystem.ArrayType;
import Mx.IR.TypeSystem.BoolType;
import Mx.IR.TypeSystem.IntegerType;
import Mx.IR.TypeSystem.PointerType;

import java.util.*;

// Whale Ch12.3

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
        ArrayList<IRBlock> RPO = f.getRPO();
        for (var b: RPO) {
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

    private void exploit(IRInst inst) {
        for (var u: inst.getDst().getUses()) {
            if (u.hasNoSideEffect() && !inQueue.contains(u)) {
                W.offer(u);
                inQueue.add(u);
            }
        }
    }

    private boolean checkBinary(BinaryOp i) {
        aggregateBinaryInst(i);
        if (i.getOpName() == BinaryOp.BinaryOpName.add) {
            if (i.getOp1()==i.getOp2()) {
                i.setOpName(BinaryOp.BinaryOpName.shl);
                i.setOp2(new ConstInt(1, 4));
                i.getOp2().addUse(i);
                exploit(i);
                return true;
            }
            if (i.getOp1().equals(new ConstInt(0, 4))) {
                i.getDst().replaceUse(i.getOp2());
                exploit(i);
                i.severDF();
                i.removeFromBlock();
                return true;
            }
            if (i.getOp2().equals(new ConstInt(0, 4))) {
                i.getDst().replaceUse(i.getOp1());
                exploit(i);
                i.severDF();
                i.removeFromBlock();
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
                if (i.getOp2().equals(new ConstInt(0, 4))) src = new ConstInt(0, 4);
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
            default:
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
    private void aggregateBinaryInst(BinaryOp i) {
        boolean cITypeLhs = i.getOp1().genByCommutativeIType(),
                cITypeRhs = i.getOp2().genByCommutativeIType();
        if (!cITypeLhs && !cITypeRhs) return;
        if (cITypeLhs && cITypeRhs) {
            BinaryOp lhsDef = (BinaryOp)((Register)i.getOp1()).getDef(),
                     rhsDef = (BinaryOp)((Register)i.getOp2()).getDef();
            if (lhsDef.getOpName()!=i.getOpName()
                    || rhsDef.getOpName()!=i.getOpName() ) return;
            lhsDef.skewToLeft();
            rhsDef.skewToLeft();
            Register tmp = new Register(new IntegerType(4), "tmp");
            curFunc.addSymbol(tmp);
            BinaryOp intermediate = new BinaryOp(i.getBlock(), tmp,
                    i.getOpName(), lhsDef.getOp1(), rhsDef.getOp1());
            i.getBlock().addPrevInst(i, intermediate);
            i.rewrite(i.getOpName(), tmp, foldInt(i.getOpName(),
                    (ConstInt) lhsDef.getOp2(), (ConstInt) rhsDef.getOp2()) );
            exploit(i);
        }
        else if (cITypeLhs && i.getOp2() instanceof ConstInt) {
            BinaryOp lhsDef = (BinaryOp)((Register)i.getOp1()).getDef();
            if (lhsDef.getOpName()!=i.getOpName()) return;
            lhsDef.skewToLeft();
            i.rewrite(i.getOpName(), lhsDef.getOp1(), foldInt(i.getOpName(),
                    (ConstInt) lhsDef.getOp2(), (ConstInt) i.getOp2()) );
            exploit(i);
        }
        else if (cITypeRhs && i.getOp1() instanceof ConstInt) {
            BinaryOp rhsDef = (BinaryOp)((Register)i.getOp2()).getDef();
            if (rhsDef.getOpName()!=i.getOpName()) return;
            rhsDef.skewToLeft();
            i.rewrite(i.getOpName(), rhsDef.getOp1(), foldInt(i.getOpName(),
                    (ConstInt) rhsDef.getOp2(), (ConstInt) i.getOp2()) );
            exploit(i);
        }
    }
    private ConstInt foldInt(BinaryOp.BinaryOpName opName, ConstInt c1, ConstInt c2) {
        switch (opName) {
            case add: return new ConstInt(c1.getValue()+c2.getValue(), 4);
            case mul: return new ConstInt(c1.getValue()*c2.getValue(), 4);
            case and: return new ConstInt(c1.getValue()&c2.getValue(), 4);
            case or:  return new ConstInt(c1.getValue()|c2.getValue(), 4);
            case xor: return new ConstInt(c1.getValue()^c2.getValue(), 4);
            default: throw new RuntimeException();
        }
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
