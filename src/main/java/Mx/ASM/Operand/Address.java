package Mx.ASM.Operand;

abstract public class Address {
    abstract public VirtualReg getBase();
    abstract public int getOffset();

    abstract public String emitCode();
    @Override
    abstract public String toString();
    @Override
    abstract public boolean equals(Object obj);
}