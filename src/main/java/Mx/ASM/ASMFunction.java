package Mx.ASM;

import Mx.ASM.Operand.VirtualReg;
import Mx.IR.Function;
import Mx.IR.IRBlock;
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
    private final FuncSymbolTable symbolTable;

    public ASMFunction(String name, Function irFunc) {
        this.name = name;
        this.blocks = new HashMap<>();
        this.symbolTable = new FuncSymbolTable();
        this.parameters = new ArrayList<>();

        if (irFunc==null) return;

        ArrayList<IRBlock> irBlocks = irFunc.getAllBlocks();
        for (var b: irBlocks) {
            ASMBlock block = new ASMBlock(b.getName(), b);
            addBlock(block);
            blocks.put(block.getName(), block);
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


        for (var p: irFunc.getParameterList()) {
            VirtualReg vr = new VirtualReg(p.getName());
            parameters.add(vr);
            symbolTable.putASM(vr);
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
    }

    public Map<String, ASMBlock> getBlocks() {
        return blocks;
    }
    public FuncSymbolTable getSymbolTable() {
        return symbolTable;
    }
}
