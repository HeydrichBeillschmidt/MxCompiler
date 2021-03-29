package Mx.ASM.Operand;

abstract public class Reg extends ASMOperand {
    private String name;

    public Reg(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
