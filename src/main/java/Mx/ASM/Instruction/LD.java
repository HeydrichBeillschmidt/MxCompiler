package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.VirtualReg;

// load
public class LD extends ASMInst {
    private final int size;
    private VirtualReg rd;
    private Address addr;

    public LD(ASMBlock block, int size, VirtualReg rd, Address addr) {
        super(block);
        this.size = size;
        this.rd = rd;
        this.addr = addr;

        addUse(addr.getBase());
        addDef(rd);
    }

    public int getSize() {
        return size;
    }
    public VirtualReg getRd() {
        return rd;
    }
    public Address getAddr() {
        return addr;
    }

    @Override
    public String emitCode() {
        return "\tl"+((size==1)?"b":((size==4)?"h":"w"))+"\t"
                + rd.emitCode() + ", " + addr.emitCode();
    }
    @Override
    public String toString() {
        return "l"+((size==1)?"b":((size==4)?"h":"w"))+" "
                + rd.toString() + ", " + addr.toString();
    }
}
