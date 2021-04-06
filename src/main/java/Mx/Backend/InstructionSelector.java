package Mx.Backend;

import Mx.ASM.*;
import Mx.ASM.Instruction.*;
import Mx.ASM.Operand.*;
import Mx.IR.*;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.*;
import Mx.IR.TypeSystem.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class InstructionSelector implements IRVisitor {
    private final ASMModule asmModule;
    private ASMFunction curFunc;
    private ASMBlock curBlock;
    private final Map<Integer, VirtualReg> RdsOfLI;

    public InstructionSelector() {
        asmModule = new ASMModule();
        RdsOfLI = new HashMap<>();
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
                    ((PointerType)gv.getType()).getBaseType().size()/8);
            asmModule.getGlobalVars().put(gv.getName(), asmGv);

            IRType type = ((PointerType)gv.getType()).getBaseType();
            Operand init = gv.getInit();

            if (type instanceof ArrayType) {
                asmGv.setStrVal(((ConstString)init).getValue());
            }
            else if (type.equals(IRModule.int32T)) {
                asmGv.setIntVal(((ConstInt)init).getValue());
            }
            else if (type.equals(IRModule.boolT)) {
                asmGv.setBoolVal(((ConstBool)init).getValue() ? 1 : 0);
            }
            else asmGv.setIntVal(0);
        }
        for (var ef: node.getExternalFunctions().values()) {
            String name = ef.getName();
            ASMFunction aef = new ASMFunction(name,
                    asmModule.getExternalFunctions().size(), null);
            asmModule.getExternalFunctions().put(name, aef);
        }
        for (var f: node.getFunctions().values()) {
            String name = f.getName();
            if (name.equals("___init__$$YGXXZ")) continue;
            ASMFunction af = new ASMFunction(name,
                    asmModule.getFunctions().size(), f);
            asmModule.getFunctions().put(name, af);
        }
        for (var f: node.getFunctions().values()) {
            f.accept(this);
        }
    }

    @Override
    public void visit(Function node) {
        String funcName = node.getName();
        if (funcName.equals("___init__$$YGXXZ")) return;
        curFunc = asmModule.getFunction(funcName);
        curBlock = curFunc.getEntranceBlock();

        // set sp
        StackPtr stackBase = new StackPtr(0);
        stackBase.reverse();
        VirtualReg sp = PhysicalReg.spVR;
        curBlock.addInst(new IAL(curBlock, sp, IAL.OpName.addi, sp, stackBase));

        // save ra and callee-save regs
        VirtualReg savedVR = new VirtualReg(4, PhysicalReg.raVR.getName()+".save");
        curFunc.addSymbolUnique(savedVR);
        curBlock.addInst(new MV(curBlock, savedVR, PhysicalReg.raVR));
        for (var vr: PhysicalReg.calleeSaveVRs) {
            savedVR = new VirtualReg(4, vr.getName()+".save");
            curFunc.addSymbolUnique(savedVR);
            curBlock.addInst(new MV(curBlock, savedVR, vr));
        }

        // move parameters to reg
        for (int i = 0, it = Integer.min(curFunc.getParameters().size(), 8); i < it; ++i) {
            curBlock.addInst(new MV(curBlock,
                    curFunc.getParameters().get(i), PhysicalReg.argVRs.get(i)));
        }
        int paraOffset = 0;
        for (int i = 8, it = curFunc.getParameters().size(); i < it; ++i) {
            Parameter p = node.getParameterList().get(i);
            VirtualReg vr = curFunc.getParameters().get(i);
            StackPtr stackPtr = new StackPtr(paraOffset);
            curBlock.addInst(new LD(curBlock, p.getType().size()/8,
                    vr, new Address(PhysicalReg.spVR, stackPtr)) );
            paraOffset += 4;
        }

        for (var b: node.getAllBlocks())
            b.accept(this);
    }

    @Override
    public void visit(IRBlock node) {
        curBlock = curFunc.getBlocks().get(node.getName());
        for (var i: node.getAllInst()) {
            i.accept(this);
        }
    }

    @Override
    public void visit(Alloca node) {

    }

    @Override
    public void visit(BinaryOp node) {
        addBinaryInst(resolveToVR(node.getDst()), node.getOpName(),
                node.getOp1(), node.getOp2(), node.isCommutable() );
    }

    @Override
    public void visit(BitCast node) {
        VirtualReg src = resolveToVR(node.getSrc());
        VirtualReg dst = resolveToVR(node.getDst());
        if (src instanceof GlobalVar) {
            curBlock.addInst(new LA(curBlock, dst, (GlobalVar) src) );
        }
        else {
            curBlock.addInst(new MV(curBlock, dst, src) );
        }
    }

    @Override
    public void visit(Br node) {
        if (node.getCondition()==null) {
            ASMBlock thenBlock = curFunc.getBlocks().get(node.getThenBlock().getName());
            curBlock.addInst(new JP(curBlock, thenBlock));
        }
        else {
            Operand cond = node.getCondition();
            ASMBlock thenBlock = curFunc.getBlocks().get(node.getThenBlock().getName());
            ASMBlock elseBlock = curFunc.getBlocks().get(node.getElseBlock().getName());
            if (cond instanceof Register
                    && ((Register)cond).isForBranch(node.getBlock())
                    && ((Register)cond).getDef() instanceof Icmp) {
                Icmp icmp = (Icmp) ((Register)cond).getDef();
                Operand op1 = icmp.getOp1();
                Operand op2 = icmp.getOp2();
                BR.OpName opName;
                switch (icmp.getOpName()) {
                    case eq: opName = BR.OpName.beq; break;
                    case ne: opName = BR.OpName.bne; break;
                    case slt:opName = BR.OpName.blt; break;
                    case sge:opName = BR.OpName.bge; break;
                    case sle:opName = BR.OpName.ble; break;
                    default :opName = BR.OpName.bgt; break;
                }
                curBlock.addInst(new BR(curBlock, opName,
                        resolveToVR(op1), resolveToVR(op2), thenBlock));
                curBlock.addInst(new JP(curBlock, elseBlock));
            }
            else {
                curBlock.addInst(new BZ(curBlock, BZ.OpName.beqz, resolveToVR(cond), elseBlock));
                curBlock.addInst(new JP(curBlock, thenBlock));
            }
        }
    }

    @Override
    public void visit(Call node) {
        ASMFunction callee = asmModule.getFunction(node.getCallee().getName());
        if (callee==null) return;

        // move first 8 parameters to a0-a7, then save the rest
        ArrayList<Operand> irParameters = node.getParameterList();
        for (int i = 0, it = Integer.min(8, irParameters.size()); i < it; ++i) {
            VirtualReg vr = resolveToVR(irParameters.get(i));
            curBlock.addInst(new MV(curBlock, PhysicalReg.argVRs.get(i), vr));
        }
        int stackedParasSz = 0;
        for (int i = 8, it = irParameters.size(); i < it; ++i) {
            Operand p = irParameters.get(i);
            curBlock.addInst(new ST(curBlock, p.getType().size()/8, resolveToVR(p),
                    new Address(PhysicalReg.spVR, new Immediate(stackedParasSz)) ) );
            stackedParasSz += 4;
        }
        curFunc.compareAndSetStParmsSz(stackedParasSz);

        curBlock.addInst(new CALL(curBlock, callee));
        if (node.isVoidCall()) {
            curBlock.addInst(new MV(curBlock, resolveToVR(node.getDst()),
                    PhysicalReg.argVRs.get(0)) );
        }
    }

    @Override
    public void visit(GetElementPtr node) {
        VirtualReg rd = resolveToVR(node.getDst());
        if (node.getPtr() instanceof GlobalVariable) { // string literal
            curBlock.addInst(new LA(curBlock, rd,
                    (GlobalVar) resolveToVR(node.getPtr()) ) );
        }
        else if (node.getIndex().size()==1) { // array
            Operand idx = node.getIndex().get(0);
            int typeSize = node.getType().size() / 8;
            if (idx instanceof Constant) {
                int offset = ((ConstInt)idx).getValue() * typeSize;
                addBinaryInst(rd, BinaryOp.BinaryOpName.add, node.getPtr(),
                        new ConstInt(offset, 32), true);
            }
            else {
                VirtualReg ptr = resolveToVR(node.getPtr());
                VirtualReg rTmp = new VirtualReg(4, "mul");
                curFunc.addSymbolMultiple(rTmp);
                addBinaryInst(rTmp, BinaryOp.BinaryOpName.mul,
                        idx, new ConstInt(typeSize, 32), true);
                curBlock.addInst(new RAL(curBlock, rd, RAL.OpName.add, ptr, rTmp));
            }
        }
        else { // class
            if (node.getPtr() instanceof Null) {
                curBlock.addInst(new IAL(curBlock, rd, IAL.OpName.addi, PhysicalReg.zeroVR,
                        new Immediate( ((ConstInt)node.getIndex().get(1)).getValue() ) ) );
            }
            else {
                StructureType structT = (StructureType)
                        ((PointerType)node.getPtr().getType()).getBaseType();
                int idx = ((ConstInt)node.getIndex().get(1)).getValue();
                int offset = structT.calcOffset(idx)/8;
                if (structT.getMemberTypes().get(idx) instanceof PointerType) {
                    addBinaryInst(rd, BinaryOp.BinaryOpName.add, node.getPtr(),
                            new ConstInt(offset, 32), true);
                }
                else {
                    VirtualReg ptr = resolveToVR(node.getPtr());
                    curFunc.getUnresolvedGEP().put(rd, new Address(ptr, new Immediate(offset)));
                }
            }
        }
    }

    @Override
    public void visit(Icmp node) {
        if (node.getDst().isForBranch(node.getBlock())) return;
        switch (node.getOpName()) {
            case eq: {
                VirtualReg rTmp = new VirtualReg(4, "xor");
                curFunc.addSymbolMultiple(rTmp);
                addBinaryInst(rTmp, BinaryOp.BinaryOpName.xor,
                        node.getOp1(), node.getOp2(), true);
                curBlock.addInst(new SZ(curBlock, resolveToVR(node.getDst()),
                        SZ.OpName.seqz, rTmp) );
                break;
            }
            case ne: {
                VirtualReg rTmp = new VirtualReg(4, "xor");
                curFunc.addSymbolMultiple(rTmp);
                addBinaryInst(rTmp, BinaryOp.BinaryOpName.xor,
                        node.getOp1(), node.getOp2(), true);
                curBlock.addInst(new SZ(curBlock, resolveToVR(node.getDst()),
                        SZ.OpName.snez, rTmp) );
                break;
            }
            case slt: {
                addSLTInst(resolveToVR(node.getDst()), node.getOp1(), node.getOp2());
                break;
            }
            case sge: {
                VirtualReg rTmp = new VirtualReg(4, "slt");
                curFunc.addSymbolMultiple(rTmp);
                addSLTInst(rTmp, node.getOp1(), node.getOp2());
                curBlock.addInst(new IAL(curBlock, resolveToVR(node.getDst()),
                        IAL.OpName.xori, rTmp, new Immediate(1)) );
                break;
            }
            case sle: {
                VirtualReg rTmp = new VirtualReg(4, "slt");
                curFunc.addSymbolMultiple(rTmp);
                addSLTInst(rTmp, node.getOp2(), node.getOp1());
                curBlock.addInst(new IAL(curBlock, resolveToVR(node.getDst()),
                        IAL.OpName.xori, rTmp, new Immediate(1)) );
                break;
            }
            default: {
                addSLTInst(resolveToVR(node.getDst()), node.getOp2(), node.getOp1());
                break;
            }
        }
    }

    @Override
    public void visit(Load node) {
        VirtualReg rd = resolveToVR(node.getDst());
        VirtualReg addr = resolveToVR(node.getAddr());
        int size = node.getLoadType().size() / 8;
        if (addr instanceof GlobalVar) {
            VirtualReg lui = new VirtualReg(4, "lui");
            curFunc.addSymbolMultiple(lui);
            curBlock.addInst(new LUI(curBlock, lui,
                    new RelocationImm((GlobalVar) addr, true) ) );
            curBlock.addInst(new LD(curBlock, size, rd,
                    new Address(lui, new RelocationImm((GlobalVar) addr, false)) ) );
        }
        else if (curFunc.getUnresolvedGEP().containsKey(addr)) {
            curBlock.addInst(new LD(curBlock, size, rd,
                    curFunc.getUnresolvedGEP().get(addr) ) );
        }
        else {
            curBlock.addInst(new LD(curBlock, size, rd,
                    new Address(addr, new Immediate(0)) ) );
        }
    }

    @Override
    public void visit(Move node) {
        // well, before optimization there's no IR move inst.
    }

    @Override
    public void visit(Phi node) {

    }

    @Override
    public void visit(Ret node) {
        if (!(node.getRetType() instanceof VoidType)) {
            VirtualReg retVal = resolveToVR(node.getRetValue());
            if (retVal instanceof GlobalVar) {
                curBlock.addInst(new LA(curBlock,
                        PhysicalReg.argVRs.get(0), (GlobalVar) retVal) );
            }
            else {
                curBlock.addInst(new MV(curBlock,
                        PhysicalReg.argVRs.get(0), retVal) );
            }
        }

        // recover ra and callee-save regs
        VirtualReg savedVR;
        for (var vr: PhysicalReg.calleeSaveVRs) {
            savedVR = curFunc.getSymbol(vr.getName() + ".save");
            curBlock.addInst(new MV(curBlock, vr, savedVR));
        }
        savedVR = curFunc.getSymbol(PhysicalReg.raVR.getName() + ".save");
        curBlock.addInst(new MV(curBlock, PhysicalReg.raVR, savedVR));

        curBlock.addInst(new IAL(curBlock, PhysicalReg.spVR,
                IAL.OpName.addi, PhysicalReg.spVR, new StackPtr(0) ) );

        curBlock.addInst(new RET(curBlock));
    }

    @Override
    public void visit(Store node) {
        VirtualReg addr = resolveToVR(node.getAddr());
        VirtualReg value = resolveToVR(node.getValue());
        int size = node.getValue().getType().size() / 8;
        if (addr instanceof GlobalVar) {
            VirtualReg lui = new VirtualReg(4, "lui");
            curFunc.addSymbolMultiple(lui);
            curBlock.addInst(new LUI(curBlock, lui,
                    new RelocationImm((GlobalVar) addr, true) ) );
            curBlock.addInst(new ST(curBlock, size, value,
                    new Address(lui, new RelocationImm((GlobalVar) addr, false)) ) );
        }
        else if (curFunc.getUnresolvedGEP().containsKey(addr)) {
            curBlock.addInst(new ST(curBlock, size, value,
                    curFunc.getUnresolvedGEP().get(addr) ) );
        }
        else {
            curBlock.addInst(new ST(curBlock, size, value,
                    new Address(addr, new Immediate(0)) ) );
        }
    }

    private VirtualReg resolveToVR(Operand os) {
        if (os instanceof Register) {
            if (!curFunc.containsSymbol(((Register) os).getName())) {
                curFunc.addSymbolUnique(new VirtualReg(os.getType().size()/8,
                        ((Register) os).getName() ) );
            }
            return curFunc.getSymbol(((Register)os).getName());
        }
        else if (os instanceof Parameter) {
            return curFunc.getSymbol(((Parameter)os).getName());
        }
        else if (os instanceof ConstBool) {
            int value = ((ConstBool) os).getValue() ? 1 : 0;
            if (value!=0) {
                if (RdsOfLI.containsKey(value)) return RdsOfLI.get(value);
                VirtualReg vr = new VirtualReg(4, "constBool");
                RdsOfLI.put(value, vr);
                curFunc.addSymbolMultiple(vr);
                curBlock.addInst(new LI(curBlock, vr, new Immediate(value)));
                return vr;
            }
        }
        else if (os instanceof ConstInt) {
            int value = ((ConstInt)os).getValue();
            if (value!=0) {
                if (RdsOfLI.containsKey(value)) return RdsOfLI.get(value);
                VirtualReg vr = new VirtualReg(4, "constInt");
                RdsOfLI.put(value, vr);
                curFunc.addSymbolMultiple(vr);
                curBlock.addInst(new LI(curBlock, vr, new Immediate(value)));
                return vr;
            }
        }
        else if (os instanceof GlobalVariable) {
            return asmModule.getGlobalVars().get(((GlobalVariable)os).getName());
        }
        return PhysicalReg.zeroVR;
    }

    private boolean reasonableImm(Operand o) {
        return o instanceof ConstInt && reasonableIntVal(((ConstInt) o).getValue());
    }
    private boolean reasonableIntVal(int i) {
        return (i < (1<<11)) && (i >= -(1<<11));
    }

    private int mulToSllOrNot(int n) {
        int ans = 0;
        while (n > 1) {
            if (n % 2 == 0) {
                n /= 2;
                ++ans;
            }
            else return -1;
        }
        return ans;
    }
    private void addBinaryInst(VirtualReg rd, BinaryOp.BinaryOpName opName,
                               Operand op1, Operand op2, boolean commutable) {
        boolean toIType = true;
        VirtualReg rs = PhysicalReg.zeroVR;
        Immediate imm = new Immediate(0);
        switch (opName) {
            case sdiv: case srem: toIType = false; break;
            case mul: {
                if (reasonableImm(op1)) {
                    int tmp = mulToSllOrNot(((ConstInt)op1).getValue());
                    if (tmp!=-1) {
                        rs = resolveToVR(op2);
                        imm = new Immediate(tmp);
                        break;
                    }
                }
                if (reasonableImm(op2)) {
                    int tmp = mulToSllOrNot(((ConstInt)op2).getValue());
                    if (tmp!=-1) {
                        rs = resolveToVR(op1);
                        imm = new Immediate(tmp);
                        break;
                    }
                }
                toIType = false;
                break;
            }
            default: {
                if (commutable && reasonableImm(op1)) {
                    rs = resolveToVR(op2);
                    imm = new Immediate(((ConstInt)op1).getValue());
                    break;
                }
                if (reasonableImm(op2)) {
                    rs = resolveToVR(op1);
                    if (opName== BinaryOp.BinaryOpName.sub)
                        imm = new Immediate(-1*((ConstInt)op2).getValue());
                    else
                        imm = new Immediate(((ConstInt)op2).getValue());
                    break;
                }
                toIType = false;
            }
        }
        if (toIType) {
            IAL.OpName asmOpName;
            switch (opName) {
                case add: case sub: asmOpName = IAL.OpName.addi; break;
                case mul: case shl: asmOpName = IAL.OpName.slli; break;
                case ashr:  asmOpName = IAL.OpName.srai; break;
                case and:   asmOpName = IAL.OpName.andi; break;
                case or:    asmOpName = IAL.OpName.ori; break;
                default:    asmOpName = IAL.OpName.xori;
            }
            curBlock.addInst(new IAL(curBlock, rd, asmOpName, rs, imm) );
        }
        else {
            RAL.OpName asmOpName;
            switch (opName) {
                case add: asmOpName = RAL.OpName.add; break;
                case sub: asmOpName = RAL.OpName.sub; break;
                case mul: asmOpName = RAL.OpName.mul; break;
                case sdiv:asmOpName = RAL.OpName.div; break;
                case srem:asmOpName = RAL.OpName.rem; break;
                case shl: asmOpName = RAL.OpName.sll; break;
                case ashr:asmOpName = RAL.OpName.sra; break;
                case and: asmOpName = RAL.OpName.and; break;
                case or:  asmOpName = RAL.OpName.or;  break;
                default:  asmOpName = RAL.OpName.xor;
            }
            curBlock.addInst(new RAL(curBlock, rd, asmOpName,
                    resolveToVR(op1), resolveToVR(op2) ) );
        }
    }
    private void addSLTInst(VirtualReg rd, Operand op1, Operand op2) {
        if (reasonableImm(op2)) {
            curBlock.addInst(new IAL(curBlock, rd, IAL.OpName.slti,
                    resolveToVR(op1), new Immediate(((ConstInt)op2).getValue()) ) );
        }
        else {
            curBlock.addInst(new RAL(curBlock, rd, RAL.OpName.slt,
                    resolveToVR(op1), resolveToVR(op2) ) );
        }
    }
}
