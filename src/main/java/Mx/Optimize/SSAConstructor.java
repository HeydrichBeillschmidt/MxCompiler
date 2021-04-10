package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Alloca;
import Mx.IR.Instruction.Load;
import Mx.IR.Instruction.Phi;
import Mx.IR.Instruction.Store;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;

import java.util.*;

public class SSAConstructor extends Pass {
    private ArrayList<Alloca> pseudoDefs;
    private Map<Load, Alloca> LTable;
    private Map<Store, Alloca> STable;

    public SSAConstructor(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        pseudoDefs = new ArrayList<>();
        module.getFunctions().values().forEach(this::runForFn);
        return true;
    }

    private void runForFn(Function f) {
        f.getAllBlocks().forEach(IRBlock::initSSA);
        pseudoDefs = f.getAllocas();
        LTable = new HashMap<>();
        STable = new HashMap<>();

        for (var a: pseudoDefs) {
            ArrayList<Store> STs = new ArrayList<>();
            for (var u: a.getDst().getUses()) {
                if (u instanceof Load) LTable.put(((Load) u), a);
                else {
                    STs.add(((Store) u));
                    STable.put(((Store) u), a);
                }
            }
            Queue<IRBlock> queue = new LinkedList<>();
            Set<IRBlock> visit = new HashSet<>();
            Set<IRBlock> phiEquipped = new HashSet<>();
            for (var s: STs) {
                queue.offer(s.getBlock());
                visit.add(s.getBlock());
            }
            while (!queue.isEmpty()) {
                IRBlock block = queue.poll();
                for (var DF: block.getDF()) {
                    if (!phiEquipped.contains(DF)) {
                        String name = a.getDst().getName().split("\\$")[0];
                        Register result = new Register(a.getAllocType(), name);
                        DF.addPhi(a, new Phi(DF, result, new ArrayList<>(), new ArrayList<>()));
                        f.addSymbol(result);
                        phiEquipped.add(DF);
                        if (!visit.contains(DF)) {
                            queue.offer(DF);
                            visit.add(DF);
                        }
                    }
                }
            }
            a.removeFromBlock();
        }

        for (var b: f.getAllBlocks()) {
            for (var i: b.getAllInst()) {
                if (i instanceof Load && i.getDst().getUses().isEmpty()) {
                    i.removeFromBlock();
                }
            }
        }

        rename(f.getEntranceBlock(), null, new HashSet<>());
    }

    private void rename(IRBlock block, IRBlock pred, Set<IRBlock> visit) {
        for (var a: block.getPseudoDefs()) {
            Phi ph = block.getPhi(a);
            Operand value;
            if (pred==null || !pred.hasRename(a)) {
                value = a.getAllocType().getDefaultValue();
            }
            else value = pred.getRename(a);
            ph.addEntry(value, pred);
        }
        if (pred != null) {
            for (var a: pseudoDefs) {
                if (!block.hasPseudoDef(a)) {
                    block.addRename(a, pred.getRename(a));
                }
            }
        }

        if (visit.contains(block)) return;
        visit.add(block);

        for (var a: block.getPseudoDefs()) {
            block.addRename(a, block.getPhi(a).getDst());
        }
        for (var i: block.getAllInst()) {
            if (i instanceof Load && LTable.containsKey(i)) {
                Alloca a = LTable.get(i);
                Operand value = block.getRename(a);
                i.getDst().replaceUse(value);
                i.removeFromBlock();
            }
            else if (i instanceof Store && STable.containsKey(i)) {
                Alloca a = STable.get(i);
                if (!block.hasRename(a)) block.addRename(a, ((Store) i).getValue());
                else block.replaceRename(a, ((Store) i).getValue());
                i.removeFromBlock();
            }
        }
        for (var s: block.getSuccessors()) {
            rename(s, block, visit);
        }
        block.instantiatePhi();
    }
}
