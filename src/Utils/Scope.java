package Mx.Utils;

import Mx.AST.DeclarationNode;
import Mx.AST.FuncNode;
import Mx.AST.Specifiers.BuiltInTypeSpecifierNode;
import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.AST.VarNode;
import Mx.Entities.*;
import Mx.Types.Type;
import Mx.Utils.Errors.SemanticError;

import java.util.*;

public class Scope {
    public enum ScopeType {
        globalScope, classScope, funcScope, loopScope, blockScope
    }
    private final ScopeType scopeType;

    private final Scope parentScope;
    private final ArrayList<Scope> childrenScope;

    private final Map<String, VarEntity> varEntities;
    private final Map<String, FunctionEntity> funcEntities;
    private final Set<FunctionEntity> constructorEntities;

    private final DeclSpecifierSeqNode funcRetType;
    private final Type classType;

    public Scope(Scope parentScope, ScopeType scopeType,
                 DeclSpecifierSeqNode funcRetType, Type classType) {
        this.scopeType = scopeType;
        this.parentScope = parentScope;
        if (this.parentScope != null) {
            this.parentScope.childrenScope.add(this);
        }
        this.childrenScope = new ArrayList<>();
        this.varEntities = new HashMap<>();
        this.funcEntities = new HashMap<>();
        this.constructorEntities = new HashSet<>();
        this.funcRetType = funcRetType;
        this.classType = classType;
    }

    public Scope getParentScope() {
        return parentScope;
    }
    public ArrayList<Scope> getChildrenScope() {
        return childrenScope;
    }
    public Map<String, VarEntity> getVarEntities() {
        return varEntities;
    }
    public Map<String, FunctionEntity> getFuncEntities() {
        return funcEntities;
    }
    public Set<FunctionEntity> getConstructorEntities() {
        return constructorEntities;
    }
    public ScopeType getScopeType() {
        return scopeType;
    }
    public DeclSpecifierSeqNode getFuncRetType() {
        return funcRetType;
    }
    public Type getClassType() {
        return classType;
    }

    public void generateBuiltinFunctions() {
        Location defaultLoc = new Location(0,0);
        FunctionEntity builtinFunc;
        ArrayList<VarEntity> builtinFuncParameters;

        // void print(string str);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("str", "string"));
        builtinFunc = new FunctionEntity("print", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("print", builtinFunc);

        // void println(string str);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("str", "string"));
        builtinFunc = new FunctionEntity("println", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("println", builtinFunc);

        // void printInt(int n);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("n", "int"));
        builtinFunc = new FunctionEntity("printInt", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("printInt", builtinFunc);

        // void printlnInt(int n);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("n", "int"));
        builtinFunc = new FunctionEntity("printlnInt", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("printlnInt", builtinFunc);

        // string getString();
        builtinFuncParameters = new ArrayList<>();
        builtinFunc = new FunctionEntity("getString", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "string")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("getString", builtinFunc);

        // int getInt();
        builtinFuncParameters = new ArrayList<>();
        builtinFunc = new FunctionEntity("getInt", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "int")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("getInt", builtinFunc);

        // string toString(int i);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("i", "int"));
        builtinFunc = new FunctionEntity("toString", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "string")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        funcEntities.put("toString", builtinFunc);
    }
    public void declareVariable(DeclarationNode decl,
                                VarEntity.VarEntityType varType,
                                ExceptionHandler exceptionHandler) {
        VarEntity entity = null;
        if (decl instanceof VarNode) {
            entity = ((VarNode) decl).generateEntity(varType);
        }
        assert entity != null;
        if (varEntities.containsKey(entity.getName())) {
            exceptionHandler.error("Duplicate declaration of variable \""
                    + entity.getName() + "\".", decl.getLocation());
            throw new SemanticError();
        }
        else {
            varEntities.put(entity.getName(), entity);
        }
    }
    public void declareVariable(VarEntity entity, Location loc,
                                ExceptionHandler exceptionHandler) {
        assert entity != null;
        if (varEntities.containsKey(entity.getName())) {
            exceptionHandler.error("Duplicate declaration of variable \""
                    + entity.getName() + "\".", loc);
            throw new SemanticError();
        }
        else {
            varEntities.put(entity.getName(), entity);
        }
    }
    public void declareFunction(DeclarationNode decl,
                                FunctionEntity.FuncEntityType funcType,
                                ExceptionHandler exceptionHandler) {
        FunctionEntity entity = null;
        if (decl instanceof FuncNode) {
            entity = ((FuncNode) decl).generateEntity(funcType);
        }
        assert entity != null;
        if (funcEntities.containsKey(entity.getName())) {
            exceptionHandler.error("Duplicate declaration of function \""
                    + entity.getName() + "\".", decl.getLocation());
            throw new SemanticError();
        }
        else if (funcType==FunctionEntity.FuncEntityType.constructor) {
            exceptionHandler.error("Mistake declaration of constructor as function",
                    decl.getLocation());
            throw new SemanticError();
        }
        else {
            funcEntities.put(entity.getName(), entity);
        }
    }
    public void declareFunction(FunctionEntity entity, Location loc,
                                ExceptionHandler exceptionHandler) {
        assert entity != null;
        if (funcEntities.containsKey(entity.getName())) {
            exceptionHandler.error("Duplicate declaration of function \""
                    + entity.getName() + "\".", loc);
            throw new SemanticError();
        }
        else if (entity.getFuncEntityType()==FunctionEntity.FuncEntityType.constructor) {
            exceptionHandler.error("Mistake declaration of constructor as function", loc);
            throw new SemanticError();
        }
        else {
            funcEntities.put(entity.getName(), entity);
        }
    }
    public void declareConstructor(DeclarationNode decl,
                                   ExceptionHandler exceptionHandler) {
        FunctionEntity entity = null;
        if (decl instanceof FuncNode) {
            entity = ((FuncNode) decl).generateEntity(FunctionEntity.FuncEntityType.constructor);
        }
        assert entity != null;
        if (constructorEntities.contains(entity)) {
            exceptionHandler.error("Duplicate declaration of constructor.", decl.getLocation());
            throw new SemanticError();
        }
        else {
            constructorEntities.add(entity);
        }
    }
    public void declareConstructor(FunctionEntity entity, Location loc,
                                   ExceptionHandler exceptionHandler) {
        assert entity != null;
        if (entity.getFuncEntityType()!=FunctionEntity.FuncEntityType.constructor) {
            exceptionHandler.error("Mistake declaration of function as constructor", loc);
            throw new SemanticError();
        }
        else if (constructorEntities.contains(entity)) {
            exceptionHandler.error("Duplicate declaration of constructor.", loc);
            throw new SemanticError();
        }
        else {
            constructorEntities.add(entity);
        }
    }
    public VarEntity getVarEntity(String name) {
        if (varEntities.containsKey(name)) {
            return varEntities.get(name);
        }
        else if (parentScope!=null) {
            return parentScope.getVarEntity(name);
        }
        else return null;
    }
    public FunctionEntity getFuncEntity(String name) {
        if (funcEntities.containsKey(name)) {
            return funcEntities.get(name);
        }
        else if (parentScope!=null) {
            return parentScope.getFuncEntity(name);
        }
        else return null;
    }
    public FunctionEntity getConstructorEntity(ArrayList<VarNode> parameters) {
        if (constructorEntities!=null&&constructorEntities.size()!=0) {
            for (var ce: constructorEntities) {
                if ((parameters==null||parameters.size()==0)
                        && (ce.getParameters()==null||ce.getParameters().size()==0)) {
                    return ce;
                }
                else if ((parameters!=null&&parameters.size()!=0)
                        && (ce.getParameters()!=null&&ce.getParameters().size()!=0)) {
                    if (parameters.size()==ce.getParameters().size()) {
                        boolean fit = true;
                        for (int i = 0, it = parameters.size(); i < it; ++i) {
                            VarNode par = parameters.get(i);
                            VarEntity parEntity = ce.getParameters().get(i);
                            if (!(par.getSpecifier().equals(parEntity.getSpecifier())) ||
                                    !(par.getName().equals(parEntity.getName()))) {
                                fit = false;
                                break;
                            }
                        }
                        if (fit) return ce;
                    }
                }
            }
        }
        if (parentScope!=null) {
            return parentScope.getConstructorEntity(parameters);
        }
        return null;
    }
    public boolean inGlobalScope() {
        return parentScope==null;
    }
    public boolean inClassScope() {
        if (scopeType==ScopeType.classScope) {
            return true;
        }
        else if (scopeType==ScopeType.globalScope) {
            return false;
        }
        else return parentScope.inClassScope();
    }
    public boolean inFuncScope() {
        if (scopeType==ScopeType.funcScope) {
            return true;
        }
        else if (scopeType==ScopeType.globalScope) {
            return false;
        }
        else return parentScope.inFuncScope();
    }
    public boolean inLoopScope() {
        if (scopeType==ScopeType.loopScope) {
            return true;
        }
        else if (scopeType==ScopeType.globalScope) {
            return false;
        }
        else return parentScope.inLoopScope();
    }
    public boolean inMethodScope() {
        return inClassScope() && inFuncScope();
    }
}
