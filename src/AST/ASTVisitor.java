package Mx.AST;

import Mx.AST.Expressions.*;
import Mx.AST.Expressions.Literals.*;
import Mx.AST.Initializers.*;
import Mx.AST.Specifiers.*;
import Mx.AST.Statements.*;

public interface ASTVisitor {
    void visit(ASTRoot node);
    /* expressions */
    void visit(ThisExprNode node);
    void visit(BoolLiteralNode node);
    void visit(IntLiteralNode node);
    void visit(StringLiteralNode node);
    void visit(NullLiteralNode node);
    void visit(IdExprNode node);
    void visit(SubscriptExprNode node);
    void visit(FuncCallExprNode node);
    void visit(MemberExprNode node);
    void visit(PostfixExprNode node);
    void visit(PrefixExprNode node);
    void visit(NewExprNode node);
    void visit(MultiplicativeExprNode node);
    void visit(AdditiveExprNode node);
    void visit(ShiftExprNode node);
    void visit(RelationalExprNode node);
    void visit(EqualityExprNode node);
    void visit(AndExprNode node);
    void visit(ExclusiveOrExprNode node);
    void visit(InclusiveOrExprNode node);
    void visit(LogicalAndExprNode node);
    void visit(LogicalOrExprNode node);
    void visit(ConditionalExprNode node);
    void visit(AssignmentExprNode node);
    void visit(ExprSeqNode node);
    /* statements */
    void visit(ExprStmtNode node);
    void visit(CompoundStmtNode node);
    void visit(IfStmtNode node);
    void visit(WhileStmtNode node);
    void visit(ForStmtNode node);
    void visit(BreakStmtNode node);
    void visit(ContinueStmtNode node);
    void visit(ReturnStmtNode node);
    void visit(DeclarationStmtNode node);
    /* specifiers */
    void visit(DeclSpecifierSeqNode node);
    void visit(ClassSpecifierNode node);
    void visit(ArrayTypeSpecifierNode node);
    void visit(BuiltInTypeSpecifierNode node);
    void visit(ClassTypeSpecifierNode node);
    /* declaration */
    void visit(VarNode node);
    void visit(VarSeqNode node);
    void visit(ParenedInitializerNode node);
    void visit(InitializerClauseNode node);
    void visit(InitializerListNode node);
    void visit(BracedInitListNode node);
    /* function */
    void visit(ParametersAndQualifiersNode node);
    void visit(FuncNode node);
    /* class */
    void visit(MemberSpecificationNode node);
}
