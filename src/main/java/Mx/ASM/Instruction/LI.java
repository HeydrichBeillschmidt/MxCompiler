package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.Immediate;
import Mx.ASM.Operand.VirtualReg;

// load immediate
public class LI extends ASMInst {
    private VirtualReg rd;
    private final Immediate imm;

    public LI(ASMBlock block, VirtualReg rd, Immediate imm) {
        super(block);
        this.rd = rd;
        this.imm = imm;

        addDef(rd);
    }

    public VirtualReg getRd() {
        return rd;
    }
    public Immediate getImm() {
        return imm;
    }

    @Override
    public String emitCode() {
        return "\tli\t" + rd.emitCode() + ", " + imm.emitCode();
    }
    @Override
    public String toString() {
        return "li " + rd.toString() + ", " + imm.toString();
    }
}
