package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.PointerType;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class Phi extends IRInst {
    private final Register dst;
    private final ArrayList<Operand> values;
    private final ArrayList<IRBlock> blocks;

    public Phi(IRBlock block, Register dst,
               ArrayList<Operand> values, ArrayList<IRBlock> blocks) {
        super(block);
        this.dst = dst;
        this.values = values;
        this.blocks = blocks;

        assert values.size() == blocks.size();
        for (var v: values) {
            assert v.getType().equals(dst.getType())
                    || (v instanceof Null && dst.getType() instanceof PointerType);
        }
    }

    @Override
    public Register getDst() {
        return dst;
    }
    public ArrayList<Operand> getValues() {
        return values;
    }
    public ArrayList<IRBlock> getBlocks() {
        return blocks;
    }
    public void addEntry(Operand value, IRBlock block) {
        value.addUse(this);
        values.add(value);
        blocks.add(block);
    }
    public void replaceEntry(IRBlock oldEntry, IRBlock newEntry) {
        for (int i = 0, it = blocks.size(); i < it; ++i) {
            if (blocks.get(i)==oldEntry) {
                blocks.set(i, newEntry);
            }
        }
    }
    public void removeEntry(IRBlock block) {
        for (int i = 0, it = blocks.size(); i < it; ++i) {
            if (blocks.get(i)==block) {
                values.get(i).removeUse(this);
                values.remove(i);
                blocks.remove(i);
                break;
            }
        }
    }
    public void conveyEntry(Phi target, int i) {
        target.addEntry(values.get(i), blocks.get(i));
        values.remove(i);
        blocks.remove(i);
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public boolean isCommonExpr(IRInst i) {
        if (i instanceof Phi) {
            Phi inst = (Phi) i;
            if (blocks.size()==inst.blocks.size()) {
                Set<Operand> valueSet = new HashSet<>(inst.getValues());
                for (int it = 0, itt = blocks.size(); it < itt; ++it) {
                    if (!valueSet.contains(values.get(it))
                            || blocks.get(it)!=inst.blocks.get(it)) return false;
                }
                return true;
            }
        }
        return false;
    }
    @Override
    public void actuallyWritten() {
        dst.setDef(this);
        values.forEach(v -> v.addUse(this));
    }
    @Override
    public void severDF() {
        values.forEach(v -> v.removeUse(this));
    }

    @Override
    public Set<Operand> getUses() {
        return new HashSet<>(values);
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        for (int i = 0, it = values.size(); i < it; ++i) {
            Operand v = values.get(i);
            if (v==oldUse) {
                v.removeUse(this);
                values.set(i, newUse);
                values.get(i).addUse(this);
            }
        }
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder(dst.toString());
        string.append(" = phi ").append(dst.getType().toString()).append(" ");
        int it = values.size();
        for (int i = 0; i < it; ++i) {
            string.append("[ ").append(values.get(i).toString()).append(", ");
            string.append(blocks.get(i).toString()).append(" ]");
            if (i < it-1) string.append(", ");
        }
        return string.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
