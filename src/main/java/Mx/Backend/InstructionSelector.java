package Mx.Backend;

import Mx.ASM.*;
import Mx.IR.*;
import Mx.IR.Instruction.*;

public class InstructionSelector implements IRVisitor {
    private final ASMModule asmModule;
    private ASMFunction curFunc;
    private ASMBlock curBlock;

    public InstructionSelector() {
        asmModule = new ASMModule();
        curBlock = null;
        curFunc = null;
    }

    public ASMModule getAsmModule() {
        return asmModule;
    }

    @Override
    public void visit(IRModule node) {}

    @Override
    public void visit(Function node) {}

    @Override
    public void visit(IRBlock node) {}

    @Override
    public void visit(Alloca node) {}

    @Override
    public void visit(BinaryOp node) {}

    @Override
    public void visit(BitCast node) {}

    @Override
    public void visit(Br node) {}

    @Override
    public void visit(Call node) {}

    @Override
    public void visit(GetElementPtr node) {}

    @Override
    public void visit(Icmp node) {}

    @Override
    public void visit(Load node) {}

    @Override
    public void visit(Phi node) {}

    @Override
    public void visit(Ret node) {}

    @Override
    public void visit(Store node) {}
}
