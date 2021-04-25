package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class GetElementPtr extends IRInst {
    private final Register dst;
    private final IRType type;
    private Operand ptr;
    private final ArrayList<Operand> index;

    public GetElementPtr(IRBlock block, Register dst,
                         Operand ptr, ArrayList<Operand> index) {
        super(block);
        this.dst = dst;
        this.ptr = ptr;
        this.index = index;

        assert ptr.getType() instanceof PointerType;
        assert dst.getType() instanceof PointerType;
        this.type = ((PointerType)ptr.getType()).getBaseType();
    }

    @Override
    public Register getDst() {
        return dst;
    }
    public IRType getType() {
        return type;
    }
    public Operand getPtr() {
        return ptr;
    }
    public ArrayList<Operand> getIndex() {
        return index;
    }

    @Override
    public boolean needWriteBack() {
        return true;
    }
    @Override
    public boolean isCommonExpr(IRInst i) {
        if (i instanceof GetElementPtr) {
            GetElementPtr inst = (GetElementPtr) i;
            if (!ptr.equals(inst.ptr)) return false;
            if (!type.equals(inst.type)) return false;
            for (int it = 0, itt = index.size(); it < itt; ++it) {
                if (!index.get(it).equals(inst.index.get(it))) return false;
            }
            return true;
        }
        return false;
    }
    @Override
    public void actuallyWritten() {
        dst.setDef(this);
        ptr.addUse(this);
        index.forEach(i -> i.addUse(this));
    }
    @Override
    public void severDF() {
        ptr.removeUse(this);
        index.forEach(i -> i.removeUse(this));
    }

    @Override
    public Set<Operand> getUses() {
        Set<Operand> ans = new HashSet<>(index);
        ans.add(ptr);
        return ans;
    }
    @Override
    public void replaceUse(Operand oldUse, Operand newUse) {
        if (ptr==oldUse) {
            ptr.removeUse(this);
            ptr = newUse;
            ptr.addUse(this);
        }
        for (int i = 0, it = index.size(); i < it; ++i) {
            Operand id = index.get(i);
            if (id==oldUse) {
                id.removeUse(this);
                index.set(i, newUse);
                index.get(i).addUse(this);
            }
        }
    }
    @Override
    public void refresh(Map<Operand, Operand> os, Map<IRBlock, IRBlock> bs) {
        if (ptr instanceof Parameter || ptr instanceof Register) ptr = os.get(ptr);
        for (int i = 0, it = index.size(); i < it; ++i) {
            Operand idx = index.get(i);
            if (idx instanceof Parameter || idx instanceof Register) index.set(i, os.get(idx));
            index.get(i).addUse(this);
        }
    }

    @Override
    public IRInst copyToBlock(IRBlock block) {
        GetElementPtr ans = new GetElementPtr(block, dst.getCopy(), ptr, new ArrayList<>(index));
        ans.dst.setDef(ans);
        return ans;
    }
    @Override
    public String toString() {
        StringBuilder string = new StringBuilder(dst.toString());
        string.append(" = getelementptr ").append(type.toString()).append(", ");
        string.append(ptr.getType().toString()).append(" ").append(ptr.toString());
        for (var i: index) {
            string.append(", ").append(i.getType().toString()).append(" ").append(i.toString());
        }
        return string.toString();
    }
    @Override
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
