package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMFunction;
import Mx.ASM.Operand.PhysicalReg;
import Mx.ASM.Operand.VirtualReg;

import java.util.ArrayList;

public class CALL extends ASMInst {
    private final ASMFunction callee;

    public CALL(ASMBlock block, ASMFunction callee) {
        super(block);
        this.callee = callee;

        addUses((ArrayList<VirtualReg>)
                (PhysicalReg.argVRs.subList(0,
                        Integer.min(callee.getParameters().size(), 8))) );
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
