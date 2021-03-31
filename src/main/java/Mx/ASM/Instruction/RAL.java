package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// R-type arithmetic / logic
public class RAL extends ASMInst {
    public enum OpName {
        add, sub, mul, div, rem, sll, srl, sra, and, or, xor, slt
    }

    private final OpName opName;
    private VirtualReg rd;
    private VirtualReg rs1;
    private VirtualReg rs2;

    public RAL(ASMBlock block, VirtualReg rd,
               OpName opName, VirtualReg rs1, VirtualReg rs2) {
        super(block);
        this.rd = rd;
        this.opName = opName;
        this.rs1 = rs1;
        this.rs2 = rs2;
    }

    public OpName getOpName() {
        return opName;
    }
    public VirtualReg getRs1() {
        return rs1;
    }
    public VirtualReg getRs2() {
        return rs2;
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
        if (rs1==oldRs) rs1 = newRs;
        if (rs2==oldRs) rs2 = newRs;
    }
    @Override
    public Set<VirtualReg> getUses() {
        Set<VirtualReg> ans = new HashSet<>();
        ans.add(rs1);
        ans.add(rs2);
        return ans;
    }
    @Override
    public Set<VirtualReg> getDefs() {
        return new HashSet<>(Collections.singletonList(rd));
    }
    @Override
    public String emitCode() {
        return "\t" + opName.toString() + "\t" + rd.emitCode()
                + ", " + rs1.emitCode() + ", " + rs2.emitCode();
    }
    @Override
    public String toString() {
        return opName.toString() + " " + rd.emitCode()
                + ", " + rs1.emitCode() + ", " + rs2.emitCode();
    }
}
