package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMFunction;
import Mx.ASM.Operand.PhysicalReg;
import Mx.ASM.Operand.VirtualReg;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class CALL extends ASMInst {
    private final ASMFunction callee;

    public CALL(ASMBlock block, ASMFunction callee) {
        super(block);
        this.callee = callee;
    }

    public ASMFunction getCallee() {
        return callee;
    }

    @Override
    public Set<VirtualReg> getUses() {
        return new HashSet<>(PhysicalReg.argVRs.subList(0,
                Integer.min(callee.getParameters().size(), 8)) );
    }
    @Override
    public Set<VirtualReg> getDefs() {
        return new HashSet<>(PhysicalReg.callerSaveVRs);
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
