package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMVisitor;
import Mx.ASM.Operand.Immediate;
import Mx.ASM.Operand.VirtualReg;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

// load upper immediate
public class LUI extends ASMInst {
    private VirtualReg rd;
    private final Immediate imm;

    public LUI(ASMBlock block, VirtualReg rd, Immediate imm) {
        super(block);
        this.rd = rd;
        this.imm = imm;
    }

    public Immediate getImm() {
        return imm;
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
        return "\tlui\t" + rd.emitCode() + ", " + imm.emitCode();
    }
    @Override
    public String toString() {
        return "lui " + rd.toString() + ", " + imm.toString();
    }
    @Override
    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
