package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

import java.util.HashSet;
import java.util.Set;

// branch
public class BR extends ASMInst {
    public enum OpName {
        beq, bne, blt, bge, ble, bgt
    }

    private final OpName opName;
    private VirtualReg rs1;
    private VirtualReg rs2;
    private final ASMBlock dst;

    public BR(ASMBlock block, OpName opName, VirtualReg rs1, VirtualReg rs2, ASMBlock dst) {
        super(block);
        this.opName = opName;
        this.rs1 = rs1;
        this.rs2 = rs2;
        this.dst = dst;
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
    public ASMBlock getDst() {
        return dst;
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
    public String emitCode() {
        return "\t" + opName.toString() + "\t" + rs1.emitCode()
                + ", " + rs2.emitCode() + ", " + dst.emitCode();
    }
    @Override
    public String toString() {
        return opName.toString() + " " + rs1.emitCode()
                + ", " + rs2.emitCode() + ", " + dst.emitCode();
    }
}
