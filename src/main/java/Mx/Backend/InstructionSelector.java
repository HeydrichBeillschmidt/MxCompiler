package Mx.Backend;

import Mx.ASM.*;
import Mx.ASM.Operand.GlobalVar;
import Mx.IR.*;
import Mx.IR.Instruction.*;
import Mx.IR.TypeSystem.PointerType;

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
    public void visit(IRModule node) {
        for (var gv: node.getGlobalVariables().values()) {
            GlobalVar asmGv = new GlobalVar(gv.getName(),
                    ((PointerType)gv.getType()).getBaseType().size());
            asmModule.getGlobalVars().put(gv.getName(), asmGv);
        }
        for (var ef: node.getExternalFunctions().values()) {
            String name = ef.getName();
            asmModule.getExternalFunctions().put(name,
                    new ASMFunction(name, null) );
        }
        for (var f: node.getFunctions().values()) {
            String name = f.getName();
            asmModule.getFunctions().put(name, new ASMFunction(name, f));
        }
        for (var f: node.getFunctions().values()) {
            f.accept(this);
        }
    }

    @Override
    public void visit(Function node) {}

    @Override
    public void visit(IRBlock node) {
        curBlock = curFunc.getBlocks().get(node.getName());
        IRInst instIte = node.getHeadInst();
        while (instIte!=null) {
            instIte.accept(this);
            instIte = instIte.getNextInst();
        }
    }

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
