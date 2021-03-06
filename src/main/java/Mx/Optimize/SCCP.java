package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.*;

import java.util.*;

//Tiger Ch19.3.3

// sparse conditional constant propagation
public class SCCP extends Pass {
    private enum LatticeCellStat {
        U, C, Z // undefined, constant, overDefined
    }
    private static class LatticeCell {
        private final LatticeCellStat stat;
        private final Operand constVal;

        public LatticeCell(LatticeCellStat stat) {
            this.stat = stat;
            this.constVal = null;
        }
        public LatticeCell(Operand constVal) {
            this.stat = LatticeCellStat.C;
            this.constVal = constVal;
        }

        public boolean undefined() {
            return stat== LatticeCellStat.U;
        }
        public boolean isConst() {
            return stat== LatticeCellStat.C;
        }
        public Operand getConstVal() {
            return constVal;
        }
        public boolean overDefined() {
            return stat== LatticeCellStat.Z;
        }
    }
    private final static LatticeCell
            cellT = new LatticeCell(LatticeCellStat.U),
            cellB = new LatticeCell(LatticeCellStat.Z); // top, bottom
    /* The lattice:
     *    undefined
     *      / | \
     * ... 3  4  5 ...
     *      \ | /
     *   over-defined
     */

    private boolean changed;
    private boolean changedFn;

    private Map<Operand, LatticeCell> lattice;
    private Set<IRBlock> executable;
    private Queue<IRBlock> workListBlocks;
    private Queue<Register> workListVars;

    public SCCP(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        module.getFunctions().values().forEach(this::runForFn);
        return changed;
    }
    private void runForFn(Function f) {
        init();
        addExecutable(f.getEntranceBlock());
        do {
            if (!workListBlocks.isEmpty()) {
                while (!workListBlocks.isEmpty()) {
                    IRBlock curBlock = workListBlocks.poll();
                    ArrayList<IRInst> list = curBlock.getAllInst();
                    propagate(list);
                }
            }
            if (!workListVars.isEmpty()) {
                while (!workListVars.isEmpty()) {
                    Register curVar = workListVars.poll();
                    ArrayList<IRInst> list = new ArrayList<>(curVar.getUses());
                    propagate(list);
                }
            }
        } while (!workListBlocks.isEmpty());

        ArrayList<IRBlock> RPO = f.getRPO();
        for (var b: RPO) {
            ArrayList<IRInst> instList = b.getAllInst();
            for (var i: instList) {
                if (i.hasDst()) {
                    LatticeCell cell = queryCell(i.getDst());
                    if (cell.isConst()) {
                        i.severDF();
                        i.removeFromBlock();
                        i.getDst().replaceUse(cell.constVal);
                        changedFn = true;
                    }
                }
            }
        }

        changed |= changedFn;
    }

    private void init() {
        lattice = new HashMap<>();
        executable = new HashSet<>();
        workListBlocks = new LinkedList<>();
        workListVars = new LinkedList<>();
        changedFn = false;
    }
    private void addExecutable(IRBlock block) {
        if (!executable.contains(block)) {
            executable.add(block);
            workListBlocks.offer(block);
        }
        else block.getAllPhi().forEach(this::checkPhi);
    }
    private LatticeCell queryCell(Operand s) {
        if (lattice.containsKey(s)) return lattice.get(s);
        LatticeCell ans;
        if (s.isConstant()) ans = new LatticeCell(s);
        else if (s instanceof Parameter) ans = cellB;
        else ans = cellT;
        lattice.put(s, ans);
        return ans;
    }
    private void decentCell(Register r, Constant c) {
        LatticeCell oldCell = queryCell(r);
        if (c==null) { // decent to bottom
            if (!oldCell.overDefined()) {
                lattice.replace(r, cellB);
                workListVars.offer(r);
            }
        }
        else {
            LatticeCell cell = new LatticeCell(c);
            if (oldCell.undefined()) {
                lattice.replace(r, cell);
                workListVars.offer(r);
            }
            else if (oldCell.isConst()) {
                assert oldCell.constVal!=null;
                assert oldCell.constVal.equals(c);
            }
            else throw new RuntimeException();
        }
    }

    private void propagate(ArrayList<IRInst> instList) {
        for (var inst: instList) {
            if (inst instanceof BinaryOp) checkBinary((BinaryOp) inst);
            else if (inst instanceof Icmp) checkCmp((Icmp) inst);
            else if (inst instanceof Phi) checkPhi((Phi) inst);
            else if (inst instanceof BitCast || inst instanceof Call
                    || inst instanceof Load || inst instanceof GetElementPtr) {
                decentCell(inst.getDst(), null);
            }
            else if (inst instanceof Br) checkBr((Br) inst);
        }
    }
    private void checkBinary(BinaryOp i) {
        LatticeCell l1 = queryCell(i.getOp1()), l2 = queryCell(i.getOp2());
        if (l1.isConst() && l2.isConst()) {
            assert l1.constVal!=null; assert l2.constVal!=null;
            if (l1.getConstVal() instanceof ConstInt) {
                int c1 = ((ConstInt)l1.constVal).getValue(),
                    c2 = ((ConstInt)l2.constVal).getValue();
                int value;
                switch (i.getOpName()) {
                    case add: value = c1 + c2; break;
                    case sub: value = c1 - c2; break;
                    case mul: value = c1 * c2; break;
                    case sdiv:
                        if (c2==0) return;
                        value = c1 / c2;break;
                    case srem:
                        if (c2==0) return;
                        value = c1 % c2;break;
                    case shl: value = c1 << c2;break;
                    case ashr:value = c1 >> c2;break;
                    case and: value = c1 & c2; break;
                    case or:  value = c1 | c2; break;
                    case xor: value = c1 ^ c2; break;
                    default: throw new RuntimeException();
                }
                decentCell(i.getDst(), new ConstInt(value, 4));
            }
            else {
                boolean c1 = ((ConstBool)l1.constVal).getValue(),
                        c2 = ((ConstBool)l2.constVal).getValue();
                boolean value;
                switch (i.getOpName()) {
                    case and: value = c1 && c2;break;
                    case or:  value = c1 || c2;break;
                    case xor: value = c1 ^ c2; break;
                    default: throw new RuntimeException();
                }
                decentCell(i.getDst(), new ConstBool(value));
            }
        }
        else if (l1.overDefined() || l2.overDefined()) decentCell(i.getDst(), null);
    }
    private void checkCmp(Icmp i) {
        LatticeCell l1 = queryCell(i.getOp1()), l2 = queryCell(i.getOp2());
        if (l1.isConst() && l2.isConst()) {
            assert l1.constVal!=null; assert l2.constVal!=null;
            boolean value;
            if (l1.getConstVal() instanceof ConstInt) {
                int c1 = ((ConstInt)l1.constVal).getValue(),
                    c2 = ((ConstInt)l2.constVal).getValue();
                switch (i.getOpName()) {
                    case eq: value = c1==c2;break;
                    case ne: value = c1!=c2;break;
                    case slt:value = c1<c2; break;
                    case sge:value = c1>=c2;break;
                    case sle:value = c1<=c2;break;
                    default: value = c1>c2;
                }
            }
            else if (l1.getConstVal() instanceof ConstBool) {
                boolean c1 = ((ConstBool)l1.constVal).getValue(),
                        c2 = ((ConstBool)l2.constVal).getValue();
                switch (i.getOpName()) {
                    case eq: value = c1==c2;break;
                    case ne: value = c1!=c2;break;
                    default: throw new RuntimeException();
                }
            }
            else value = i.getOpName() == Icmp.IcmpOpName.eq;
            decentCell(i.getDst(), new ConstBool(value));
        }
        else if (l1.overDefined() || l2.overDefined()) decentCell(i.getDst(), null);
    }
    private void checkPhi(Phi i) {
        Constant c = null;
        for (int it = 0, itt = i.getBlocks().size(); it < itt; ++it) {
            if (!executable.contains(i.getBlocks().get(it))) continue;
            LatticeCell value = queryCell(i.getValues().get(it));
            if (value.overDefined()) {
                decentCell(i.getDst(), null);
                return;
            }
            else if (value.isConst()) {
                assert value.constVal!=null;
                if (c==null) c = (Constant) value.constVal;
                else if (!c.equals(value.getConstVal())) {
                    decentCell(i.getDst(), null);
                    return;
                }
            }
        }
        if (c!=null) {
            decentCell(i.getDst(), c);
        }
    }
    private void checkBr(Br i) {
        if (i.getCondition()==null) {
            addExecutable(i.getThenBlock());
            return;
        }

        LatticeCell cond = queryCell(i.getCondition());
        if (cond.isConst()) {
            if (((ConstBool)cond.getConstVal()).getValue()) {
                addExecutable(i.getThenBlock());
            }
            else addExecutable(i.getElseBlock());
        }
        else if (cond.overDefined()) {
            addExecutable(i.getThenBlock());
            addExecutable(i.getElseBlock());
        }
    }
}
