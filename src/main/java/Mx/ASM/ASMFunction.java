package Mx.ASM;

import Mx.ASM.Instruction.MV;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.VirtualReg;
import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.Instruction.IRInst;
import Mx.Utils.FuncNameDecorator;
import Mx.Utils.FuncSymbolTable;

import java.util.*;

public class ASMFunction {
    private final String name;
    private final int funcID;

    private final ArrayList<VirtualReg> parameters;
    private int stackedParmsSize;

    private ASMBlock entranceBlock;
    private ASMBlock exitBlock;

    private final Map<String, ASMBlock> blocks;
    private final Map<VirtualReg, Address> unresolvedGEP;
    private final FuncSymbolTable symbolTable;

    public ASMFunction(String name, int funcID, Function irFunc) {
        this.name = name;
        this.funcID = funcID;
        this.blocks = new HashMap<>();
        this.unresolvedGEP = new HashMap<>();
        this.symbolTable = new FuncSymbolTable();
        this.parameters = new ArrayList<>();
        this.stackedParmsSize = 0;

        if (irFunc==null) return;

        // deal with blocks
        ArrayList<IRBlock> irBlocks = irFunc.getAllBlocks();
        for (var b: irBlocks) {
            ASMBlock block = new ASMBlock(b.getName(),
                    ".LBB"+funcID+"_"+blocks.size(),
                    b, this);
            addBlock(block);
        }
        for (var b: irBlocks) {
            ASMBlock block = blocks.get(b.getName());

            for (var p: b.getPredecessors()) block.addPredecessor(blocks.get(p.getName()));
            for (var s: b.getSuccessors()) block.addSuccessor(blocks.get(s.getName()));
        }
        this.entranceBlock = blocks.get(irBlocks.get(0).getName());
        this.exitBlock = blocks.get(irBlocks.get(irBlocks.size()-1).getName());

        // deal with regs
        for (var p: irFunc.getParameterList()) {
            VirtualReg vr = new VirtualReg(p.getType().size()/8, p.getName());
            parameters.add(vr);
            symbolTable.putASMUnique(vr);
        }
        for (var b: irBlocks) {
            for (IRInst instIte = b.getHeadInst(); instIte!=null; instIte = instIte.getNextInst()) {
                if (instIte.needWriteBack()) {
                    int dstSize = instIte.getDst().getType().size()/8;
                    String dstName = instIte.getDst().getName();
                    if (!symbolTable.contains(dstName))
                        symbolTable.putASMUnique(new VirtualReg(dstSize, dstName));
                }
            }
        }
    }

    public String getName() {
        if (FuncNameDecorator.extractPureFuncName(name).equals("main"))
            return "main";
        return name;
    }
    public int getFuncID() {
        return funcID;
    }

    public ArrayList<VirtualReg> getParameters() {
        return parameters;
    }
    public int getStackedParmsSize() {
        return stackedParmsSize;
    }
    public void compareAndSetStParmsSz(int ns) {
        if (ns > stackedParmsSize) stackedParmsSize = ns;
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
    public boolean containsSymbol(String name) {
        return symbolTable.contains(name);
    }
    public VirtualReg getSymbol(String name) {
        return (VirtualReg) symbolTable.get(name).get(0);
    }
    public void removeSymbol(VirtualReg vr) {
        symbolTable.removeASM(vr);
    }

    public ArrayList<ASMBlock> getLiteralOrder() {
        ArrayList<ASMBlock> order = new ArrayList<>();
        for (ASMBlock b = entranceBlock; b!=null; b = b.getNextBlock()) {
            order.add(b);
        }
        return order;
    }
    public ArrayList<ASMBlock> getBFSOrder() {
        ArrayList<ASMBlock> order = new ArrayList<>();
        Queue<ASMBlock> queue = new LinkedList<>();
        Set<ASMBlock> visited = new HashSet<>();
        queue.add(entranceBlock);
        visited.add(entranceBlock);
        do {
            ASMBlock curBlock = queue.poll();
            assert curBlock != null;
            order.add(curBlock);
            for (var s: curBlock.getSuccessors()) {
                if (!visited.contains(s)) queue.offer(s);
            }
            visited.addAll(curBlock.getSuccessors());
        }
        while (!queue.isEmpty());
        return order;
    }
    public ArrayList<ASMBlock> getDFSOrder() {
        ArrayList<ASMBlock> order = new ArrayList<>();
        ArrayList<ASMBlock> visited = new ArrayList<>();
        _dfsRecursive(entranceBlock, order, visited);
        return order;
    }
    private void _dfsRecursive(ASMBlock block, ArrayList<ASMBlock> order,
                               ArrayList<ASMBlock> visited) {
        order.add(block);
        visited.add(block);
        for (var suc: block.getSuccessors()) {
            if (!visited.contains(suc)) {
                _dfsRecursive(suc, order, visited);
            }
        }
    }
    public ArrayList<ASMBlock> getReversedDFSOrder() {
        ArrayList<ASMBlock> order = new ArrayList<>();
        ArrayList<ASMBlock> visited = new ArrayList<>();
        _reversedDFSRecursive(exitBlock, order, visited);
        return order;
    }
    private void _reversedDFSRecursive(ASMBlock block, ArrayList<ASMBlock> order,
                                       ArrayList<ASMBlock> visited) {
        order.add(block);
        visited.add(block);
        for (var pred: block.getPredecessors()) {
            if (!visited.contains(pred)) {
                _dfsRecursive(pred, order, visited);
            }
        }
    }

    public void performLvnAnalysis() {
        for (var b: blocks.values()) b.solveUsesAndDefs();

        ArrayList<ASMBlock> rOrder = getDFSOrder();
        Collections.reverse(rOrder);
        boolean changed = true;
        while (changed) {
            changed = false;
            for (var b: rOrder) {
                Set<VirtualReg> liveInNewer = new HashSet<>();
                Set<VirtualReg> liveOutNewer = new HashSet<>();
                b.collectLiveInsAndOuts(liveInNewer, liveOutNewer);
                if (!liveInNewer.equals(b.getLiveIn())) {
                    b.setLiveIn(liveInNewer);
                    changed = true;
                }
                if (!liveOutNewer.equals(b.getLiveOut())) {
                    b.setLiveOut(liveOutNewer);
                    changed = true;
                }
            }
        }
    }

    public void countStackLen(int stackLen) {
        for (var b: blocks.values()) {
            for (var i: b.getAllInst()) {
                i.countStackLen(stackLen);
            }
        }
    }
    public void removeRedundantMV() {
        for (var b: blocks.values()) {
            for (var i: b.getAllInst()) {
                if (i instanceof MV && i.getRd().getColor()==((MV)i).getRs().getColor()) {
                    i.removeSelfFromBlock();
                }
            }
        }
    }

    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
