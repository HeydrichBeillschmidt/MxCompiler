package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.GlobalVar;
import Mx.ASM.Operand.VirtualReg;

// load address
public class LA extends ASMInst {
    private final VirtualReg rd;
    private final GlobalVar globalVar;

    public LA(ASMBlock block, VirtualReg rd, GlobalVar globalVar) {
        super(block);
        this.rd = rd;
        this.globalVar = globalVar;

        addDef(rd);
    }

    public VirtualReg getRd() {
        return rd;
    }
    public GlobalVar getGlobalVar() {
        return globalVar;
    }

    @Override
    public String emitCode() {
        return "\tla\t" + rd.emitCode() + ", " + globalVar.getName();
    }
    @Override
    public String toString() {
        return "la " + rd.getName() + ", " + globalVar.getName();
    }
}
