package Mx.Frontend;

import Mx.AST.*;
import Mx.AST.Expressions.*;
import Mx.AST.Expressions.Literals.*;
import Mx.AST.Initializers.*;
import Mx.AST.Specifiers.*;
import Mx.AST.Statements.*;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.Types.*;
import Mx.Utils.Errors.*;
import Mx.Utils.*;

import java.util.ArrayList;
import java.util.Stack;

public class SemanticChecker implements ASTVisitor {
    private Scope globalScope;
    private final Stack<Scope> scopeStack;
    private final TypeTable typeTable;
    private final ExceptionHandler exceptionHandler;

    public SemanticChecker(TypeTable typeTable, ExceptionHandler exceptionHandler) {
        this.scopeStack = new Stack<>();
        this.typeTable = typeTable;
        this.exceptionHandler = exceptionHandler;
    }

    public Scope getGlobalScope() {
        return globalScope;
    }
    public TypeTable getTypeTable() {
        return typeTable;
    }
    public Scope currentScope() {
        return scopeStack.peek();
    }

    @Override
    public void visit(ASTRoot node) {
        globalScope = new Scope(null, Scope.ScopeType.globalScope,
                null, null);
        scopeStack.push(globalScope);
        globalScope.generateBuiltinFunctions();

        boolean errored = false;

        if (node.getDeclarations()!=null) {
            for (var decl: node.getDeclarations()) {
                if (decl instanceof FuncNode) {
                    try {
                        globalScope.declareFunction(decl,
                                FunctionEntity.FuncEntityType.function,
                                exceptionHandler);
                    }
                    catch (SemanticError err) {
                        errored = true;
                    }
                }
            }
            for (var decl: node.getDeclarations()) {
                try {
                    if (decl instanceof VarNode) {
                        decl.accept(this);
                        if (((VarNode) decl).getName()!=null) {
                            globalScope.declareVariable(decl,
                                    VarEntity.VarEntityType.global,
                                    exceptionHandler);
                        }
                    }
                    else if (decl instanceof FuncNode) {
                        decl.accept(this);
                    }
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }

            FunctionEntity mainFunc = currentScope().getFuncEntity("main");
            if (mainFunc==null) {
                exceptionHandler.error("Main function not found.");
                errored = true;
            }
            else try {
                if (!(typeTable.getType(mainFunc.getReturnType(),exceptionHandler).equals(new IntType()))) {
                    exceptionHandler.error("Return type of main function is not int.",
                            mainFunc.getLocation());
                    errored = true;
                }
                if (mainFunc.getParameters().size()!=0) {
                    exceptionHandler.error("Main function should have no parameter.",
                            mainFunc.getLocation());
                    errored = true;
                }
            }
            catch (SemanticError err) {
                errored = true;
            }
        }

        node.setScope(globalScope);

        scopeStack.pop();

        if (errored) {
            throw new SemanticError();
        }
    }

    /* expressions */

    @Override
    public void visit(ThisExprNode node) {
        node.setScope(currentScope());
        if (!currentScope().inMethodScope()) {
            exceptionHandler.error("A this expression outside of method.",
                    node.getLocation());
            throw new SemanticError();
        }
        node.assureLvalue(true);
        node.setType(currentScope().getClassType());
    }

    @Override
    public void visit(BoolLiteralNode node) {
        node.setScope(currentScope());
        node.assureLvalue(false);
        node.setType(new BoolType());
    }

    @Override
    public void visit(IntLiteralNode node) {
        node.setScope(currentScope());
        node.assureLvalue(false);
        node.setType(new IntType());
    }

    @Override
    public void visit(StringLiteralNode node) {
        node.setScope(currentScope());
        node.assureLvalue(false);
        node.setType(new StringType());
    }

    @Override
    public void visit(NullLiteralNode node) {
        node.setScope(currentScope());
        node.assureLvalue(false);
        node.setType(new NullType());
    }

    @Override
    public void visit(IdExprNode node) {
        node.setScope(currentScope());

        VarEntity entity = currentScope().getVarEntity(node.getIdentifier());
        if (entity==null) {
            exceptionHandler.error("Unresolved variable reference \""
                    + node.getIdentifier() + "\".", node.getLocation());
            throw new SemanticError();
        }
        entity.setReferred();
        node.setEntity(entity);
        node.assureLvalue(true);
        node.setType(typeTable.getType(entity.getSpecifier()));
    }

    @Override
    public void visit(SubscriptExprNode node) {
        node.setScope(currentScope());

        node.getName().accept(this);
        node.getIndex().accept(this);
        ExprNode name = node.getName();
        ExprNode index = node.getIndex();

        Type nameType = name.getType();
        if (!(nameType instanceof ArrayType)) {
            exceptionHandler.error("\""
                            + name.getText() + "\" is not of array type.",
                    name.getLocation());
            throw new SemanticError();
        }
        Type indexType = index.getType();
        if (!(indexType instanceof IntType)) {
            exceptionHandler.error("\""
                    + index.getText() + "\" is not of int type.",
                    index.getLocation());
            throw new SemanticError();
        }
        Type baseType = ((ArrayType) nameType).getBaseType();
        int dimension = ((ArrayType) nameType).getDimension();
        node.assureLvalue(true);
        if (dimension==1)
            node.setType(baseType);
        else
            node.setType(new ArrayType(baseType, dimension-1));
    }

    @Override
    public void visit(FuncCallExprNode node) {
        node.setScope(currentScope());

        ExprNode funcName = node.getName();
        if (funcName instanceof MemberExprNode) {
            funcName.accept(this);
            if (!(funcName.getType() instanceof MethodType)) {
                exceptionHandler.error("\""
                                + funcName.getText() + "\" is not a method.",
                        funcName.getLocation());
                throw new SemanticError();
            }
        }
        else if (funcName instanceof IdExprNode) {
            FunctionEntity entity
                    = currentScope().getFuncEntity(((IdExprNode) funcName).getIdentifier());
            if (entity==null) {
                exceptionHandler.error("Unresolved reference \""
                                + ((IdExprNode)funcName).getIdentifier()
                                + "\".", funcName.getLocation());
                throw new SemanticError();
            }
        }
        else {
            exceptionHandler.error("Function \""
                            +funcName.getText() + "\" is not declared.",
                    funcName.getLocation());
            throw new SemanticError();
        }

        ArrayList<ExprNode> parameters = node.getParameters();
        if (parameters!=null) {
            for (var par: parameters)
                par.accept(this);
        }

        FunctionEntity func;
        if (funcName instanceof MemberExprNode) {
            String methodName = funcName.getType().getName();
            Type objectType = ((MethodType) funcName.getType()).getObjectType();
            if (objectType instanceof ArrayType) {
                func = ((ArrayType) objectType).getMethod(methodName);
            }
            else if (objectType instanceof ClassType) {
                func = ((ClassType) objectType).getMethod(methodName);
            }
            else { // String method
                func = ((StringType) objectType).getMethod(methodName);
            }
        }
        else { // funcName instance of IdExprNode
            func = currentScope().getFuncEntity(((IdExprNode) funcName).getIdentifier());
        }

        ArrayList<VarEntity> funcParameters = func.getParameters();
        if (((parameters==null||parameters.size()==0)
                &&(funcParameters!=null&&funcParameters.size()!=0))
                || ((parameters!=null&&parameters.size()!=0)
                    &&(funcParameters==null||funcParameters.size()==0))) {
            exceptionHandler.error("Inconsistent parameter list.",
                    node.getLocation());
            throw new SemanticError();
        }
        if (funcParameters!=null) {
            if (!(parameters == null || parameters.size() == 0)) {
                if (parameters.size()!=funcParameters.size()) {
                    exceptionHandler.error("Inconsistent parameter num.",
                            node.getLocation());
                    throw new SemanticError();
                }
                for (int i = 0, it = parameters.size(); i < it; ++i) {
                    ExprNode rhs = parameters.get(i);
                    VarEntity lhs = funcParameters.get(i);
                    Type lType = typeTable.getType(lhs.getSpecifier());
                    Type rType = rhs.getType();
                    if (!Type.canAssign(lType, rType)) {
                        exceptionHandler.error("Type match failed: \""
                                + lType.toString() + "\" required while rhs \""
                                + rhs.getText() + "\" provided.", rhs.getLocation());
                        throw new SemanticError();
                    }
                }
            }
        }

        node.assureLvalue(false);
        node.setEntity(func);
        node.setType(typeTable.getType(func.getReturnType()));
    }

    @Override
    public void visit(MemberExprNode node) {
        node.setScope(currentScope());

        node.getObjectName().accept(this);
        ExprNode object = node.getObjectName();
        Type type = object.getType();
        Location loc = object.getLocation();
        String name = node.getMemberName();

        String errMsg = "\"" + object.getText() + "\" has no member or method \"" + name + "\".";
        if (type instanceof ArrayType) {
            if (!((ArrayType) type).hasMethod(name)) {
                exceptionHandler.error(errMsg, loc);
                throw new SemanticError();
            }
            node.assureLvalue(false);
            node.setType(new MethodType(name, type));
        }
        else if (type instanceof ClassType) {
            if (((ClassType) type).hasMember(name)) {
                VarEntity member = ((ClassType) type).getMember(name);
                DeclSpecifierSeqNode specifier = member.getSpecifier();
                node.assureLvalue(true);
                node.setType(typeTable.getType(specifier));
            }
            else if (((ClassType) type).hasMethod(name)) {
                node.assureLvalue(false);
                node.setType(new MethodType(name, type));
            }
            else {
                exceptionHandler.error(errMsg, loc);
                throw new SemanticError();
            }
        }
        else if (type instanceof StringType) {
            if (!((StringType) type).hasMethod(name)) {
                exceptionHandler.error(errMsg, loc);
                throw new SemanticError();
            }
            node.assureLvalue(false);
            node.setType(new MethodType(name, type));
        }
        else {
            exceptionHandler.error(errMsg, loc);
            throw new SemanticError();
        }
    }

    @Override
    public void visit(PostfixExprNode node) {
        node.setScope(currentScope());

        node.getSubExpr().accept(this);
        ExprNode subExpr = node.getSubExpr();
        Type type = subExpr.getType();
        String text = subExpr.getText();
        Location loc = subExpr.getLocation();
        if (!(type instanceof IntType)) {
            exceptionHandler.error("\""
                    + text + "\" is not of int type.", loc);
            throw new SemanticError();
        }
        if (!subExpr.isLvalue()) {
            exceptionHandler.error("\""
                    + text + "\" is not lvalue.", loc);
            throw new SemanticError();
        }

        node.assureLvalue(false);
        node.setType(new IntType());
    }

    @Override
    public void visit(PrefixExprNode node) {
        node.setScope(currentScope());

        node.getSubExpr().accept(this);
        ExprNode subExpr = node.getSubExpr();
        Type type = subExpr.getType();
        String text = subExpr.getText();
        Location loc = subExpr.getLocation();
        String op = node.getOperator();

        switch (op) {
            case "++": case "--": {
                if (!(type instanceof IntType)) {
                    exceptionHandler.error("\""
                            + text + "\" is not of int type.", loc);
                    throw new SemanticError();
                }
                if (!subExpr.isLvalue()) {
                    exceptionHandler.error("\""
                            + text + "\" is not lvalue.", loc);
                    throw new SemanticError();
                }
                node.assureLvalue(true);
                node.setType(new IntType());
                break;
            }
            case "+": case "-": case "~": {
                if (!(type instanceof IntType)) {
                    exceptionHandler.error("\""
                            + text + "\" is not of int type.", loc);
                    throw new SemanticError();
                }
                node.assureLvalue(false);
                node.setType(new IntType());
                break;
            }
            case "!": {
                if (!(type instanceof BoolType)) {
                    exceptionHandler.error("\""
                            + text + "\" is not of bool type.", loc);
                    throw new SemanticError();
                }
                node.assureLvalue(false);
                node.setType(new BoolType());
                break;
            }
            default: {
                exceptionHandler.error("Undefined syntax.");
                throw new SemanticError();
            }
        }
    }

    @Override
    public void visit(NewExprNode node) {
        node.setScope(currentScope());

        if (node.getSpecifier().getTypename().equals("void")) {
            exceptionHandler.error("Cannot create array of void type.",
                    node.getLocation());
            throw new SemanticError();
        }
        node.getSpecifier().getTypeSpecifier().accept(this);
        if (node.getSpecifier().getTypeSpecifier() instanceof ArrayTypeSpecifierNode) {
            exceptionHandler.error("Wrong creator syntax:\n"
                    + node.getText(), node.getLocation());
            throw new SemanticError();
        }

        if (node.getDimension()==0) { // class
            Type type = typeTable.getType(node.getSpecifier());
            if (type.getName().equals("int")
                    || type.getName().equals("bool")
                    || type.getName().equals("string")) {
                exceptionHandler.error("Invalid to create builtin type "
                                + type.toString() + ".", node.getLocation());
                throw new SemanticError();
            }
            node.assureLvalue(true);
            node.setType(type);
        }
        else { // array
            ArrayList<ExprNode> indexes = node.getIndexes();
            indexes.get(0).accept(this);
            ExprNode firstIndex = indexes.get(0);
            if (!(firstIndex.getType() instanceof IntType)) {
                exceptionHandler.error("Expression \""
                                + firstIndex.getText()
                                + "\" is not of int type.",
                        node.getLocation());
                throw new SemanticError();
            }
            boolean hasSlot = false;
            for (int i = 1, it = indexes.size(); i < it; ++i) {
                ConditionalExprNode index
                        = (ConditionalExprNode) indexes.get(i);
                if (index.getConditionExpr()==null) {
                    hasSlot = true;
                }
                else if (hasSlot) {
                    exceptionHandler.error("Wrong creator syntax:\n"
                                    + node.toString(), node.getLocation());
                    throw new SemanticError();
                }
                else {
                    index.accept(this);
                    if (!(index.getType() instanceof IntType)) {
                        exceptionHandler.error("Expression \""
                                        + index.getText()
                                        + "\" is not of int type.",
                                node.getLocation());
                        throw new SemanticError();
                    }
                }
            }

            Type baseType = typeTable.getType(node.getSpecifier());
            node.assureLvalue(true);
            node.setType(new ArrayType(baseType, node.getDimension()));
        }
    }

    @Override
    public void visit(MultiplicativeExprNode node) {
        node.setScope(currentScope());
        ArrayList<ExprNode> factors = node.getSubExpressions();
        if (factors.size() > 1) {
            for (var factor: factors) {
                factor.accept(this);
                if (!(factor.getType() instanceof IntType)) {
                    exceptionHandler.error("\""
                            + factor.getText()
                            + "\" is not of int type.",
                            factor.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new IntType());
        }
        else {
            ExprNode subExpr = factors.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(AdditiveExprNode node) {
        node.setScope(currentScope());
        ArrayList<MultiplicativeExprNode> terms = node.getSubExpressions();
        ArrayList<String> ops = node.getOps();
        if (terms.size() > 1) {
            boolean hasMinus = false;
            for (var op: ops) {
                if (op.equals("-")) {
                    hasMinus = true;
                    break;
                }
            }
            if (hasMinus) {
                for (var term: terms) {
                    term.accept(this);
                    if (!(term.getType() instanceof IntType)) {
                        exceptionHandler.error("\""
                                        + term.getText()
                                        + "\" is not of int type.",
                                term.getLocation());
                        throw new SemanticError();
                    }
                }
                node.assureLvalue(false);
                node.setType(new IntType());
            }
            else {
                terms.get(0).accept(this);
                Type exprType = terms.get(0).getType();
                if (!((exprType instanceof IntType)
                        || (exprType instanceof StringType))) {
                    exceptionHandler.error("\""
                                    + terms.get(0).getText()
                                    + "\" is not of int or string type.",
                            terms.get(0).getLocation());
                    throw new SemanticError();
                }
                for (int i = 1, it = terms.size(); i < it; ++i) {
                    MultiplicativeExprNode term = terms.get(i);
                    term.accept(this);
                    if (!(term.getType().equals(exprType))) {
                        exceptionHandler.error("\""
                                        + term.getText()
                                        + "\" is not of consistent type \""
                                        + exprType.toString() + "\".",
                                term.getLocation());
                        throw new SemanticError();
                    }
                }
                node.assureLvalue(false);
                node.setType(exprType);
            }
        }
        else {
            MultiplicativeExprNode subExpr = terms.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(ShiftExprNode node) {
        node.setScope(currentScope());
        ArrayList<AdditiveExprNode> terms = node.getSubExpressions();
        if (terms.size() > 1) {
            for (var term: terms) {
                term.accept(this);
                if (!(term.getType() instanceof IntType)) {
                    exceptionHandler.error("\""
                                    + term.getText()
                                    + "\" is not of int type.",
                            term.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new IntType());
        }
        else {
            AdditiveExprNode subExpr = terms.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(RelationalExprNode node) {
        node.setScope(currentScope());
        ArrayList<ShiftExprNode> ariths = node.getSubExpressions();
        if (ariths.size() > 2) {
            exceptionHandler.error("Too long relational expression.",
                    node.getLocation());
            throw new SemanticError();
        }
        if (ariths.size() == 2) {
            ariths.get(0).accept(this);
            ariths.get(1).accept(this);
            Type exprType = ariths.get(0).getType();
            if (!((exprType instanceof IntType)
                    || (exprType instanceof StringType))) {
                exceptionHandler.error("\""
                                + ariths.get(0).getText()
                                + "\" is not of int or string type.",
                        ariths.get(0).getLocation());
                throw new SemanticError();
            }
            if (!(ariths.get(1).getType().equals(exprType))) {
                exceptionHandler.error("\""
                                + ariths.get(1).getText()
                                + "\" is not of consistent type \""
                                + exprType.toString() + "\".",
                        ariths.get(1).getLocation());
                throw new SemanticError();
            }
            node.assureLvalue(false);
            node.setType(new BoolType());
        }
        else {
            ShiftExprNode subExpr = ariths.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(EqualityExprNode node) {
        node.setScope(currentScope());
        ArrayList<RelationalExprNode> ariths = node.getSubExpressions();
        if (ariths.size() > 2) {
            for (var arith: ariths) {
                arith.accept(this);
                if (!(arith.getType() instanceof BoolType)) {
                    exceptionHandler.error("\""
                                    + node.getText()
                                    + "\" is not of consistent bool type.",
                            node.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new BoolType());
        }
        else if (ariths.size() == 2) {
            ariths.get(0).accept(this);
            Type exprType = ariths.get(0).getType();
            RelationalExprNode lastExpr = ariths.get(1);
            lastExpr.accept(this);
            if (exprType instanceof ArrayType
                    || exprType instanceof ClassType) {
                 if (!(lastExpr.getType().equals(exprType)
                         || lastExpr.getType() instanceof NullType)) {
                     exceptionHandler.error("\""
                                     + lastExpr.getText()
                                     + "\" is not of consistent type \""
                                     + exprType.toString() + "\".",
                             lastExpr.getLocation());
                     throw new SemanticError();
                 }
            }
            else if (exprType instanceof NullType) {
                if (!(lastExpr.getType() instanceof NullType
                        || lastExpr.getType() instanceof ArrayType
                        || lastExpr.getType() instanceof ClassType)) {
                    exceptionHandler.error("\""
                                    + lastExpr.getText()
                                    + "\" is of type \""
                                    + exprType.toString()
                                    + "\", which is not comparable with null type.",
                            lastExpr.getLocation());
                    throw new SemanticError();
                }
            }
            else {
                if (!exprType.equals(lastExpr.getType())) {
                    exceptionHandler.error("\""
                                    + lastExpr.getText()
                                    + "\" is not of consistent type \""
                                    + exprType.toString() + "\".",
                            lastExpr.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new BoolType());
        }
        else {
            RelationalExprNode subExpr = ariths.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(AndExprNode node) {
        node.setScope(currentScope());
        ArrayList<EqualityExprNode> tests = node.getSubExpressions();
        if (tests.size() > 1) {
            for (var test: tests) {
                test.accept(this);
                if (!(test.getType() instanceof IntType)) {
                    exceptionHandler.error("\""
                                    + test.getText()
                                    + "\" is not of int type.",
                            test.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new IntType());
        }
        else {
            EqualityExprNode subExpr = tests.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(ExclusiveOrExprNode node) {
        node.setScope(currentScope());
        ArrayList<AndExprNode> tests = node.getSubExpressions();
        if (tests.size() > 1) {
            for (var test: tests) {
                test.accept(this);
                if (!(test.getType() instanceof IntType)) {
                    exceptionHandler.error("\""
                                    + test.getText()
                                    + "\" is not of int type.",
                            test.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new IntType());
        }
        else {
            AndExprNode subExpr = tests.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(InclusiveOrExprNode node) {
        node.setScope(currentScope());
        ArrayList<ExclusiveOrExprNode> tests = node.getSubExpressions();
        if (tests.size() > 1) {
            for (var test: tests) {
                test.accept(this);
                if (!(test.getType() instanceof IntType)) {
                    exceptionHandler.error("\""
                                    + test.getText()
                                    + "\" is not of int type.",
                            test.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new IntType());
        }
        else {
            ExclusiveOrExprNode subExpr = tests.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(LogicalAndExprNode node) {
        node.setScope(currentScope());
        ArrayList<InclusiveOrExprNode> tests = node.getSubExpressions();
        if (tests.size() > 1) {
            for (var test: tests) {
                test.accept(this);
                if (!(test.getType() instanceof BoolType)) {
                    exceptionHandler.error("\""
                                    + test.getText()
                                    + "\" is not of bool type.",
                            test.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new BoolType());
        }
        else {
            InclusiveOrExprNode subExpr = tests.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(LogicalOrExprNode node) {
        node.setScope(currentScope());
        ArrayList<LogicalAndExprNode> tests = node.getSubExpressions();
        if (tests.size() > 1) {
            for (var test: tests) {
                test.accept(this);
                if (!(test.getType() instanceof BoolType)) {
                    exceptionHandler.error("\""
                                    + test.getText()
                                    + "\" is not of bool type.",
                            test.getLocation());
                    throw new SemanticError();
                }
            }
            node.assureLvalue(false);
            node.setType(new BoolType());
        }
        else {
            LogicalAndExprNode subExpr = tests.get(0);
            subExpr.accept(this);
            node.assureLvalue(subExpr.isLvalue());
            node.setType(subExpr.getType());
        }
    }

    @Override
    public void visit(ConditionalExprNode node) {
        node.setScope(currentScope());
        LogicalOrExprNode subExpr = node.getConditionExpr();
        subExpr.accept(this);
        node.assureLvalue(subExpr.isLvalue());
        node.setType(subExpr.getType());
    }

    @Override
    public void visit(AssignmentExprNode node) {
        node.setScope(currentScope());
        node.getLhs().accept(this);
        node.getRhs().accept(this);
        ExprNode lExpr = node.getLhs();
        ExprNode rExpr = node.getRhs();
        if (!lExpr.isLvalue()) {
            exceptionHandler.error("\""
                    + lExpr.getText() + "\" is not lvalue.",
                    lExpr.getLocation());
            throw new SemanticError();
        }
        if (!Type.canAssign(lExpr.getType(), rExpr.getType())) {
            exceptionHandler.error("Cannot assign type \""
                            + lExpr.getType().toString()
                            + "\" of lhs as type \""
                            + rExpr.getType().toString()
                            + "\" of rhs.",
                    node.getLocation());
            throw new SemanticError();
        }
        node.assureLvalue(false);
        node.setType(lExpr.getType());
    }

    @Override
    public void visit(ExprSeqNode node) {
        node.setScope(currentScope());
        for (var expr: node.getSubExpressions())
            expr.accept(this);
    }

    /* statements */

    @Override
    public void visit(ExprStmtNode node) {
        node.setScope(currentScope());
        if (node.getExpr()!=null)
            node.getExpr().accept(this);
    }

    @Override
    public void visit(CompoundStmtNode node) {
        Scope scope = new Scope(currentScope(), Scope.ScopeType.blockScope,
                currentScope().getFuncRetType(), currentScope().getClassType());
        scopeStack.push(scope);

        boolean errored = false;
        if (node.getStatements()!=null) {
            for (var stmt: node.getStatements()) {
                try {
                    stmt.accept(this);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }
        node.setScope(scope);

        scopeStack.pop();

        if (errored)
            throw new SemanticError();
    }

    @Override
    public void visit(IfStmtNode node) {
        node.setScope(currentScope());

        boolean errored = false;
        try {
            node.getCondition().accept(this);
            if (!node.getCondition().getType().equals(new BoolType())) {
                exceptionHandler.error("Condition should be of bool type.",
                        node.getCondition().getLocation());
                throw new SemanticError();
            }
        }
        catch (SemanticError err) {
            errored = true;
        }
        if (node.hasThenBody()) {
            try {
                if (node.getThenBody() instanceof CompoundStmtNode)
                    node.getThenBody().accept(this);
                else {
                    Scope scope = new Scope(currentScope(), Scope.ScopeType.blockScope,
                            currentScope().getFuncRetType(), currentScope().getClassType());
                    scopeStack.push(scope);
                    node.getThenBody().accept(this);
                    scopeStack.pop();
                }
            }
            catch (SemanticError err) {
                errored = true;
            }
        }
        if (node.hasElseBody()) {
            try {
                if (node.getElseBody() instanceof CompoundStmtNode)
                    node.getElseBody().accept(this);
                else {
                    Scope scope = new Scope(currentScope(), Scope.ScopeType.blockScope,
                            currentScope().getFuncRetType(), currentScope().getClassType());
                    scopeStack.push(scope);
                    node.getElseBody().accept(this);
                    scopeStack.pop();
                }
            }
            catch (SemanticError err) {
                errored = true;
            }
        }

        if (errored)
            throw new SemanticError();
    }

    @Override
    public void visit(WhileStmtNode node) {
        node.setScope(currentScope());

        boolean errored = false;
        try {
            node.getCondition().accept(this);
            if (!node.getCondition().getType().equals(new BoolType())) {
                exceptionHandler.error("Condition should be of bool type.",
                        node.getCondition().getLocation());
                throw new SemanticError();
            }
        }
        catch (SemanticError err) {
            errored = true;
        }
        try {
            Scope scope = new Scope(currentScope(), Scope.ScopeType.loopScope,
                    currentScope().getFuncRetType(), currentScope().getClassType());
            scopeStack.push(scope);
            node.getLoopBody().accept(this);
            scopeStack.pop();
        }
        catch (SemanticError err) {
            errored = true;
        }

        if (errored)
            throw new SemanticError();
    }

    @Override
    public void visit(ForStmtNode node) {
        node.setScope(currentScope());

        boolean errored = false;
        try {
            node.getForInitStmt().accept(this);
        }
        catch (SemanticError err) {
            errored = true;
        }
        if (node.hasCondition()) {
            try {
                node.getCondition().accept(this);
                if (!node.getCondition().getType().equals(new BoolType())) {
                    exceptionHandler.error("Condition should be of bool type.",
                            node.getCondition().getLocation());
                    throw new SemanticError();
                }
            }
            catch (SemanticError err) {
                errored = true;
            }
        }
        if (node.hasStepExpr()) {
            try {
                node.getStepExpr().accept(this);
            }
            catch (SemanticError err) {
                errored = true;
            }
        }
        try {
            Scope scope = new Scope(currentScope(), Scope.ScopeType.loopScope,
                    currentScope().getFuncRetType(), currentScope().getClassType());
            scopeStack.push(scope);
            node.getLoopBody().accept(this);
            scopeStack.pop();
        }
        catch (SemanticError err) {
            errored = true;
        }

        if (errored)
            throw new SemanticError();
    }

    @Override
    public void visit(BreakStmtNode node) {
        node.setScope(currentScope());
        if (!currentScope().inLoopScope()) {
            exceptionHandler.error("A break statement outside of loop.",
                    node.getLocation());
            throw new SemanticError();
        }
    }

    @Override
    public void visit(ContinueStmtNode node) {
        node.setScope(currentScope());
        if (!currentScope().inLoopScope()) {
            exceptionHandler.error("A continue statement outside of loop.",
                    node.getLocation());
            throw new SemanticError();
        }
    }

    @Override
    public void visit(ReturnStmtNode node) {
        node.setScope(currentScope());
        if (!currentScope().inFuncScope()) {
            exceptionHandler.error("A return statement outside of function.",
                    node.getLocation());
            throw new SemanticError();
        }
        DeclSpecifierSeqNode retSpecifier = currentScope().getFuncRetType();
        if (retSpecifier!=null) {
            Type retType = typeTable.getType(retSpecifier);
            if (node.hasReturnValue()) {
                ExprNode retValue = node.getReturnValue();
                retValue.accept(this);
                if (retType.getName().equals("void")) {
                    exceptionHandler.error("The function should not return value.",
                            node.getLocation());
                    throw new SemanticError();
                }
                Type stmtRetType = retValue.getType();
                if (!Type.canAssign(retType, stmtRetType)) {
                    exceptionHandler.error("The returned expression \""
                            + retValue.getText() + "\" of type \""
                            + retValue.getType().toString() +"\" is not of type \""
                            + retType.toString() + "\".", node.getLocation());
                    throw new SemanticError();
                }
            }
            else {
                if (!retType.getName().equals("void")) {
                    exceptionHandler.error("A return statement without required return value.",
                            node.getLocation());
                    throw new SemanticError();
                }
            }
        }
        else { // constructor
            if (node.hasReturnValue()) {
                exceptionHandler.error("Constructor should not return value.",
                        node.getLocation());
                throw new SemanticError();
            }
        }
    }

    @Override
    public void visit(DeclarationStmtNode node) {
        node.setScope(currentScope());

        boolean errored = false;
        if (node.getVarNodes()!=null) {
            for (var varNode: node.getVarNodes()) {
                try {
                    varNode.accept(this);
                    currentScope().declareVariable(varNode,
                            VarEntity.VarEntityType.local,
                            exceptionHandler);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }

        if (errored)
            throw new SemanticError();
    }

    /* specifiers */

    @Override
    public void visit(DeclSpecifierSeqNode node) {
        node.setScope(currentScope());
        if (!typeTable.hasType(node)) {
            exceptionHandler.error("Undefined type \""
                    + node.getTypename() + "\".",node.getLocation());
            throw new SemanticError();
        }
        node.getTypeSpecifier().accept(this);
    }

    @Override
    public void visit(NonTypeSpecifierNode node) {
        node.setScope(currentScope());
    }

    @Override
    public void visit(ClassSpecifierNode node) {
        Scope scope = new Scope(currentScope(), Scope.ScopeType.classScope,
                null, typeTable.getType(node.getClassName()));
        node.setScope(scope);
        scopeStack.push(scope);

        boolean errored = false;
        ArrayList<VarNode> members = node.getMembers();
        if (members!=null) {
            for (var mem: members) {
                try {
                    mem.accept(this);
                    scope.declareVariable(mem, VarEntity.VarEntityType.member,
                            exceptionHandler);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }
        // first define constructors and methods
        if (node.hasConstructor()) {
            ArrayList<FuncNode> constructors = node.getConstructors();
            for (var constructor: constructors) {
                if (!constructor.getName().equals(node.getClassName())) {
                    exceptionHandler.error("Mis-declared constructor with wrong name",
                            constructor.getLocation());
                    errored = true;
                    continue;
                }
                try {
                    scope.declareConstructor(constructor,
                            exceptionHandler);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }
        ArrayList<FuncNode> methods = node.getMethods();
        if (methods!=null) {
            for (var method: methods) {
                if (method.getName().equals(node.getClassName())) {
                    exceptionHandler.error("Mis-declared constructor with return type",
                            method.getLocation());
                    errored = true;
                    continue;
                }
                try {
                    scope.declareFunction(method, FunctionEntity.FuncEntityType.method,
                            exceptionHandler);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }
        // then resolve them
        if (node.hasConstructor()) {
            ArrayList<FuncNode> constructors = node.getConstructors();
            for (var constructor: constructors) {
                try {
                    constructor.accept(this);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }
        if (methods!=null) {
            for (var method: methods) {
                try {
                    method.accept(this);
                }
                catch (SemanticError err) {
                    errored = true;
                }
            }
        }
        node.setScope(scope);

        scopeStack.pop();

        if (errored)
            throw new SemanticError();
    }

    @Override
    public void visit(ArrayTypeSpecifierNode node) {
        node.setScope(currentScope());
        if (!typeTable.hasType(node.getBaseTypeSpecifier().getTypename())) {
            exceptionHandler.error("Undefined base type \""
                    + node.getTypename() + "\".",node.getLocation());
            throw new SemanticError();
        }
    }

    @Override
    public void visit(BuiltInTypeSpecifierNode node) {
        node.setScope(currentScope());
        if (!typeTable.hasType(node.getTypename())) { // condition never satisfies
            exceptionHandler.error("Undefined builtin type \""
                    + node.getTypename() + "\".",node.getLocation());
            throw new SemanticError();
        }
    }

    @Override
    public void visit(ClassTypeSpecifierNode node) {
        node.setScope(currentScope());
        if (!typeTable.hasType(node.getTypename())) { // condition never satisfies
            exceptionHandler.error("Undefined class type \""
                    + node.getTypename() + "\".",node.getLocation());
            throw new SemanticError();
        }
    }

    /* declaration */

    @Override
    public void visit(VarNode node) {
        node.setScope(currentScope());
        if (node.getSpecifier().getTypename().equals("void")) {
            exceptionHandler.error("Cannot declare variable \""
                    + node.getName() + "\" as void type.", node.getLocation());
            throw new SemanticError();
        }
        node.getSpecifier().accept(this);
        if (node.hasInitializer()) {
            node.getInitializer().accept(this);
            Type lType = typeTable.getType(node.getSpecifier());
            Type rType = node.getInitializer().getType();
            if (!Type.canAssign(lType, rType)) {
                exceptionHandler.error("Cannot assign lhs type \""
                        + lType.toString() + "\" as rhs type \""
                        + rType.toString() + "\".", node.getLocation());
                throw new SemanticError();
            }
        }
    }

    @Override
    public void visit(VarSeqNode node) {
        node.setScope(currentScope());
        if (node.getVarNodes()!=null) {
            for (var varNode: node.getVarNodes())
                varNode.accept(this);
        }
    }

    @Override
    public void visit(ParenedInitializerNode node) {
        node.setScope(currentScope());
        node.getInitList().accept(this);
    }

    @Override
    public void visit(InitializerClauseNode node) {
        if (node.isAtomic()) {
            node.getAssignmentExpr().accept(this);
            node.setType(node.getAssignmentExpr().getType());
        }
        else {
            node.getBraced().accept(this);
        }
        node.assureLvalue(false);
    }

    @Override
    public void visit(InitializerListNode node) {
        node.setScope(currentScope());
        for (var init: node.getInitClauses())
            init.accept(this);
    }

    @Override
    public void visit(BracedInitListNode node) {
        node.setScope(currentScope());
        node.getInitList().accept(this);
    }

    /* function */

        // ParametersAndQualifiersNode will not be reached by visitor
    @Override
    public void visit(ParametersAndQualifiersNode node) {
        node.setScope(currentScope());
    }

    @Override
    public void visit(FuncNode node) {
        Scope scope = new Scope(currentScope(), Scope.ScopeType.funcScope,
                node.getSpecifier(), currentScope().getClassType());
        scopeStack.push(scope);

        if (node.getSpecifier()!=null) { // function, rather than constructor
            try {
                node.getSpecifier().accept(this);
            }
            catch (SemanticError err) {
                scopeStack.pop();
                throw new SemanticError();
            }
        }

        boolean errored = false;

        FunctionEntity func = currentScope().getFuncEntity(node.getName());
        if (func!=null) {
            ArrayList<VarEntity> parameterEntities = func.getParameters();
            ArrayList<VarNode> parameters = node.getParameters();
            if (!(parameterEntities==null&&parameters==null)) {
                if ((parameterEntities==null||parameters==null)
                        || (parameterEntities.size()!=parameters.size())) {
                    errored = true;
                }
                else {
                    for (int i = 0, it = parameters.size(); i < it; ++i) {
                        VarNode par = parameters.get(i);
                        try {
                            par.accept(this);
                            scope.declareVariable(parameterEntities.get(i),
                                    par.getLocation(), exceptionHandler);
                        }
                        catch (SemanticError err) {
                            errored = true;
                        }
                    }
                    try {
                        node.getFuncBody().accept(this);
                    }
                    catch (SemanticError err) {
                        errored = true;
                    }
                }
            }
        }
        else {
            if (scope.getClassType()!=null
                    && scope.getClassType().getName().equals(node.getName())) {
                ArrayList<VarNode> parameters = node.getParameters();
                func = scope.getConstructorEntity(parameters);
                if (func!=null) {
                    ArrayList<VarEntity> parameterEntities = func.getParameters();
                    if (parameterEntities!=null) {
                        for (int i = 0, it = parameters.size(); i < it; ++i) {
                            VarNode par = parameters.get(i);
                            try {
                                par.accept(this);
                                scope.declareVariable(parameterEntities.get(i),
                                        par.getLocation(), exceptionHandler);
                            }
                            catch (SemanticError err) {
                                errored = true;
                            }
                        }
                    }
                    try {
                        node.getFuncBody().accept(this);
                    }
                    catch (SemanticError err) {
                        errored = true;
                    }
                }
                else errored = true;
            }
            else errored = true;
        }
        node.setScope(scope);

        scopeStack.pop();

        if (errored)
            throw new SemanticError();
    }

    /* class */

        // MemberSpecificationNode will not be reached by visitor
    @Override
    public void visit(MemberSpecificationNode node) {
        node.setScope(currentScope());
    }
}
