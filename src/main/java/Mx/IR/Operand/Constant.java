package Mx.IR.Operand;

import Mx.IR.Instruction.IRInst;
import Mx.IR.TypeSystem.IRType;

import java.util.ArrayList;

abstract public class Constant extends Operand {
    public Constant(IRType type) {
        super(type);
    }

    @Override
    public void addUse(IRInst inst) {}
    @Override
    public void addUses(ArrayList<IRInst> insts) {}
    @Override
    public void removeUse(IRInst inst) {}

    @Override
    public boolean isConstant() {return true;}
    @Override
    abstract public boolean equals(Object obj);
}
