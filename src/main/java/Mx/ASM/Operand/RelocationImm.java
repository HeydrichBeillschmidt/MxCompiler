package Mx.ASM.Operand;

public class RelocationImm extends Immediate {
    private final boolean atHi;
    private final GlobalVar relocated;

    public RelocationImm(GlobalVar relocated, boolean atHi) {
        super(0);
        this.relocated = relocated;
        this.atHi = atHi;
    }

    @Override
    public String emitCode() {
        return "%" + (atHi?"hi":"lo") + "(" + relocated.getName() + ")";
    }
    @Override
    public String toString() {
        return "%" + (atHi?"hi":"lo") + "(" + relocated.getName() + ")";
    }
    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof RelocationImm)) return false;
        return atHi==((RelocationImm)obj).atHi
                && relocated==((RelocationImm)obj).relocated;
    }
}
