package Mx.ASM.Instruction;

import Mx.ASM.ASMBlock;

public class JP extends ASMInst {
    private ASMBlock dst;

    public JP(ASMBlock block, ASMBlock dst) {
        super(block);
        this.dst = dst;
    }

    public ASMBlock getDst() {
        return dst;
    }
    public void setDst(ASMBlock dst) {
        this.dst = dst;
    }

    @Override
    public String emitCode() {
        assert dst!=null;
        return "\tj\t" + dst.emitCode();
    }
    @Override
    public String toString() {
        return "j " + dst.toString();
    }
}
