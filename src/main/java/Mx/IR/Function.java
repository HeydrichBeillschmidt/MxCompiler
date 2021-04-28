package Mx.IR;

import Mx.IR.Instruction.*;
import Mx.IR.Operand.Operand;
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
    private IRBlock returnBlock;
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
    public void setReturnBlock(IRBlock returnBlock) {
        this.returnBlock = returnBlock;
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
    public void addPrevBlock(IRBlock target, IRBlock blockToAdd) {
        if (target==entranceBlock) {
            entranceBlock = blockToAdd;
            blockToAdd.addBlock(target);
        }
        else target.getPrevBlock().addBlock(blockToAdd);
        addSymbol(blockToAdd);
    }
    public void addNextBlock(IRBlock target, IRBlock blockToAdd) {
        target.addBlock(blockToAdd);
        if (target==exitBlock) exitBlock = blockToAdd;
        addSymbol(blockToAdd);
    }
    public void insertBlocks(IRBlock target, ArrayList<IRBlock> blocksToAdd) {
        IRBlock head = blocksToAdd.get(0), tail = blocksToAdd.get(blocksToAdd.size()-1);
        if (target==exitBlock) exitBlock = tail;
        tail.setNextBlock(target.getNextBlock());
        if (target.hasNextBlock()) target.getNextBlock().setPrevBlock(tail);
        head.setPrevBlock(target);
        target.setNextBlock(head);
        blocksToAdd.forEach(this::addSymbol);
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
    public ArrayList<IRBlock> inlineToFunc(Function caller, ArrayList<Operand> aps) {
        ArrayList<IRBlock> ans = new ArrayList<>();
        Map<IRBlock, IRBlock> blockMap = new HashMap<>();
        Map<Operand, Operand> F2A = new HashMap<>(); // formal to actual
        for (int i = 0, it = parameterList.size(); i < it; ++i) {
            F2A.put(parameterList.get(i), aps.get(i));
        }
        ArrayList<IRBlock> RPO = getRPO();
        boolean atFirst = true;
        for (var b: RPO) {
            IRBlock bCpy = b.getCopy();
            if (atFirst) atFirst = false;
            else {
                IRBlock bLast = ans.get(ans.size()-1);
                bLast.setNextBlock(bCpy);
                bCpy.setPrevBlock(bLast);
            }
            ans.add(bCpy);
            blockMap.put(b, bCpy);

            ArrayList<IRInst> iList = b.getAllInst(), iListCpy = bCpy.getAllInst();
            for (int i = 0, it = iList.size(); i < it; ++i) {
                if (iList.get(i).hasDst()) {
                    F2A.put(iList.get(i).getDst(), iListCpy.get(i).getDst());
                    caller.addOriginalSymbol(iListCpy.get(i).getDst());
                }
                if (iList.get(i) instanceof Call) {
                    caller.addCallSite((Call) iListCpy.get(i));
                }
            }
        }
        for (var b: ans) {
            ArrayList<IRBlock> pre = new ArrayList<>(), suc = new ArrayList<>();
            b.getPredecessors().forEach(p -> pre.add(blockMap.get(p)));
            b.getSuccessors().forEach(s -> suc.add(blockMap.get(s)));
            b.getPredecessors().clear();
            b.getPredecessors().addAll(pre);
            b.getSuccessors().clear();
            b.getSuccessors().addAll(suc);
            b.getAllInst().forEach(i -> i.refresh(F2A, blockMap));
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
    public void addOriginalSymbol(Register r) {
        symbolTable.putIR(r.getOriginalName(), r);
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
        Stack<IRBlock> stNode = new Stack<>();
        Stack<Boolean> stStat = new Stack<>();
        stNode.push(entranceBlock);
        stStat.push(false);
        while (!stNode.isEmpty()) {
            IRBlock block = stNode.pop();
            boolean postVisit = stStat.pop();
            if (postVisit) order.add(block);
            else if (!visited.contains(block)) {
                visited.add(block);
                stNode.push(block);
                stStat.push(true);
                for (var s: block.getSuccessors()) {
                    stNode.push(s);
                    stStat.push(false);
                }
            }
        }
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
    // post-order & reversed post-order on reversed CFG
    public ArrayList<IRBlock> getBackwardPO() {
        Set<IRBlock> visited = new HashSet<>();
        ArrayList<IRBlock> order = new ArrayList<>();
        Stack<IRBlock> stNode = new Stack<>();
        Stack<Boolean> stStat = new Stack<>();
        stNode.push(returnBlock);
        stStat.push(false);
        while (!stNode.isEmpty()) {
            IRBlock block = stNode.pop();
            boolean postVisit = stStat.pop();
            if (postVisit) order.add(block);
            else if (!visited.contains(block)) {
                visited.add(block);
                stNode.push(block);
                stStat.push(true);
                for (var s: block.getPredecessors()) {
                    stNode.push(s);
                    stStat.push(false);
                }
            }
        }
        return order;
    }
    public ArrayList<IRBlock> getBackwardRPO() {
        ArrayList<IRBlock> order = getBackwardPO();
        Collections.reverse(order);
        return order;
    }
    private void _reverseDFSRecursive(IRBlock block, ArrayList<IRBlock> order,
                                      Set<IRBlock> visited) {
        visited.add(block);
        for (var p: block.getPredecessors()) {
            if (!visited.contains(p)) {
                _reverseDFSRecursive(p, order, visited);
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
        // actually backward post-order here
        ArrayList<IRBlock> BwdRPO = getBackwardPO();
        int cnt = 0;
        // set block counter by backward PO
        for (var b: BwdRPO) b.setBlockCnt(cnt++);
        Collections.reverse(BwdRPO);
        BwdRPO.forEach(IRBlock::initPostDomInfo);
        returnBlock.setPostIDom(returnBlock);
        boolean changed = true;
        while (changed) {
            changed = false;
            for (var b: BwdRPO) {
                if (b==returnBlock) continue;
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
    public void solveRDF() {
        ArrayList<IRBlock> BwdRPO = getBackwardRPO();
        for (var b: BwdRPO) {
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
