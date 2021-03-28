package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.Immediate;
import Mx.ASM.Operand.VirtualReg;

// I-type arithmetic / logic
public class IAL extends ASMInst {
    public enum OpName {
        addi, slli, srli, srai, andi, ori, xori, slti
    }

    private final OpName opName;
    private VirtualReg rd;
    private VirtualReg rs1;
    private final Immediate imm;

    public IAL(ASMBlock block, VirtualReg rd,
               OpName opName, VirtualReg rs1, Immediate imm) {
        super(block);
        this.opName = opName;
        this.rd = rd;
        this.rs1 = rs1;
        this.imm = imm;

        addUse(rs1);
        addDef(rd);
    }

    public VirtualReg getRd() {
        return rd;
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
