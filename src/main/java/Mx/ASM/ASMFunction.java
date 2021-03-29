package Mx.ASM;

import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.VirtualReg;
import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.Instruction.IRInst;
import Mx.Utils.FuncSymbolTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ASMFunction {
    private final String name;

    private final ArrayList<VirtualReg> parameters;

    private ASMBlock entranceBlock;
    private ASMBlock exitBlock;

    private final Map<String, ASMBlock> blocks;
    private final Map<VirtualReg, Address> unresolvedGEP;
    private final FuncSymbolTable symbolTable;

    public ASMFunction(String name, int funcID, Function irFunc) {
        this.name = name;
        this.blocks = new HashMap<>();
        this.unresolvedGEP = new HashMap<>();
        this.symbolTable = new FuncSymbolTable();
        this.parameters = new ArrayList<>();

        if (irFunc==null) return;

        // deal with blocks
        ArrayList<IRBlock> irBlocks = irFunc.getAllBlocks();
        for (var b: irBlocks) {
            ASMBlock block = new ASMBlock(b.getName(),
                    ".LBB"+funcID+"_"+blocks.size(), b);
            addBlock(block);
        }
        for (var b: irBlocks) {
            ASMBlock block = blocks.get(b.getName());
            ArrayList<ASMBlock> predecessors = block.getPredecessors();
            ArrayList<ASMBlock> successors = block.getSuccessors();

            for (var p: b.getPredecessors()) predecessors.add(blocks.get(p.getName()));
            for (var s: b.getSuccessors()) successors.add(blocks.get(s.getName()));
        }
        this.entranceBlock = blocks.get(irBlocks.get(0).getName());
        this.exitBlock = blocks.get(irBlocks.get(irBlocks.size()-1).getName());

        // deal with regs
        for (var p: irFunc.getParameterList()) {
            VirtualReg vr = new VirtualReg(p.getName());
            parameters.add(vr);
            symbolTable.putASMUnique(vr);
        }
        for (var b: irBlocks) {
            IRInst instIte = b.getHeadInst();
            while (instIte!=null) {
                if (instIte.needWriteBack()) {
                    VirtualReg vr = new VirtualReg(instIte.getDst().getName());
                    symbolTable.putASMUnique(vr);
                }

                instIte = instIte.getNextInst();
            }
        }
    }

    public String getName() {
        return name;
    }

    public ArrayList<VirtualReg> getParameters() {
        return parameters;
    }

    public ASMBlock getEntranceBlock() {
        return entranceBlock;
    }
    public void addBlock(ASMBlock block) {
        if (entranceBlock==null) entranceBlock = block;
        else exitBlock.addBlock(block);
        exitBlock = block;
        blocks.put(block.getName(), block);
    }

    public Map<String, ASMBlock> getBlocks() {
        return blocks;
    }
    public Map<VirtualReg, Address> getUnresolvedGEP() {
        return unresolvedGEP;
    }
    public FuncSymbolTable getSymbolTable() {
        return symbolTable;
    }
    public void addSymbolUnique(VirtualReg vr) {
        symbolTable.putASMUnique(vr);
    }
    public void addSymbolMultiple(VirtualReg vr) {
        symbolTable.putASMMultiple(vr);
    }
    public VirtualReg getSymbol(String name) {
        return (VirtualReg) symbolTable.get(name).get(0);
    }
}
