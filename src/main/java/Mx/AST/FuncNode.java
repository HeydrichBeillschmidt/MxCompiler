package Mx.AST;

import Mx.ASM.Operand.Reg;
import Mx.AST.Specifiers.*;
import Mx.AST.Statements.CompoundStmtNode;
import Mx.Entities.*;
import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Alloca;
import Mx.IR.Instruction.BitCast;
import Mx.IR.Instruction.Call;
import Mx.IR.Instruction.Store;
import Mx.IR.Operand.ConstInt;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;
import Mx.Types.ClassType;
import Mx.Utils.FuncNameDecorator;
import Mx.Utils.Location;
import Mx.Utils.TypeTable;

import java.util.ArrayList;

public class FuncNode extends DeclarationNode {
    private final DeclSpecifierSeqNode specifier;
    private final String pureName;
    private final ArrayList<VarNode> parameters;
    private final CompoundStmtNode funcBody;

    private boolean decorated;
    private String decoratedName;

    public FuncNode(Location loc,
                    DeclSpecifierSeqNode specifier,
                    String name,
                    ArrayList<VarNode> parameters,
                    CompoundStmtNode funcBody) {
        super(loc);
        this.specifier = specifier;
        this.pureName = name;
        this.parameters = parameters;
        this.funcBody = funcBody;
        this.decorated = false;
    }

    public DeclSpecifierSeqNode getSpecifier() {
        return specifier;
    }
    public String getPureName() {
        return pureName;
    }
    public ArrayList<VarNode> getParameters() {
        return parameters;
    }
    public CompoundStmtNode getFuncBody() {
        return funcBody;
    }
    public String getDecoratedName() {
        return decoratedName;
    }
    public void setDecoratedName(String dName) {
        if (!decorated) {
            decorated = true;
            decoratedName = dName;
        }
    }
    public FunctionEntity generateEntity(FunctionEntity.FuncEntityType entityType,
                                         String className) {
        ArrayList<VarEntity> generatedParameters = new ArrayList<>();
        for (var parameter: parameters)
            generatedParameters.add(parameter.generateEntity(VarEntity.VarEntityType.parameter));
        setDecoratedName(FuncNameDecorator.funcNameDecorationCast(
                specifier, pureName, parameters, entityType, className ) );
        return new FunctionEntity(decoratedName, getLocation(),
                specifier, generatedParameters, funcBody, entityType);
    }
    public void addModularFunction(IRModule module, TypeTable astTypeTable) {
        // generate IR function
        FunctionEntity funcEntity = getScope().getFuncEntity(decoratedName);
        IRType retType = null;
        if (funcEntity.getReturnType()!=null) {
            retType = module.getIRType(astTypeTable.getType(
                    funcEntity.getReturnType() ) );
        }
        ArrayList<Parameter> parameterList = new ArrayList<>();
        if (getScope().inClassScope()) {
            ClassType cType = (ClassType) getScope().getClassType();
            parameterList.add(new Parameter(module.getIRType(cType), "this"));
        }
        ArrayList<VarEntity> entityParameterList = funcEntity.getParameters();
        for (var ep: entityParameterList) {
            parameterList.add(new Parameter(module.getIRType(astTypeTable.getType(
                    ep.getSpecifier() ) ), ep.getName()));
        }
        Function func = new Function(module, retType, decoratedName, parameterList);
        // parameter allocation
        IRBlock curBlock = func.getEntranceBlock();
        int offset = 0;
        if (getScope().inClassScope()) {
            offset = 1;
            Parameter parThis = parameterList.get(0);
            Register ptrThis = new Register(new PointerType(parThis.getType()),
                    "this.addr");
            func.setClassPtr(ptrThis);
            func.addSymbol(ptrThis);
            //eliminate alloca
            Register dst = new Register(IRModule.stringT, "malloc");
            func.addSymbol(dst);
            ArrayList<Operand> parameters = new ArrayList<>();
            parameters.add(new ConstInt(parThis.getType().size(), 4));
            Function mallocFunc = module.getExternalFunction("malloc");
            curBlock.addInst(new Call(curBlock, dst, mallocFunc, parameters));
            curBlock.addInst(new BitCast(curBlock, ptrThis, dst, new PointerType(parThis.getType())));
            //curBlock.addInst(new Alloca(curBlock, ptrThis, parThis.getType()));
            curBlock.addInst(new Store(curBlock, parThis, ptrThis));
        }
        for (int i = 0, it = entityParameterList.size(); i < it; ++i) {
            Parameter parTmp = parameterList.get(i + offset);
            Register ptrTmp = new Register(new PointerType(parTmp.getType()),
                    parTmp.getName() + ".addr");
            func.addSymbol(ptrTmp);
            //eliminate alloca
            Register dst = new Register(IRModule.stringT, "malloc");
            func.addSymbol(dst);
            ArrayList<Operand> parameters = new ArrayList<>();
            parameters.add(new ConstInt(parTmp.getType().size(), 4));
            Function mallocFunc = module.getExternalFunction("malloc");
            curBlock.addInst(new Call(curBlock, dst, mallocFunc, parameters));
            curBlock.addInst(new BitCast(curBlock, ptrTmp, dst, new PointerType(parTmp.getType())));
            //curBlock.addInst(new Alloca(curBlock, ptrTmp, parTmp.getType()));
            curBlock.addInst(new Store(curBlock, parTmp, ptrTmp));
            entityParameterList.get(i).setAllocatedAddr(ptrTmp);
        }

        module.addFunction(func);
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<FunctionNode>\n");
        if (specifier!=null)
            string.append("return type specifier:\n").append(specifier.toString());
        string.append("function name:\n").append(pureName);
        string.append("parameters:\n");
        for (var parameter: parameters)
            string.append(parameter.toString());
        string.append("body of function:\n").append(funcBody.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
