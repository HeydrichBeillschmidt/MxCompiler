package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMFunction;
import Mx.ASM.Operand.PhysicalReg;

public class CALL extends ASMInst {
    private final ASMFunction callee;

    public CALL(ASMBlock block, ASMFunction callee) {
        super(block);
        this.callee = callee;

        addUses(PhysicalReg.argVRs);
        addDefs(PhysicalReg.callerSaveVRs);
    }

    public ASMFunction getCallee() {
        return callee;
    }

    @Override
    public String emitCode() {
        return "\tcall\t" + callee.getName();
    }
    @Override
    public String toString() {
        return "call " + callee.getName();
    }
}
