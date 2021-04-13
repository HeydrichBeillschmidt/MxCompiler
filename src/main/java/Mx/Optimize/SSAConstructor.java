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

        insertPhi(f);
        rename(f.getEntranceBlock(), null, new HashSet<>());
    }

    private void insertPhi(Function f) {
        for (var a: pseudoDefs) {
            ArrayList<Store> STs = new ArrayList<>();
            for (var u: a.getDst().getUses()) {
                if (u instanceof Load) LTable.put(((Load) u), a);
                else {
                    STs.add(((Store) u));
                    STable.put(((Store) u), a);
                }
            }

            // set of basic blocks where phi is added
            Set<IRBlock> F = new HashSet<>();
            // set of basic blocks that contain definitions of a.dst
            Queue<IRBlock> W = new LinkedList<>();
            Set<IRBlock> Defs = new HashSet<>();
            for (var s: STs) {
                W.offer(s.getBlock());
                Defs.add(s.getBlock());
            }
            while (!W.isEmpty()) {
                IRBlock block = W.poll();
                for (var Y: block.getDF()) {
                    if (!F.contains(Y)) {
                        String name = a.getDst().getName().split("\\$")[0];
                        Register result = new Register(a.getAllocType(), name);
                        f.addSymbol(result);
                        // add result at entry of DF after renaming
                        Y.addPhi(a, new Phi(Y, result, new ArrayList<>(), new ArrayList<>()));
                        F.add(Y);
                        if (!Defs.contains(Y)) {
                            W.offer(Y);
                            Defs.add(Y);
                        }
                    }
                }
            }
            a.removeFromBlock();
        }
    }

    private void rename(IRBlock block, IRBlock pred, Set<IRBlock> visit) {
        for (var a: block.getPseudoDefs()) {
            Phi ph = block.getPhi(a);
            Operand value;
            if (pred==null || pred.hasNoRename(a) || pred.getRename(a)==null) {
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
                i.severDF();
            }
            else if (i instanceof Store && STable.containsKey(i)) {
                Alloca a = STable.get(i);
                if (block.hasNoRename(a)) block.addRename(a, ((Store) i).getValue());
                else block.replaceRename(a, ((Store) i).getValue());
                i.removeFromBlock();
                i.severDF();
            }
        }

        for (var s: block.getSuccessors()) {
            rename(s, block, visit);
        }

        block.instantiatePhi();
    }
}
