package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.GlobalVar;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// load address
public class LA extends ASMInst {
    private VirtualReg rd;
    private final GlobalVar globalVar;

    public LA(ASMBlock block, VirtualReg rd, GlobalVar globalVar) {
        super(block);
        this.rd = rd;
        this.globalVar = globalVar;
    }

    public GlobalVar getGlobalVar() {
        return globalVar;
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
    public Set<VirtualReg> getDefs() {
        return new HashSet<>(Collections.singletonList(rd));
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
