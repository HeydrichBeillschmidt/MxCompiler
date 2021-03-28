package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

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

        addUse(rs1);
        addUse(rs2);
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
    public VirtualReg getRs2() {
        return rs2;
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
