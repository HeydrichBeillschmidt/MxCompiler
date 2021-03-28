package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

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

        addUse(rs);
        addDef(rd);
    }

    public VirtualReg getRd() {
        return rd;
    }
    public OpName getOpName() {
        return opName;
    }
    public VirtualReg getRs() {
        return rs;
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
}
