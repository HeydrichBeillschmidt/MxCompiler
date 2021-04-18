// Generated from C:/Days/Learning/SJTU/ACM/ComputerSystem/Compiler/MxCompiler/src/main/resources\MxParser.g4 by ANTLR 4.9.1
package Mx.Generated;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link MxParser}.
 */
public interface MxParserListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link MxParser#translationUnit}.
	 * @param ctx the parse tree
	 */
	void enterTranslationUnit(MxParser.TranslationUnitContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#translationUnit}.
	 * @param ctx the parse tree
	 */
	void exitTranslationUnit(MxParser.TranslationUnitContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#primaryExpression}.
	 * @param ctx the parse tree
	 */
	void enterPrimaryExpression(MxParser.PrimaryExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#primaryExpression}.
	 * @param ctx the parse tree
	 */
	void exitPrimaryExpression(MxParser.PrimaryExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#idExpression}.
	 * @param ctx the parse tree
	 */
	void enterIdExpression(MxParser.IdExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#idExpression}.
	 * @param ctx the parse tree
	 */
	void exitIdExpression(MxParser.IdExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#postfixExpression}.
	 * @param ctx the parse tree
	 */
	void enterPostfixExpression(MxParser.PostfixExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#postfixExpression}.
	 * @param ctx the parse tree
	 */
	void exitPostfixExpression(MxParser.PostfixExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#expressionList}.
	 * @param ctx the parse tree
	 */
	void enterExpressionList(MxParser.ExpressionListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#expressionList}.
	 * @param ctx the parse tree
	 */
	void exitExpressionList(MxParser.ExpressionListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#unaryExpression}.
	 * @param ctx the parse tree
	 */
	void enterUnaryExpression(MxParser.UnaryExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#unaryExpression}.
	 * @param ctx the parse tree
	 */
	void exitUnaryExpression(MxParser.UnaryExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#unaryOperator}.
	 * @param ctx the parse tree
	 */
	void enterUnaryOperator(MxParser.UnaryOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#unaryOperator}.
	 * @param ctx the parse tree
	 */
	void exitUnaryOperator(MxParser.UnaryOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#newExpression}.
	 * @param ctx the parse tree
	 */
	void enterNewExpression(MxParser.NewExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#newExpression}.
	 * @param ctx the parse tree
	 */
	void exitNewExpression(MxParser.NewExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#newTypeId}.
	 * @param ctx the parse tree
	 */
	void enterNewTypeId(MxParser.NewTypeIdContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#newTypeId}.
	 * @param ctx the parse tree
	 */
	void exitNewTypeId(MxParser.NewTypeIdContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#newDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterNewDeclarator(MxParser.NewDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#newDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitNewDeclarator(MxParser.NewDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#newInitializer}.
	 * @param ctx the parse tree
	 */
	void enterNewInitializer(MxParser.NewInitializerContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#newInitializer}.
	 * @param ctx the parse tree
	 */
	void exitNewInitializer(MxParser.NewInitializerContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#multiplicativeExpression}.
	 * @param ctx the parse tree
	 */
	void enterMultiplicativeExpression(MxParser.MultiplicativeExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#multiplicativeExpression}.
	 * @param ctx the parse tree
	 */
	void exitMultiplicativeExpression(MxParser.MultiplicativeExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#multiplicativeOperator}.
	 * @param ctx the parse tree
	 */
	void enterMultiplicativeOperator(MxParser.MultiplicativeOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#multiplicativeOperator}.
	 * @param ctx the parse tree
	 */
	void exitMultiplicativeOperator(MxParser.MultiplicativeOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#additiveExpression}.
	 * @param ctx the parse tree
	 */
	void enterAdditiveExpression(MxParser.AdditiveExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#additiveExpression}.
	 * @param ctx the parse tree
	 */
	void exitAdditiveExpression(MxParser.AdditiveExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#additiveOperator}.
	 * @param ctx the parse tree
	 */
	void enterAdditiveOperator(MxParser.AdditiveOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#additiveOperator}.
	 * @param ctx the parse tree
	 */
	void exitAdditiveOperator(MxParser.AdditiveOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#shiftExpression}.
	 * @param ctx the parse tree
	 */
	void enterShiftExpression(MxParser.ShiftExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#shiftExpression}.
	 * @param ctx the parse tree
	 */
	void exitShiftExpression(MxParser.ShiftExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#shiftOperator}.
	 * @param ctx the parse tree
	 */
	void enterShiftOperator(MxParser.ShiftOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#shiftOperator}.
	 * @param ctx the parse tree
	 */
	void exitShiftOperator(MxParser.ShiftOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#relationalExpression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalExpression(MxParser.RelationalExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#relationalExpression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalExpression(MxParser.RelationalExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#relationalOperator}.
	 * @param ctx the parse tree
	 */
	void enterRelationalOperator(MxParser.RelationalOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#relationalOperator}.
	 * @param ctx the parse tree
	 */
	void exitRelationalOperator(MxParser.RelationalOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#equalityExpression}.
	 * @param ctx the parse tree
	 */
	void enterEqualityExpression(MxParser.EqualityExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#equalityExpression}.
	 * @param ctx the parse tree
	 */
	void exitEqualityExpression(MxParser.EqualityExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#equalityOperator}.
	 * @param ctx the parse tree
	 */
	void enterEqualityOperator(MxParser.EqualityOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#equalityOperator}.
	 * @param ctx the parse tree
	 */
	void exitEqualityOperator(MxParser.EqualityOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#andExpression}.
	 * @param ctx the parse tree
	 */
	void enterAndExpression(MxParser.AndExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#andExpression}.
	 * @param ctx the parse tree
	 */
	void exitAndExpression(MxParser.AndExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#exclusiveOrExpression}.
	 * @param ctx the parse tree
	 */
	void enterExclusiveOrExpression(MxParser.ExclusiveOrExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#exclusiveOrExpression}.
	 * @param ctx the parse tree
	 */
	void exitExclusiveOrExpression(MxParser.ExclusiveOrExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#inclusiveOrExpression}.
	 * @param ctx the parse tree
	 */
	void enterInclusiveOrExpression(MxParser.InclusiveOrExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#inclusiveOrExpression}.
	 * @param ctx the parse tree
	 */
	void exitInclusiveOrExpression(MxParser.InclusiveOrExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#logicalAndExpression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalAndExpression(MxParser.LogicalAndExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#logicalAndExpression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalAndExpression(MxParser.LogicalAndExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#logicalOrExpression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalOrExpression(MxParser.LogicalOrExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#logicalOrExpression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalOrExpression(MxParser.LogicalOrExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#conditionalExpression}.
	 * @param ctx the parse tree
	 */
	void enterConditionalExpression(MxParser.ConditionalExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#conditionalExpression}.
	 * @param ctx the parse tree
	 */
	void exitConditionalExpression(MxParser.ConditionalExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#assignmentExpression}.
	 * @param ctx the parse tree
	 */
	void enterAssignmentExpression(MxParser.AssignmentExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#assignmentExpression}.
	 * @param ctx the parse tree
	 */
	void exitAssignmentExpression(MxParser.AssignmentExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#assignmentOperator}.
	 * @param ctx the parse tree
	 */
	void enterAssignmentOperator(MxParser.AssignmentOperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#assignmentOperator}.
	 * @param ctx the parse tree
	 */
	void exitAssignmentOperator(MxParser.AssignmentOperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterExpression(MxParser.ExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitExpression(MxParser.ExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#constantExpression}.
	 * @param ctx the parse tree
	 */
	void enterConstantExpression(MxParser.ConstantExpressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#constantExpression}.
	 * @param ctx the parse tree
	 */
	void exitConstantExpression(MxParser.ConstantExpressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(MxParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(MxParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#expressionStatement}.
	 * @param ctx the parse tree
	 */
	void enterExpressionStatement(MxParser.ExpressionStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#expressionStatement}.
	 * @param ctx the parse tree
	 */
	void exitExpressionStatement(MxParser.ExpressionStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#compoundStatement}.
	 * @param ctx the parse tree
	 */
	void enterCompoundStatement(MxParser.CompoundStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#compoundStatement}.
	 * @param ctx the parse tree
	 */
	void exitCompoundStatement(MxParser.CompoundStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#statementSeq}.
	 * @param ctx the parse tree
	 */
	void enterStatementSeq(MxParser.StatementSeqContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#statementSeq}.
	 * @param ctx the parse tree
	 */
	void exitStatementSeq(MxParser.StatementSeqContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#selectionStatement}.
	 * @param ctx the parse tree
	 */
	void enterSelectionStatement(MxParser.SelectionStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#selectionStatement}.
	 * @param ctx the parse tree
	 */
	void exitSelectionStatement(MxParser.SelectionStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#condition}.
	 * @param ctx the parse tree
	 */
	void enterCondition(MxParser.ConditionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#condition}.
	 * @param ctx the parse tree
	 */
	void exitCondition(MxParser.ConditionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#iterationStatement}.
	 * @param ctx the parse tree
	 */
	void enterIterationStatement(MxParser.IterationStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#iterationStatement}.
	 * @param ctx the parse tree
	 */
	void exitIterationStatement(MxParser.IterationStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#forInitStatement}.
	 * @param ctx the parse tree
	 */
	void enterForInitStatement(MxParser.ForInitStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#forInitStatement}.
	 * @param ctx the parse tree
	 */
	void exitForInitStatement(MxParser.ForInitStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void enterJumpStatement(MxParser.JumpStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void exitJumpStatement(MxParser.JumpStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#declarationStatement}.
	 * @param ctx the parse tree
	 */
	void enterDeclarationStatement(MxParser.DeclarationStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#declarationStatement}.
	 * @param ctx the parse tree
	 */
	void exitDeclarationStatement(MxParser.DeclarationStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#declarationSeq}.
	 * @param ctx the parse tree
	 */
	void enterDeclarationSeq(MxParser.DeclarationSeqContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#declarationSeq}.
	 * @param ctx the parse tree
	 */
	void exitDeclarationSeq(MxParser.DeclarationSeqContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#declaration}.
	 * @param ctx the parse tree
	 */
	void enterDeclaration(MxParser.DeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#declaration}.
	 * @param ctx the parse tree
	 */
	void exitDeclaration(MxParser.DeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#blockDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterBlockDeclaration(MxParser.BlockDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#blockDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitBlockDeclaration(MxParser.BlockDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#simpleDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterSimpleDeclaration(MxParser.SimpleDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#simpleDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitSimpleDeclaration(MxParser.SimpleDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#emptyDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterEmptyDeclaration(MxParser.EmptyDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#emptyDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitEmptyDeclaration(MxParser.EmptyDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#declSpecifierSeq}.
	 * @param ctx the parse tree
	 */
	void enterDeclSpecifierSeq(MxParser.DeclSpecifierSeqContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#declSpecifierSeq}.
	 * @param ctx the parse tree
	 */
	void exitDeclSpecifierSeq(MxParser.DeclSpecifierSeqContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#typeSpecifier}.
	 * @param ctx the parse tree
	 */
	void enterTypeSpecifier(MxParser.TypeSpecifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#typeSpecifier}.
	 * @param ctx the parse tree
	 */
	void exitTypeSpecifier(MxParser.TypeSpecifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#simpleTypeSpecifier}.
	 * @param ctx the parse tree
	 */
	void enterSimpleTypeSpecifier(MxParser.SimpleTypeSpecifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#simpleTypeSpecifier}.
	 * @param ctx the parse tree
	 */
	void exitSimpleTypeSpecifier(MxParser.SimpleTypeSpecifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#nonArrayTypeSpecifier}.
	 * @param ctx the parse tree
	 */
	void enterNonArrayTypeSpecifier(MxParser.NonArrayTypeSpecifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#nonArrayTypeSpecifier}.
	 * @param ctx the parse tree
	 */
	void exitNonArrayTypeSpecifier(MxParser.NonArrayTypeSpecifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#initDeclaratorList}.
	 * @param ctx the parse tree
	 */
	void enterInitDeclaratorList(MxParser.InitDeclaratorListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#initDeclaratorList}.
	 * @param ctx the parse tree
	 */
	void exitInitDeclaratorList(MxParser.InitDeclaratorListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#initDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterInitDeclarator(MxParser.InitDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#initDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitInitDeclarator(MxParser.InitDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#declarator}.
	 * @param ctx the parse tree
	 */
	void enterDeclarator(MxParser.DeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#declarator}.
	 * @param ctx the parse tree
	 */
	void exitDeclarator(MxParser.DeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#initializer}.
	 * @param ctx the parse tree
	 */
	void enterInitializer(MxParser.InitializerContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#initializer}.
	 * @param ctx the parse tree
	 */
	void exitInitializer(MxParser.InitializerContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#braceOrEqualInitializer}.
	 * @param ctx the parse tree
	 */
	void enterBraceOrEqualInitializer(MxParser.BraceOrEqualInitializerContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#braceOrEqualInitializer}.
	 * @param ctx the parse tree
	 */
	void exitBraceOrEqualInitializer(MxParser.BraceOrEqualInitializerContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#initializerClause}.
	 * @param ctx the parse tree
	 */
	void enterInitializerClause(MxParser.InitializerClauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#initializerClause}.
	 * @param ctx the parse tree
	 */
	void exitInitializerClause(MxParser.InitializerClauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#initializerList}.
	 * @param ctx the parse tree
	 */
	void enterInitializerList(MxParser.InitializerListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#initializerList}.
	 * @param ctx the parse tree
	 */
	void exitInitializerList(MxParser.InitializerListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#bracedInitList}.
	 * @param ctx the parse tree
	 */
	void enterBracedInitList(MxParser.BracedInitListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#bracedInitList}.
	 * @param ctx the parse tree
	 */
	void exitBracedInitList(MxParser.BracedInitListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#parametersAndQualifiers}.
	 * @param ctx the parse tree
	 */
	void enterParametersAndQualifiers(MxParser.ParametersAndQualifiersContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#parametersAndQualifiers}.
	 * @param ctx the parse tree
	 */
	void exitParametersAndQualifiers(MxParser.ParametersAndQualifiersContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#parameterDeclarationList}.
	 * @param ctx the parse tree
	 */
	void enterParameterDeclarationList(MxParser.ParameterDeclarationListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#parameterDeclarationList}.
	 * @param ctx the parse tree
	 */
	void exitParameterDeclarationList(MxParser.ParameterDeclarationListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterParameterDeclaration(MxParser.ParameterDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitParameterDeclaration(MxParser.ParameterDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#functionDefinition}.
	 * @param ctx the parse tree
	 */
	void enterFunctionDefinition(MxParser.FunctionDefinitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#functionDefinition}.
	 * @param ctx the parse tree
	 */
	void exitFunctionDefinition(MxParser.FunctionDefinitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#functionBody}.
	 * @param ctx the parse tree
	 */
	void enterFunctionBody(MxParser.FunctionBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#functionBody}.
	 * @param ctx the parse tree
	 */
	void exitFunctionBody(MxParser.FunctionBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#classSpecifier}.
	 * @param ctx the parse tree
	 */
	void enterClassSpecifier(MxParser.ClassSpecifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#classSpecifier}.
	 * @param ctx the parse tree
	 */
	void exitClassSpecifier(MxParser.ClassSpecifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#classHead}.
	 * @param ctx the parse tree
	 */
	void enterClassHead(MxParser.ClassHeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#classHead}.
	 * @param ctx the parse tree
	 */
	void exitClassHead(MxParser.ClassHeadContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#classKey}.
	 * @param ctx the parse tree
	 */
	void enterClassKey(MxParser.ClassKeyContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#classKey}.
	 * @param ctx the parse tree
	 */
	void exitClassKey(MxParser.ClassKeyContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#className}.
	 * @param ctx the parse tree
	 */
	void enterClassName(MxParser.ClassNameContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#className}.
	 * @param ctx the parse tree
	 */
	void exitClassName(MxParser.ClassNameContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#memberSpecification}.
	 * @param ctx the parse tree
	 */
	void enterMemberSpecification(MxParser.MemberSpecificationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#memberSpecification}.
	 * @param ctx the parse tree
	 */
	void exitMemberSpecification(MxParser.MemberSpecificationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#memberDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterMemberDeclaration(MxParser.MemberDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#memberDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitMemberDeclaration(MxParser.MemberDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#memberDeclaratorList}.
	 * @param ctx the parse tree
	 */
	void enterMemberDeclaratorList(MxParser.MemberDeclaratorListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#memberDeclaratorList}.
	 * @param ctx the parse tree
	 */
	void exitMemberDeclaratorList(MxParser.MemberDeclaratorListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#memberDeclarator}.
	 * @param ctx the parse tree
	 */
	void enterMemberDeclarator(MxParser.MemberDeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#memberDeclarator}.
	 * @param ctx the parse tree
	 */
	void exitMemberDeclarator(MxParser.MemberDeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#builtinType}.
	 * @param ctx the parse tree
	 */
	void enterBuiltinType(MxParser.BuiltinTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#builtinType}.
	 * @param ctx the parse tree
	 */
	void exitBuiltinType(MxParser.BuiltinTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxParser#literal}.
	 * @param ctx the parse tree
	 */
	void enterLiteral(MxParser.LiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxParser#literal}.
	 * @param ctx the parse tree
	 */
	void exitLiteral(MxParser.LiteralContext ctx);
}