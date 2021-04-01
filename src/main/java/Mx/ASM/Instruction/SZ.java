package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMVisitor;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// compare rs with zero
public class SZ extends ASMInst {
    public enum OpName {
        seqz, snez, sltz, sgtz
    }

    private final OpName opName;
    private VirtualReg rs;
    private VirtualReg rd;

    public SZ(ASMBlock block, VirtualReg rd, OpName opName, VirtualReg rs) {
        super(block);
        this.rd = rd;
        this.opName = opName;
        this.rs = rs;
    }

    public OpName getOpName() {
        return opName;
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
        return "\t" + opName.toString() + "\t"
                + rd.emitCode() + ", " + rs.emitCode();
    }
    @Override
    public String toString() {
        return opName.toString() + " " + rd.toString() + ", " + rs.toString();
    }
    @Override
    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
