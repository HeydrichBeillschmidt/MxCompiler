package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;

public class MV extends ASMInst {
    private VirtualReg rd;
    private VirtualReg rs;

    public MV(ASMBlock block, VirtualReg rd, VirtualReg rs) {
        super(block);
        this.rd = rd;
        this.rs = rs;

        addUse(rs);
        addDef(rd);
    }

    @Override
    public String emitCode() {
        return "\tmv\t" + rd.emitCode() + ", " + rs.emitCode();
    }
    @Override
    public String toString() {
        return "mv " + rd.toString() + ", " + rs.toString();
    }
}
