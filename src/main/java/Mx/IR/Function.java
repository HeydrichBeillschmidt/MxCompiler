package Mx.IR;

import Mx.IR.Instruction.Alloca;
import Mx.IR.Instruction.Load;
import Mx.IR.Instruction.Ret;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.FunctionType;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;
import Mx.IR.TypeSystem.VoidType;
import Mx.Utils.Errors.SyntaxError;
import Mx.Utils.ExceptionHandler;
import Mx.Utils.FuncSymbolTable;

import java.util.ArrayList;

public class Function {
    private final String name;
    private final FunctionType functionType;
    private final ArrayList<Parameter> parameterList;
    private IRBlock entranceBlock;
    private IRBlock exitBlock;
    private final IRBlock returnBlock;
    private Register retVal;
    private Register classPtr;
    private final FuncSymbolTable symbolTable;
    private boolean sideEffect;

    public Function(IRType retType, String name, ArrayList<Parameter> parameterList) {
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
        this.sideEffect = true;
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
                    "retval");
            entranceBlock.addInst(new Alloca(entranceBlock, retVal, retType));
            Register returnValue = new Register(retType, "returnValue");
            returnBlock.addInst(new Load(returnBlock, returnValue, retType, retVal));
            returnBlock.addInst(new Ret(returnBlock, retType, returnValue));
            symbolTable.putIR(retVal);
            symbolTable.putIR(returnValue);
        }
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

    public Register getClassPtr() {
        return classPtr;
    }
    public void setClassPtr(Register classPtr) {
        this.classPtr = classPtr;
    }
    public void addSymbol(Object obj) {
        symbolTable.putIR(obj);
    }
    public boolean hasSideEffect() {
        return sideEffect;
    }
    public void setSideEffect(boolean sideEffect) {
        this.sideEffect = sideEffect;
    }

    public String declareToString() {
        StringBuilder string = new StringBuilder("dso_local ");
        if (functionType.getReturnType()!=null) {
            string.append(functionType.getReturnType().toString());
        }
        string.append(" @").append(name).append("(");
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
