package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMVisitor;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class MV extends ASMInst {
    private VirtualReg rd;
    private VirtualReg rs;

    public MV(ASMBlock block, VirtualReg rd, VirtualReg rs) {
        super(block);
        this.rd = rd;
        this.rs = rs;
    }

    public VirtualReg getRs() {
        return rs;
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
        if (rs==oldRs) rs = newRs;
    }
    @Override
    public Set<VirtualReg> getUses() {
        return new HashSet<>(Collections.singletonList(rs));
    }
    @Override
    public Set<VirtualReg> getDefs() {
        return new HashSet<>(Collections.singletonList(rd));
    }
    @Override
    public String emitCode() {
        return "\tmv\t" + rd.emitCode() + ", " + rs.emitCode();
    }
    @Override
    public String toString() {
        return "mv " + rd.toString() + ", " + rs.toString();
    }
    @Override
    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
