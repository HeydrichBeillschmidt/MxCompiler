package Mx.Utils;

import Mx.AST.DeclarationNode;
import Mx.AST.Expressions.ExprNode;
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
    private final Map<String, ArrayList<FunctionEntity>> funcEntities;

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
    public Map<String, ArrayList<FunctionEntity>> getFuncEntities() {
        return funcEntities;
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
        builtinFunc = new FunctionEntity("_print$$YGXPAD$Z", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("print", builtinFunc);

        // void println(string str);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("str", "string"));
        builtinFunc = new FunctionEntity("_println$$YGXPAD$Z", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("println", builtinFunc);

        // void printInt(int n);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("n", "int"));
        builtinFunc = new FunctionEntity("_printInt$$YGXH$Z", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("printInt", builtinFunc);

        // void printlnInt(int n);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("n", "int"));
        builtinFunc = new FunctionEntity("_printlnInt$$YGXH$Z", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "void")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("printlnInt", builtinFunc);

        // string getString();
        builtinFuncParameters = new ArrayList<>();
        builtinFunc = new FunctionEntity("_getString$$YGPADXZ", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "string")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("getString", builtinFunc);

        // int getInt();
        builtinFuncParameters = new ArrayList<>();
        builtinFunc = new FunctionEntity("_getInt$$YGHXZ", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "int")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("getInt", builtinFunc);

        // string toString(int i);
        builtinFuncParameters = new ArrayList<>();
        builtinFuncParameters.add(VarEntity.builtinMethodParameter("i", "int"));
        builtinFunc = new FunctionEntity("_toString$$YGPADH$Z", defaultLoc,
                new DeclSpecifierSeqNode(defaultLoc, new BuiltInTypeSpecifierNode(defaultLoc, "string")),
                builtinFuncParameters, null, FunctionEntity.FuncEntityType.function);
        putFunc("toString", builtinFunc);
    }
    private void putFunc(String pureName, FunctionEntity func) {
        if (funcEntities.containsKey(pureName)) {
            if (pureName.equals("main")) throw new SemanticError();
            for (var p: funcEntities.get(pureName)) {
                if (p.getName().equals(func.getName())) {
                    throw new SemanticError();
                }
            }
            funcEntities.get(pureName).add(func);
        }
        else {
            ArrayList<FunctionEntity> tmp = new ArrayList<>();
            tmp.add(func);
            funcEntities.put(pureName, tmp);
        }
    }
    public boolean containsFunc(String pureName) {
        if (funcEntities.containsKey(pureName)) return true;
        else if (parentScope!=null) {
            return parentScope.containsFunc(pureName);
        }
        return false;
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
                                String className,
                                ExceptionHandler exceptionHandler) {
        FunctionEntity entity = null;
        if (decl instanceof FuncNode) {
            entity = ((FuncNode) decl).generateEntity(funcType, className);
        }
        assert entity != null;
        String pureName = ((FuncNode)decl).getPureName();
        try {
            putFunc(pureName, entity);
        }
        catch (SemanticError err) {
            exceptionHandler.error("Duplicate declaration of function \""
                    + entity.getName() + "\".", decl.getLocation());
            throw new SemanticError();
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
    public FunctionEntity getFuncEntity(String decoratedName) {
        String pureName = FuncNameDecorator.extractPureFuncName(decoratedName);
        if (funcEntities.containsKey(pureName)) {
            for (var p: funcEntities.get(pureName)) {
                if (p.getName().equals(decoratedName))
                    return p;
            }
        }
        else if (parentScope!=null) {
            return parentScope.getFuncEntity(decoratedName);
        }
        return null;
    }
    public FunctionEntity getFuncEntityAtCall(String pureName, ArrayList<ExprNode> parameters) {
        if (funcEntities.containsKey(pureName)) {
            String decoratedEnd = FuncNameDecorator.funcCallDecoratedEnd(parameters);
            for (var p: funcEntities.get(pureName)) {
                if (FuncNameDecorator.funcCallMatched(p.getName(), decoratedEnd))
                    return p;
            }
        }
        else if (parentScope!=null) {
            return parentScope.getFuncEntityAtCall(pureName, parameters);
        }
        return null;
    }
    public ArrayList<FunctionEntity> getOverloadedFuncEntities(String pureName) {
        if (funcEntities.containsKey(pureName))
            return funcEntities.get(pureName);
        else if (parentScope!=null)
            return parentScope.getOverloadedFuncEntities(pureName);
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
