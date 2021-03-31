package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.Immediate;
import Mx.ASM.Operand.StackPtr;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// load
public class LD extends ASMInst {
    private final int size;
    private VirtualReg rd;
    private final Address addr;

    public LD(ASMBlock block, int size, VirtualReg rd, Address addr) {
        super(block);
        this.size = size;
        this.rd = rd;
        this.addr = addr;
    }

    public int getSize() {
        return size;
    }
    public Address getAddr() {
        return addr;
    }

    @Override
    public VirtualReg getRd() {
        return rd;
    }
    @Override
    public void setRd(VirtualReg rd) {
        this.rd = rd;
    }
    @Override
    public void replaceRs(VirtualReg oldRs, VirtualReg newRs) {
        if (addr.getBase()==oldRs) addr.setBase(newRs);
    }
    @Override
    public Set<VirtualReg> getUses() {
        return new HashSet<>(Collections.singletonList(addr.getBase()));
    }
    @Override
    public Set<VirtualReg> getDefs() {
        return new HashSet<>(Collections.singletonList(rd));
    }
    @Override
    public void countStackLen(int stackLen) {
        if (addr.getOffset() instanceof StackPtr) {
            addr.setOffset(new Immediate(stackLen
                    + addr.getOffset().getValue()) );
        }
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
