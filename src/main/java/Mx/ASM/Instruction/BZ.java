package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// branch compared with zero
public class BZ extends ASMInst {
    public enum OpName {
        beqz, bnez, bltz, bgez, blez, bgtz
    }

    private final OpName opName;
    private VirtualReg rs1;
    private final ASMBlock dst;

    public BZ(ASMBlock block, OpName opName, VirtualReg rs1, ASMBlock dst) {
        super(block);
        this.opName = opName;
        this.rs1 = rs1;
        this.dst = dst;
    }

    public OpName getOpName() {
        return opName;
    }
    public VirtualReg getRs1() {
        return rs1;
    }
    public ASMBlock getDst() {
        return dst;
    }

    @Override
    public void replaceRs(VirtualReg oldRs, VirtualReg newRs) {
        if (rs1==oldRs) rs1 = newRs;
    }
    @Override
    public Set<VirtualReg> getUses() {
        return new HashSet<>(Collections.singletonList(rs1));
    }
    @Override
    public String emitCode() {
        return "\t" + opName.toString() + "\t" + rs1.emitCode() + ", " + dst.emitCode();
    }
    @Override
    public String toString() {
        return opName.toString() + " " + rs1.toString() + ", " + dst.toString();
    }
}
