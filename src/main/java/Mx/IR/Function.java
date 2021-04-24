package Mx.IR;

import Mx.IR.Instruction.*;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.FunctionType;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;
import Mx.IR.TypeSystem.VoidType;
import Mx.Utils.Errors.SyntaxError;
import Mx.Utils.ExceptionHandler;
import Mx.Utils.FuncNameDecorator;
import Mx.Utils.FuncSymbolTable;

import java.util.*;

public class Function {
    private final IRModule module;

    private final String name;
    private final FunctionType functionType;
    private final ArrayList<Parameter> parameterList;
    private IRBlock entranceBlock;
    private IRBlock exitBlock;
    private final IRBlock returnBlock;
    private Register retVal;
    private Register classPtr;
    private final FuncSymbolTable symbolTable;
    private final Set<Call> callSites;
    private boolean sideEffect;

    public Function(IRModule module, IRType retType, String name,
                    ArrayList<Parameter> parameterList) {
        this.module = module;
        this.name = name;
        this.symbolTable = new FuncSymbolTable();
        this.parameterList = parameterList;
        ArrayList<IRType> parameterTypeList = new ArrayList<>();
        for (var p: parameterList) {
            parameterTypeList.add(p.getType());
            symbolTable.putIR(p);
        }
        this.functionType = new FunctionType(retType, parameterTypeList);
        this.entranceBlock = null;
        this.callSites = new HashSet<>();
        this.sideEffect = false;
        this.retVal = null;
        this.classPtr = null;

        addBlock(new IRBlock("entry"));
        this.returnBlock = new IRBlock("return");
        if (retType==null || retType instanceof VoidType) {
            returnBlock.addInst(new Ret(returnBlock,
                    new VoidType(), null));
        }
        else {
            retVal = new Register(new PointerType(retType),
                    "retval$addr");
            entranceBlock.addInst(new Alloca(entranceBlock, retVal, retType));
            entranceBlock.addInst(new Store(entranceBlock, retType.getDefaultValue(), retVal));
            Register returnValue = new Register(retType, "retval");
            returnBlock.addInst(new Load(returnBlock, returnValue, retType, retVal));
            returnBlock.addInst(new Ret(returnBlock, retType, returnValue));
            symbolTable.putIR(retVal);
            symbolTable.putIR(returnValue);
        }
    }

    public IRModule getModule() {
        return module;
    }
    public String getName() {
        return name;
    }
    public FunctionType getFunctionType() {
        return functionType;
    }
    public ArrayList<Parameter> getParameterList() {
        return parameterList;
    }
    public IRBlock getReturnBlock() {
        return returnBlock;
    }
    public Register getRetVal() {
        return retVal;
    }

    public IRBlock getEntranceBlock() {
        return entranceBlock;
    }
    public void setEntranceBlock(IRBlock entranceBlock) {
        this.entranceBlock = entranceBlock;
    }
    public IRBlock getExitBlock() {
        return exitBlock;
    }
    public void setExitBlock(IRBlock exitBlock) {
        this.exitBlock = exitBlock;
    }
    public void addBlock(IRBlock block) {
        if (entranceBlock==null) entranceBlock = block;
        else exitBlock.addBlock(block);
        exitBlock = block;
        addSymbol(block);
    }
    public ArrayList<IRBlock> getAllBlocks() {
        ArrayList<IRBlock> ans = new ArrayList<>();
        IRBlock tmp = entranceBlock;
        while (tmp != null) {
            ans.add(tmp);
            tmp = tmp.getNextBlock();
        }
        return ans;
    }
    public void checkTermination(ExceptionHandler e) {
        ArrayList<IRBlock> blocks = getAllBlocks();
        for (var b: blocks) {
            if (b.endWithNonTerminalInst()) {
                e.error("Function \"" + name + "\" has no return statement.");
                throw new SyntaxError();
            }
        }
    }
    public void removeBlock(IRBlock block) {
        ArrayList<IRInst> instList = block.getAllInst();
        for (var inst: instList) {
            inst.severDF();
            if (inst instanceof Call) {
                removeCallSite((Call) inst);
            }
        }
        if (block==entranceBlock) entranceBlock = block.getNextBlock();
        else block.getPrevBlock().setNextBlock(block.getNextBlock());
        if (block==exitBlock) exitBlock = block.getPrevBlock();
        else block.getNextBlock().setPrevBlock(block.getPrevBlock());
        block.severCF();
    }

    public Register getClassPtr() {
        return classPtr;
    }
    public void setClassPtr(Register classPtr) {
        this.classPtr = classPtr;
    }
    public void addSymbol(Object obj) {
        symbolTable.putIR(obj);
    }

    public Set<Call> getCallSites() {
        return callSites;
    }
    public void addCallSite(Call i) {
        callSites.add(i);
    }
    public void removeCallSite(Call i) {
        callSites.remove(i);
    }

    public boolean hasSideEffect() {
        return sideEffect;
    }
    public void setSideEffect(boolean sideEffect) {
        this.sideEffect = sideEffect;
    }

    // post-order & reversed post-order
    public ArrayList<IRBlock> getPO() {
        Set<IRBlock> visited = new HashSet<>();
        ArrayList<IRBlock> order = new ArrayList<>();
        _dfsRecursive(entranceBlock, order, visited);
        return order;
    }
    public ArrayList<IRBlock> getRPO() {
        ArrayList<IRBlock> order = getPO();
        Collections.reverse(order);
        return order;
    }
    private void _dfsRecursive(IRBlock block, ArrayList<IRBlock> order,
                               Set<IRBlock> visited) {
        visited.add(block);
        for (var s: block.getSuccessors()) {
            if (!visited.contains(s)) {
                _dfsRecursive(s, order, visited);
            }
        }
        order.add(block);
    }
    // for dominance analysis
    //     forward control flow analysis
    public void solveDominance() {
        // actually post-order here
        ArrayList<IRBlock> RPO = getPO();
        int cnt = 0;
        // set block counter by post-order
        for (var b: RPO) b.setBlockCnt(cnt++);
        Collections.reverse(RPO);
        RPO.forEach(IRBlock::initDomInfo);
        entranceBlock.setIDom(entranceBlock);
        boolean changed = true;
        while (changed) {
            changed = false;
            for (var b: RPO) {
                if (b==entranceBlock) continue;
                IRBlock newIDom = null;
                for (var p: b.getPredecessors()) {
                    if (p.getIDom()!=null) {
                        newIDom = p;
                        break;
                    }
                }
                for (var p: b.getPredecessors()) {
                    if (p==newIDom) continue;
                    if (p.getIDom()!=null) {
                        newIDom = intersectForward(newIDom, p);
                    }
                }
                if (b.getIDom()!=newIDom) {
                    b.setIDom(newIDom);
                    changed = true;
                }
            }
        }
    }
        // find the LCA of b1 & b2 in dominance tree
    private IRBlock intersectForward(IRBlock b1, IRBlock b2) {
        IRBlock finger1 = b1;
        IRBlock finger2 = b2;
        while (finger1 != finger2) {
            while (finger1.getBlockCnt() < finger2.getBlockCnt()) {
                finger1 = finger1.getIDom();
            }
            while (finger2.getBlockCnt() < finger1.getBlockCnt()) {
                finger2 = finger2.getIDom();
            }
        }
        return finger1;
    }
    public void solveDF() {
        ArrayList<IRBlock> RPO = getRPO();
        for (var b: RPO) {
            if (b.getPredecessors().size() >= 2) {
                for (var p: b.getPredecessors()) {
                    IRBlock runner = p;
                    while (runner != b.getIDom()) {
                        runner.addDF(b);
                        runner = runner.getIDom();
                    }
                }
            }
        }
    }
    //     backward control flow analysis
    public void solvePostDominance() {
        // actually reversed post-order here
        ArrayList<IRBlock> PO = getRPO();
        int cnt = 0;
        // set block counter by RPO
        for (var b: PO) b.setBlockCnt(cnt++);
        Collections.reverse(PO);
        PO.forEach(IRBlock::initPostDomInfo);
        IRBlock retBlock = PO.get(0);
        retBlock.setPostIDom(retBlock);
        boolean changed = true;
        while (changed) {
            changed = false;
            for (var b: PO) {
                if (b==retBlock) continue;
                IRBlock newPostIDom = null;
                for (var p: b.getSuccessors()) {
                    if (p.getPostIDom()!=null) {
                        newPostIDom = p;
                        break;
                    }
                }
                for (var p: b.getSuccessors()) {
                    if (p==newPostIDom) continue;
                    if (p.getPostIDom()!=null) {
                        newPostIDom = intersectBackward(newPostIDom, p);
                    }
                }
                if (b.getPostIDom()!=newPostIDom) {
                    b.setPostIDom(newPostIDom);
                    changed = true;
                }
            }
        }
    }
    private IRBlock intersectBackward(IRBlock b1, IRBlock b2) {
        IRBlock finger1 = b1;
        IRBlock finger2 = b2;
        while (finger1 != finger2) {
            while (finger1.getBlockCnt() < finger2.getBlockCnt()) {
                finger1 = finger1.getPostIDom();
            }
            while (finger2.getBlockCnt() < finger1.getBlockCnt()) {
                finger2 = finger2.getPostIDom();
            }
        }
        return finger1;
    }
    public void solvePDF() {
        ArrayList<IRBlock> PO = getPO();
        for (var b: PO) {
            if (b.getSuccessors().size() >= 2) {
                for (var s: b.getSuccessors()) {
                    IRBlock runner = s;
                    while (runner != b.getPostIDom()) {
                        runner.addRDF(b);
                        runner = runner.getPostIDom();
                    }
                }
            }
        }
    }

    // for mem to reg
    public ArrayList<Alloca> getAllocas() {
        ArrayList<Alloca> ans = new ArrayList<>();
        entranceBlock.getAllInst().stream()
                .filter(i -> i instanceof Alloca)
                .forEach(i -> ans.add((Alloca) i));
        return ans;
    }

    public String declareToString() {
        StringBuilder string = new StringBuilder(/*"dso_local "*/);
        if (functionType.getReturnType()!=null) {
            string.append(functionType.getReturnType().toString());
        }
        else string.append("void");
        if (FuncNameDecorator.extractPureFuncName(name).equals("main"))
            string.append(" @main(");
        else string.append(" @").append(name).append("(");
        int it = parameterList.size();
        for (int i = 0; i < it; ++i) {
            Parameter parameter = parameterList.get(i);
            string.append(parameter.getType().toString()).append(" ");
            string.append(parameter.toString());
            if (i < it-1) string.append(", ");
        }
        string.append(")");
        return string.toString();
    }
    @Override
    public String toString() {
        return name;
    }
    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
