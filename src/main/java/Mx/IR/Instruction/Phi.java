package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Null;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.PointerType;

import java.util.ArrayList;

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
        for (var v: values) v.addUse(this);
        dst.setDef(this);
        addUses(values);

        assert values.size() == blocks.size();
        for (var v: values) {
            assert v.getType().equals(dst.getType())
                    || (v instanceof Null && dst.getType() instanceof PointerType);
        }
    }

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
        values.add(value);
        blocks.add(block);
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public boolean isTerminalInst() {
        return false;
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
