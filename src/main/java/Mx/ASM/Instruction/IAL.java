package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.Immediate;
import Mx.ASM.Operand.StackPtr;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// I-type arithmetic / logic
public class IAL extends ASMInst {
    public enum OpName {
        addi, slli, srli, srai, andi, ori, xori, slti
    }

    private final OpName opName;
    private VirtualReg rd;
    private VirtualReg rs1;
    private Immediate imm;

    public IAL(ASMBlock block, VirtualReg rd,
               OpName opName, VirtualReg rs1, Immediate imm) {
        super(block);
        this.opName = opName;
        this.rd = rd;
        this.rs1 = rs1;
        this.imm = imm;
    }

    public OpName getOpName() {
        return opName;
    }
    public VirtualReg getRs1() {
        return rs1;
    }
    public Immediate getImm() {
        return imm;
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
    }
    @Override
    public Set<VirtualReg> getUses() {
        return new HashSet<>(Collections.singletonList(rs1));
    }
    @Override
    public Set<VirtualReg> getDefs() {
        return new HashSet<>(Collections.singletonList(rd));
    }
    @Override
    public void countStackLen(int stackLen) {
        if (imm instanceof StackPtr) {
            imm = new Immediate(stackLen * (((StackPtr) imm).isReversed() ? -1 : 1)
                    + imm.getValue());
        }
    }
    @Override
    public String emitCode() {
        return "\t" + opName.toString() + "\t" + rd.emitCode()
                + ", " + rs1.emitCode() + ", " + imm.emitCode();
    }
    @Override
    public String toString() {
        return opName.toString() + " " + rd.toString()
                + ", " + rs1.toString() + ", " + imm.toString();
    }
}
