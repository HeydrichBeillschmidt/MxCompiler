package Mx.ASM.Operand;

abstract public class Register extends ASMOperand {
    private String name;

    public Register(String name) {
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
