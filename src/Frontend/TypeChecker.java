package Mx.Frontend;

import Mx.AST.*;
import Mx.AST.Expressions.*;
import Mx.AST.Expressions.Literals.*;
import Mx.AST.Initializers.*;
import Mx.AST.Specifiers.*;
import Mx.AST.Statements.*;
import Mx.Types.ClassType;
import Mx.Utils.ExceptionHandler;
import Mx.Utils.TypeTable;

public class TypeChecker implements ASTVisitor {
    private final TypeTable typeTable;
    private final ExceptionHandler exceptionHandler;

    public TypeChecker(ExceptionHandler exceptionHandler) {
        this.typeTable = new TypeTable();
        this.exceptionHandler = exceptionHandler;
    }

    public TypeTable getTypeTable() {
        return typeTable;
    }

    @Override
    public void visit(ASTRoot node) {
        for (var decl: node.getDeclarations()) {
            decl.accept(this);
        }
        typeTable.checkTypes(exceptionHandler);
    }
    /* expressions */
    @Override public void visit(ThisExprNode node) {}
    @Override public void visit(BoolLiteralNode node) {}
    @Override public void visit(IntLiteralNode node) {}
    @Override public void visit(StringLiteralNode node) {}
    @Override public void visit(NullLiteralNode node) {}
    @Override public void visit(IdExprNode node) {}
    @Override public void visit(SubscriptExprNode node) {}
    @Override public void visit(FuncCallExprNode node) {}
    @Override public void visit(MemberExprNode node) {}
    @Override public void visit(PostfixExprNode node) {}
    @Override public void visit(PrefixExprNode node) {}
    @Override public void visit(NewExprNode node) {}
    @Override public void visit(MultiplicativeExprNode node) {}
    @Override public void visit(AdditiveExprNode node) {}
    @Override public void visit(ShiftExprNode node) {}
    @Override public void visit(RelationalExprNode node) {}
    @Override public void visit(EqualityExprNode node) {}
    @Override public void visit(AndExprNode node) {}
    @Override public void visit(ExclusiveOrExprNode node) {}
    @Override public void visit(InclusiveOrExprNode node) {}
    @Override public void visit(LogicalAndExprNode node) {}
    @Override public void visit(LogicalOrExprNode node) {}
    @Override public void visit(ConditionalExprNode node) {}
    @Override public void visit(AssignmentExprNode node) {}
    @Override public void visit(ExprSeqNode node) {}
    /* statements */
    @Override public void visit(ExprStmtNode node) {}
    @Override public void visit(CompoundStmtNode node) {
        for (var stmt: node.getStatements())
            stmt.accept(this);
    }
    @Override public void visit(IfStmtNode node) {
        if (node.hasThenBody())
            node.getThenBody().accept(this);
        if (node.hasElseBody())
            node.getElseBody().accept(this);
    }
    @Override public void visit(WhileStmtNode node) {
        node.getLoopBody().accept(this);
    }
    @Override public void visit(ForStmtNode node) {
        node.getLoopBody().accept(this);
    }
    @Override public void visit(BreakStmtNode node) {}
    @Override public void visit(ContinueStmtNode node) {}
    @Override public void visit(ReturnStmtNode node) {}
    @Override public void visit(DeclarationStmtNode node) {
        for (var varNode: node.getVarNodes())
            varNode.accept(this);
    }
    /* specifiers */
    @Override public void visit(DeclSpecifierSeqNode node) {
        node.getTypeSpecifier().accept(this);
    }
    @Override public void visit(ClassSpecifierNode node) {
        ClassType classType = node.generateClassType();
        typeTable.defType(new DeclSpecifierSeqNode(node.getLocation(), node),
                classType, exceptionHandler);
        for (var varNode: node.getMembers())
            varNode.accept(this);
    }
    @Override public void visit(ArrayTypeSpecifierNode node) {}
    @Override public void visit(BuiltInTypeSpecifierNode node) {}
    @Override public void visit(ClassTypeSpecifierNode node) {}
    /* declaration */
    @Override public void visit(VarNode node) {
        node.getSpecifier().accept(this);
    }
        // VarSeqNode will not be reached by visitor
    @Override public void visit(VarSeqNode node) {
        for (var varNode: node.getVarNodes())
            varNode.accept(this);
    }
    @Override public void visit(ParenedInitializerNode node) {}
    @Override public void visit(InitializerClauseNode node) {}
    @Override public void visit(InitializerListNode node) {}
    @Override public void visit(BracedInitListNode node) {}
    /* function */
    @Override public void visit(ParametersAndQualifiersNode node) {}
    @Override public void visit(FuncNode node) {}
    /* class */
        // MemberSpecificationNode will not be reached by visitor
    @Override public void visit(MemberSpecificationNode node) {}
}
