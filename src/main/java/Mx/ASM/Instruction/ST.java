package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMVisitor;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.Immediate;
import Mx.ASM.Operand.StackPtr;
import Mx.ASM.Operand.VirtualReg;

import java.util.HashSet;
import java.util.Set;

// store
public class ST extends ASMInst {
    private final int size;
    private VirtualReg rs;
    private final Address addr;

    public ST(ASMBlock block, int size, VirtualReg rs, Address addr) {
        super(block);
        this.size = size;
        this.rs = rs;
        this.addr = addr;
    }

    public int getSize() {
        return size;
    }
    public VirtualReg getRs() {
        return rs;
    }
    public Address getAddr() {
        return addr;
    }

    @Override
    public void replaceRs(VirtualReg oldRs, VirtualReg newRs) {
        if (rs==oldRs) rs = newRs;
        if (addr.getBase()==oldRs) addr.setBase(newRs);
    }
    @Override
    public Set<VirtualReg> getUses() {
        Set<VirtualReg> ans = new HashSet<>();
        ans.add(rs);
        ans.add(addr.getBase());
        return ans;
    }
    @Override
    public void countStackLen(int stackLen) {
        if (addr.getOffset() instanceof StackPtr) {
            addr.setOffset(new Immediate(stackLen
                    + addr.getOffset().getValue() ) );
        }
    }
    @Override
    public String emitCode() {
        return "\ts"+((size== 1)?"b":((size==4)?"w":"h"))+"\t"
                + rs.emitCode() + ", " + addr.emitCode();
    }
    @Override
    public String toString() {
        return "\ts"+((size== 1)?"b":((size==4)?"w":"h"))+"\t"
                + rs.toString() + ", " + addr.toString();
    }
    @Override
    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
