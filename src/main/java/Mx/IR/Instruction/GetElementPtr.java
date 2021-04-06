package Mx.IR.Instruction;

import Mx.IR.IRBlock;
import Mx.IR.IRVisitor;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class GetElementPtr extends IRInst {
    private final Register dst;
    private final IRType type;
    private final Operand ptr;
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
    public void actuallyWritten() {
        dst.setDef(this);
        ptr.addUse(this);
        index.forEach(i -> i.addUse(this));
    }

    @Override
    public Set<Operand> getUses() {
        Set<Operand> ans = new HashSet<>(index);
        ans.add(ptr);
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
