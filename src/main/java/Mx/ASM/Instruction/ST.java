package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.VirtualReg;

// store
public class ST extends ASMInst {
    private final int size;
    private VirtualReg rs;
    private Address addr;

    public ST(ASMBlock block, int size, VirtualReg rs, Address addr) {
        super(block);
        this.size = size;
        this.rs = rs;
        this.addr = addr;

        addUse(rs);
        addUse(addr.getBase());
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
    public String emitCode() {
        return "\ts"+((size== 1)?"b":((size==4)?"w":"h"))+"\t"
                + rs.emitCode() + ", " + addr.emitCode();
    }
    @Override
    public String toString() {
        return "\ts"+((size== 1)?"b":((size==4)?"w":"h"))+"\t"
                + rs.toString() + ", " + addr.toString();
    }
}
