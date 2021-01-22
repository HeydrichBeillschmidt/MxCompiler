package Mx.Frontend;

import Mx.AST.*;
import Mx.AST.Expressions.*;
import Mx.AST.Expressions.Literals.*;
import Mx.AST.Initializers.*;
import Mx.AST.Specifiers.*;
import Mx.AST.Statements.*;
import Mx.Generated.MxParser;
import Mx.Generated.MxParserBaseVisitor;
import Mx.Utils.ExceptionHandler;
import Mx.Utils.Location;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class ASTBuilder extends MxParserBaseVisitor<ASTNode>{
    ExceptionHandler exceptionHandler;

    public ASTBuilder(ExceptionHandler e) {
        this.exceptionHandler = e;
    }

    @Override
    public ASTNode visitTranslationUnit(MxParser.TranslationUnitContext ctx) {
        ArrayList<DeclarationNode> decls = new ArrayList<>();
        if (ctx.declarationSeq()!=null)
            for (var decl: ctx.declarationSeq().declaration()) {
                ASTNode trans = visit(decl);
                if (trans instanceof VarSeqNode)
                    decls.addAll(((VarSeqNode) trans).getVarNodes());
                else if (trans != null)
                    decls.add((DeclarationNode) trans);
            }
        return new ASTRoot(new Location(ctx), decls);
    }

    @Override
    public ASTNode visitPrimaryExpression(MxParser.PrimaryExpressionContext ctx) {
        if (ctx.literal()!=null)
            return visit(ctx.literal());
        else if (ctx.expression()!=null)
            return visit(ctx.expression());
        else if (ctx.This()!=null)
            return new ThisExprNode(new Location(ctx.getStart()), ctx.getText());
        else // idExpression
            return visit(ctx.idExpression());
    }

    @Override
    public ASTNode visitIdExpression(MxParser.IdExpressionContext ctx) {
        return new IdExprNode(new Location(ctx.getStart()), ctx.getText(),
                ctx.Identifier().getText());
    }

    @Override
    public ASTNode visitPostfixExpression(MxParser.PostfixExpressionContext ctx) {
        if (ctx.primaryExpression()!=null)
            return visit(ctx.primaryExpression());
        else if (ctx.LeftBracket()!=null) { // Subscript
            ExprNode name = (ExprNode) visit(ctx.postfixExpression());
            ExprNode index = (ExprNode) visit(ctx.expression());
            return new SubscriptExprNode(new Location(ctx.getStart()), ctx.getText(), name, index);
        }
        else if (ctx.LeftParen()!=null) { // FuncCall
            ExprNode name = (ExprNode) visit(ctx.postfixExpression());
            if (ctx.expressionList()!=null) {
                ArrayList<InitializerClauseNode> temp
                        = ((InitializerListNode)visit(ctx.expressionList())).getInitClauses();
                ArrayList<ExprNode> parameters = new ArrayList<>(temp);
                return new FuncCallExprNode(new Location(ctx.getStart()), ctx.getText(),
                        name, parameters);
            }
            return new FuncCallExprNode(new Location(ctx.getStart()), ctx.getText(),
                    name, null);
        }
        else if (ctx.Dot()!=null) { // Member
            ExprNode name = (ExprNode) visit(ctx.expression());
            String member = ((IdExprNode) visit(ctx.idExpression())).getIdentifier();
            return new MemberExprNode(new Location(ctx.getStart()), ctx.getText(), name, member);
        }
        else { // Postfix
            String op = ctx.PlusPlus()!=null ? "++" : "--";
            return new PostfixExprNode(new Location(ctx.getStart()), ctx.getText(),
                    op, (ExprNode) visit(ctx.expression()));
        }
    }

    @Override
    public ASTNode visitExpressionList(MxParser.ExpressionListContext ctx) {
        return visit(ctx.initializerList());
    }

    @Override
    public ASTNode visitUnaryExpression(MxParser.UnaryExpressionContext ctx) {
        if (ctx.postfixExpression()!=null)
            return visit(ctx.postfixExpression());
        else if (ctx.unaryExpression()!=null) { // Prefix
            String op;
            if (ctx.PlusPlus()!=null)
                op = "++";
            else if (ctx.MinusMinus()!=null)
                op = "--";
            else if (ctx.unaryOperator().Or()!=null)
                op = "|";
            else if (ctx.unaryOperator().Star()!=null)
                op = "*";
            else if (ctx.unaryOperator().And()!=null)
                op = "&";
            else if (ctx.unaryOperator().Plus()!=null)
                op = "+";
            else if (ctx.unaryOperator().Tilde()!=null)
                op = "~";
            else if (ctx.unaryOperator().Minus()!=null)
                op = "-";
            else // Not
                op = "!";
            ExprNode expr = (ExprNode) visit(ctx.unaryExpression());
            return new PrefixExprNode(new Location(ctx.getStart()), ctx.getText(), op, expr);
        }
        else { // New
            return visit(ctx.newExpression());
        }
    }

    @Override
    public ASTNode visitUnaryOperator(MxParser.UnaryOperatorContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitNewExpression(MxParser.NewExpressionContext ctx) {
        return visit(ctx.newTypeId());
    }

    @Override
    public ASTNode visitNewTypeId(MxParser.NewTypeIdContext ctx) {
        DeclSpecifierSeqNode specifier = (DeclSpecifierSeqNode) visit(ctx.typeSpecifierSeq());
        if (ctx.newDeclarator()!=null) {
            ArrayList<ExprNode> indexes
                    = ((ExprSeqNode) visit(ctx.newDeclarator())).getSubExpressions();
            return new NewExprNode(new Location(ctx.getStart()), ctx.getText(),
                    specifier, indexes);
        }
        return new NewExprNode(new Location(ctx.getStart()), ctx.getText(),
                specifier, null);
    }

    @Override
    public ASTNode visitNewDeclarator(MxParser.NewDeclaratorContext ctx) {
        ArrayList<ExprNode> indexes = new ArrayList<>();
        if (ctx.expression()!=null) {
            ExprNode first = ((ExprSeqNode) visit(ctx.expression())).getSubExpressions().get(0);
            indexes.add(first);
        }
        else {
            indexes = ((ExprSeqNode) visit(ctx.newDeclarator())).getSubExpressions();
            if (ctx.constantExpression()!=null) {
                indexes.add((ConditionalExprNode) visit(ctx.constantExpression()));
            }
            else {
                indexes.add(new ConditionalExprNode(new Location(ctx.getStart()),
                        ctx.getText(), null));
            }
        }
        return new ExprSeqNode(new Location(ctx.getStart()), ctx.getText(), indexes);
    }

    @Override
    public ASTNode visitNewInitializer(MxParser.NewInitializerContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitMultiplicativeExpression(MxParser.MultiplicativeExpressionContext ctx) {
        ArrayList<ExprNode> factors = new ArrayList<>();
        ArrayList<String> ops = new ArrayList<>();
        factors.add((ExprNode) visit(ctx.unaryExpression(0)));
        for (int i = 1, it = ctx.unaryExpression().size(); i < it; ++i) {
            factors.add((ExprNode) visit(ctx.unaryExpression(i)));
            if (ctx.multiplicativeOperator(i-1).Star()!=null)
                ops.add("*");
            else if (ctx.multiplicativeOperator(i-1).Div()!=null)
                ops.add("/");
            else // %
                ops.add("%");
        }
        return new MultiplicativeExprNode(new Location(ctx.getStart()), ctx.getText(), factors, ops);
    }

    @Override
    public ASTNode visitMultiplicativeOperator(MxParser.MultiplicativeOperatorContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitAdditiveExpression(MxParser.AdditiveExpressionContext ctx) {
        ArrayList<MultiplicativeExprNode> terms = new ArrayList<>();
        ArrayList<String> ops = new ArrayList<>();
        terms.add((MultiplicativeExprNode) visit(ctx.multiplicativeExpression(0)));
        for (int i = 1, it = ctx.multiplicativeExpression().size(); i < it; ++i) {
            terms.add((MultiplicativeExprNode) visit(ctx.multiplicativeExpression(i)));
            if (ctx.additiveOperator(i-1).Plus()!=null)
                ops.add("+");
            else // -
                ops.add("-");
        }
        return new AdditiveExprNode(new Location(ctx.getStart()), ctx.getText(), terms, ops);
    }

    @Override
    public ASTNode visitAdditiveOperator(MxParser.AdditiveOperatorContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitShiftExpression(MxParser.ShiftExpressionContext ctx) {
        ArrayList<AdditiveExprNode> terms = new ArrayList<>();
        ArrayList<String> ops = new ArrayList<>();
        terms.add((AdditiveExprNode) visit(ctx.additiveExpression(0)));
        for (int i = 1, it = ctx.additiveExpression().size(); i < it; ++i) {
            terms.add((AdditiveExprNode) visit(ctx.additiveExpression(i)));
            if (ctx.shiftOperator(i-1).LeftShift()!=null)
                ops.add("<<");
            else // >>
                ops.add(">>");
        }
        return new ShiftExprNode(new Location(ctx.getStart()), ctx.getText(), terms, ops);
    }

    @Override
    public ASTNode visitShiftOperator(MxParser.ShiftOperatorContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitRelationalExpression(MxParser.RelationalExpressionContext ctx) {
        ArrayList<ShiftExprNode> ariths = new ArrayList<>();
        ArrayList<String> ops = new ArrayList<>();
        ariths.add((ShiftExprNode) visit(ctx.shiftExpression(0)));
        for (int i = 1, it = ctx.shiftExpression().size(); i < it; ++i) {
            ariths.add((ShiftExprNode) visit(ctx.shiftExpression(i)));
            if (ctx.relationalOperator(i-1).Less()!=null)
                ops.add("<");
            else if (ctx.relationalOperator(i-1).Greater()!=null)
                ops.add(">");
            else if (ctx.relationalOperator(i-1).LessEqual()!=null)
                ops.add("<=");
            else // >=
                ops.add(">=");
        }
        return new RelationalExprNode(new Location(ctx.getStart()), ctx.getText(), ariths, ops);
    }

    @Override
    public ASTNode visitRelationalOperator(MxParser.RelationalOperatorContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitEqualityExpression(MxParser.EqualityExpressionContext ctx) {
        ArrayList<RelationalExprNode> ariths = new ArrayList<>();
        ArrayList<String> ops = new ArrayList<>();
        ariths.add((RelationalExprNode) visit(ctx.relationalExpression(0)));
        for (int i = 1, it = ctx.relationalExpression().size(); i < it; ++i) {
            ariths.add((RelationalExprNode) visit(ctx.relationalExpression(i)));
            if (ctx.equalityOperator(i-1).Equal()!=null)
                ops.add("==");
            else // !=
                ops.add("!=");
        }
        return new EqualityExprNode(new Location(ctx.getStart()), ctx.getText(), ariths, ops);
    }

    @Override
    public ASTNode visitEqualityOperator(MxParser.EqualityOperatorContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitAndExpression(MxParser.AndExpressionContext ctx) {
        ArrayList<EqualityExprNode> tests = new ArrayList<>();
        for (var test: ctx.equalityExpression())
            tests.add((EqualityExprNode) visit(test));
        return new AndExprNode(new Location(ctx.getStart()), ctx.getText(),
                tests, ctx.equalityExpression().size()-1);
    }

    @Override
    public ASTNode visitExclusiveOrExpression(MxParser.ExclusiveOrExpressionContext ctx) {
        ArrayList<AndExprNode> tests = new ArrayList<>();
        for (var test: ctx.andExpression())
            tests.add((AndExprNode) visit(test));
        return new ExclusiveOrExprNode(new Location(ctx.getStart()), ctx.getText(),
                tests, ctx.andExpression().size()-1);
    }

    @Override
    public ASTNode visitInclusiveOrExpression(MxParser.InclusiveOrExpressionContext ctx) {
        ArrayList<ExclusiveOrExprNode> tests = new ArrayList<>();
        for (var test: ctx.exclusiveOrExpression())
            tests.add((ExclusiveOrExprNode) visit(test));
        return new InclusiveOrExprNode(new Location(ctx.getStart()), ctx.getText(),
                tests, ctx.exclusiveOrExpression().size()-1);
    }

    @Override
    public ASTNode visitLogicalAndExpression(MxParser.LogicalAndExpressionContext ctx) {
        ArrayList<InclusiveOrExprNode> tests = new ArrayList<>();
        for (var test: ctx.inclusiveOrExpression())
            tests.add((InclusiveOrExprNode) visit(test));
        return new LogicalAndExprNode(new Location(ctx.getStart()), ctx.getText(),
                tests, ctx.inclusiveOrExpression().size()-1);
    }

    @Override
    public ASTNode visitLogicalOrExpression(MxParser.LogicalOrExpressionContext ctx) {
        ArrayList<LogicalAndExprNode> tests = new ArrayList<>();
        for (var test: ctx.logicalAndExpression())
            tests.add((LogicalAndExprNode) visit(test));
        return new LogicalOrExprNode(new Location(ctx.getStart()), ctx.getText(),
                tests, ctx.logicalAndExpression().size()-1);
    }

    @Override
    public ASTNode visitConditionalExpression(MxParser.ConditionalExpressionContext ctx) {
        return new ConditionalExprNode(new Location(ctx.getStart()), ctx.getText(),
                (LogicalOrExprNode) visit(ctx.logicalOrExpression()));
    }

    @Override
    public ASTNode visitAssignmentExpression(MxParser.AssignmentExpressionContext ctx) {
        if (ctx.conditionalExpression()!=null)
            return visit(ctx.conditionalExpression());
        else { // Assignment
            LogicalOrExprNode lhs = (LogicalOrExprNode) visit(ctx.logicalOrExpression());
            String op;
            if (ctx.assignmentOperator().Assign()!=null)
                op = "=";
            else if (ctx.assignmentOperator().StarAssign()!=null)
                op = "*=";
            else if (ctx.assignmentOperator().DivAssign()!=null)
                op = "/=";
            else if (ctx.assignmentOperator().ModAssign()!=null)
                op = "%=";
            else if (ctx.assignmentOperator().PlusAssign()!=null)
                op = "+=";
            else if (ctx.assignmentOperator().MinusAssign()!=null)
                op = "-=";
            else if (ctx.assignmentOperator().RightShiftAssign()!=null)
                op = ">>=";
            else if (ctx.assignmentOperator().LeftShiftAssign()!=null)
                op = "<<=";
            else if (ctx.assignmentOperator().AndAssign()!=null)
                op = "&=";
            else if (ctx.assignmentOperator().XorAssign()!=null)
                op = "^=";
            else // |=
                op = "|=";
            InitializerClauseNode rhs = (InitializerClauseNode) visit(ctx.initializerClause());
            return new AssignmentExprNode(new Location(ctx.getStart()), ctx.getText(), lhs, op, rhs);
        }
    }

    @Override
    public ASTNode visitExpression(MxParser.ExpressionContext ctx) {
        ArrayList<ExprNode> tests = new ArrayList<>();
        for (var test: ctx.assignmentExpression())
            tests.add((ExprNode) visit(test));
        return new ExprSeqNode(new Location(ctx.getStart()), ctx.getText(), tests);
    }

    @Override
    public ASTNode visitConstantExpression(MxParser.ConstantExpressionContext ctx) {
        return visit(ctx.conditionalExpression());
    }

    /* statements */

    @Override
    public ASTNode visitStatement(MxParser.StatementContext ctx) {
        if (ctx.expressionStatement()!=null)
            return visit(ctx.expressionStatement());
        else if (ctx.compoundStatement()!=null)
            return visit(ctx.compoundStatement());
        else if (ctx.selectionStatement()!=null)
            return visit(ctx.selectionStatement());
        else if (ctx.iterationStatement()!=null)
            return visit(ctx.iterationStatement());
        else if (ctx.jumpStatement()!=null)
            return visit(ctx.jumpStatement());
        else // declarationStmt
            return visit(ctx.declarationStatement());
    }

    @Override
    public ASTNode visitExpressionStatement(MxParser.ExpressionStatementContext ctx) {
        ExprNode expr = null;
        if (ctx.expression()!=null)
            expr = (ExprNode) visit(ctx.expression());
        return new ExprStmtNode(new Location(ctx.getStart()), expr);
    }

    @Override
    public ASTNode visitCompoundStatement(MxParser.CompoundStatementContext ctx) {
        ArrayList<StmtNode> stmts = new ArrayList<>();
        if (ctx.statementSeq()!=null) {
            for (var stmt: ctx.statementSeq().statement())
                stmts.add((StmtNode) visit(stmt));
        }
        return new CompoundStmtNode(new Location(ctx.getStart()), stmts);
    }

    @Override
    public ASTNode visitStatementSeq(MxParser.StatementSeqContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitSelectionStatement(MxParser.SelectionStatementContext ctx) {
        ExprNode condition = (ExprNode) visit(ctx.condition());
        StmtNode selectBody, elseBody = null;
        if (ctx.If()!=null) {
            selectBody = (StmtNode) visit(ctx.statement(0));
            if (ctx.Else()!=null) {
                elseBody = (StmtNode) visit(ctx.statement(1));
            }
            return new IfStmtNode(new Location(ctx.getStart()), condition, selectBody, elseBody);
        }
        return null;
    }

    @Override
    public ASTNode visitCondition(MxParser.ConditionContext ctx) {
        return visit(ctx.expression());
    }

    @Override
    public ASTNode visitIterationStatement(MxParser.IterationStatementContext ctx) {
        StmtNode loopBody = (StmtNode) visit(ctx.statement());
        if (ctx.While()!=null) {
            ExprNode condition = (ExprNode) visit(ctx.condition());
            return new WhileStmtNode(new Location(ctx.getStart()), condition, loopBody);
        }
        else if (ctx.For()!=null) {
            StmtNode initStmt = (StmtNode) visit(ctx.forInitStatement());
            ExprNode condition = null;
            if (ctx.expression()!=null) condition = (ExprNode) visit(ctx.condition());
            ExprNode stepExpr = null;
            if (ctx.expression()!=null) stepExpr = (ExprNode) visit(ctx.expression());
            return new ForStmtNode(new Location(ctx.getStart()),
                    initStmt, condition, stepExpr, loopBody);
        }
        return null;
    }

    @Override
    public ASTNode visitForInitStatement(MxParser.ForInitStatementContext ctx) {
        if (ctx.expressionStatement()!=null)
            return visit(ctx.expressionStatement());
        else // simpleDeclaration
            return new DeclarationStmtNode(new Location(ctx.getStart()),
                    (VarSeqNode) visit(ctx.simpleDeclaration()));
    }

    @Override
    public ASTNode visitJumpStatement(MxParser.JumpStatementContext ctx) {
        if (ctx.Break()!=null)
            return new BreakStmtNode(new Location(ctx.getStart()));
        else if (ctx.Continue()!=null)
            return new ContinueStmtNode(new Location(ctx.getStart()));
        else if (ctx.Return()!=null) {
            ExprSeqNode retTmp;
            ExprNode retExpr = null;
            if (ctx.expression()!=null) {
                retTmp = (ExprSeqNode) visit(ctx.expression());
                if (retTmp.getSubExpressions().size()>1) {
                    exceptionHandler.error("Cannot return multiple expressions: "
                            + retTmp.toString(), new Location(ctx.getStart()));
                }
                retExpr = retTmp.getSubExpressions().get(0);
            }
            return new ReturnStmtNode(new Location(ctx.getStart()), retExpr);
        }
        return null;
    }

    @Override
    public ASTNode visitDeclarationStatement(MxParser.DeclarationStatementContext ctx) {
        return new DeclarationStmtNode(new Location(ctx.getStart()),
                (VarSeqNode) visit(ctx.blockDeclaration()));
    }

    /* declarations */

    @Override
    public ASTNode visitDeclarationSeq(MxParser.DeclarationSeqContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitDeclaration(MxParser.DeclarationContext ctx) {
        if (ctx.functionDefinition() != null)
            return visit(ctx.functionDefinition());
        else if (ctx.blockDeclaration() != null)
            return visit(ctx.blockDeclaration());
        else
            return null;
    }

    @Override
    public ASTNode visitBlockDeclaration(MxParser.BlockDeclarationContext ctx) {
        return visit(ctx.simpleDeclaration());
    }

    @Override
    public ASTNode visitSimpleDeclaration(MxParser.SimpleDeclarationContext ctx) {
        DeclSpecifierSeqNode specifier = (DeclSpecifierSeqNode) visit(ctx.declSpecifierSeq());
        ArrayList<VarNode> varNodes = new ArrayList<>();
        if (ctx.initDeclaratorList()!=null) {
            varNodes = ((VarSeqNode) visit(ctx.initDeclaratorList())).getVarNodes();
            for (var node: varNodes)
                node.setSpecifier(specifier);
        }
        else {
            VarNode classSpecifierNode = new VarNode(new Location(ctx.getStart()),
                    specifier, null, null);
            varNodes.add(classSpecifierNode);
        }

        return new VarSeqNode(new Location(ctx.getStart()), varNodes);
    }

    @Override
    public ASTNode visitEmptyDeclaration(MxParser.EmptyDeclarationContext ctx) {
        return null;
    }

    /* specifiers */

    @Override
    public ASTNode visitDeclSpecifier(MxParser.DeclSpecifierContext ctx) {
        if (ctx.storageClassSpecifier() != null)
            return visit(ctx.storageClassSpecifier());
        else if (ctx.functionSpecifier()!=null)
            return visit(ctx.functionSpecifier());
        else if (ctx.Friend()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "friend");
        else if (ctx.Typedef()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "typedef");
        else if (ctx.Constexpr()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "constexpr");
        else return visit(ctx.trailingTypeSpecifier());
    }

    @Override
    public ASTNode visitDeclSpecifierSeq(MxParser.DeclSpecifierSeqContext ctx) {
        TypeSpecifierNode typeSpecifier = (TypeSpecifierNode) visit(ctx.typeSpecifier());
        if (ctx.declSpecifier()!=null) {
            Set<NonTypeSpecifierNode> declSpecifiers = new HashSet<>();
            for (var declSpec: ctx.declSpecifier())
                declSpecifiers.add((NonTypeSpecifierNode) visit(declSpec));
            return new DeclSpecifierSeqNode(new Location(ctx.getStart()),
                    typeSpecifier, declSpecifiers);
        }
        return new DeclSpecifierSeqNode(new Location(ctx.getStart()), typeSpecifier);
    }

    @Override
    public ASTNode visitStorageClassSpecifier(MxParser.StorageClassSpecifierContext ctx) {
        if (ctx.Register()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "register");
        else if (ctx.Static()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "static");
        else if (ctx.Thread_local()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "thread_local");
        else if (ctx.Extern()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "extern");
        else return new NonTypeSpecifierNode(new Location(ctx.getStart()), "mutable");
    }

    @Override
    public ASTNode visitFunctionSpecifier(MxParser.FunctionSpecifierContext ctx) {
        if (ctx.Inline()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "inline");
        else if (ctx.Virtual()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "virtual");
        else return new NonTypeSpecifierNode(new Location(ctx.getStart()), "explicit");
    }

    @Override
    public ASTNode visitTypeSpecifier(MxParser.TypeSpecifierContext ctx) {
        if (ctx.simpleTypeSpecifier()!=null)
            return visit(ctx.simpleTypeSpecifier());
        else
            return visit(ctx.classSpecifier());
    }

    @Override
    public ASTNode visitTrailingTypeSpecifier(MxParser.TrailingTypeSpecifierContext ctx) {
        if (ctx.cvQualifier()!=null) {
            return visit(ctx.cvQualifier());
        }
        return null;
    }

    @Override
    public ASTNode visitTypeSpecifierSeq(MxParser.TypeSpecifierSeqContext ctx) {
        TypeSpecifierNode typeSpecifier = (TypeSpecifierNode) visit(ctx.typeSpecifier());
        if (ctx.trailingTypeSpecifier()!=null) {
            Set<NonTypeSpecifierNode> declSpecifiers = new HashSet<>();
            for (var declSpec: ctx.trailingTypeSpecifier())
                declSpecifiers.add((NonTypeSpecifierNode) visit(declSpec));
            return new DeclSpecifierSeqNode(new Location(ctx.getStart()),
                    typeSpecifier, declSpecifiers);
        }
        return new DeclSpecifierSeqNode(new Location(ctx.getStart()), typeSpecifier);
    }

    @Override
    public ASTNode visitSimpleTypeSpecifier(MxParser.SimpleTypeSpecifierContext ctx) {
        if (ctx.nonArrayTypeSpecifier()!=null)
            return visit(ctx.nonArrayTypeSpecifier());
        else
            return new ArrayTypeSpecifierNode(new Location(ctx.getStart()),
                    (SimpleTypeSpecifierNode) visit(ctx.simpleTypeSpecifier()));
    }

    @Override
    public ASTNode visitNonArrayTypeSpecifier(MxParser.NonArrayTypeSpecifierContext ctx) {
        if (ctx.className()!=null) {
            Location loc = new Location(ctx.getStart());
            return new ClassTypeSpecifierNode(loc, ctx.className().Identifier().getText());
        }
        else // BuiltInType
            return visit(ctx.builtinType());
    }

    /* declarators and initializers */

    @Override
    public ASTNode visitInitDeclaratorList(MxParser.InitDeclaratorListContext ctx) {
        ArrayList<VarNode> varNodes = new ArrayList<>();
        for (var node: ctx.initDeclarator())
            varNodes.add((VarNode) visit(node));
        return new VarSeqNode(new Location(ctx.getStart()), varNodes);
    }

    @Override
    public ASTNode visitInitDeclarator(MxParser.InitDeclaratorContext ctx) {
        Location loc = new Location(ctx.getStart());
        DeclSpecifierSeqNode specifier = new DeclSpecifierSeqNode(loc,
                new BuiltInTypeSpecifierNode(loc, "#SpecifierToBeSet#"));
        String name = ((IdExprNode) visit(ctx.declarator())).getIdentifier();
        InitializerNode initializer = ctx.initializer()!=null ?
                (InitializerNode) visit(ctx.initializer()) : null;
        return new VarNode(loc, specifier, name, initializer);
    }

    @Override
    public ASTNode visitDeclarator(MxParser.DeclaratorContext ctx) {
        return visit(ctx.idExpression());
    }

    @Override
    public ASTNode visitInitializer(MxParser.InitializerContext ctx) {
        if (ctx.braceOrEqualInitializer()!=null)
            return visit(ctx.braceOrEqualInitializer());
        else { // Paren
            InitializerListNode list = (InitializerListNode) visit(ctx.expressionList());
            return new ParenedInitializerNode(new Location(ctx.getStart()), ctx.getText(), list);
        }
    }

    @Override
    public ASTNode visitBraceOrEqualInitializer(MxParser.BraceOrEqualInitializerContext ctx) {
        return visit(ctx.initializerClause());
    }

    @Override
    public ASTNode visitInitializerClause(MxParser.InitializerClauseContext ctx) {
        ExprNode expr;
        boolean isAssignment = ctx.assignmentExpression()!=null;
        if (isAssignment)
            expr = (ExprNode) visit(ctx.assignmentExpression());
        else // braceInitList
            expr = (ExprNode) visit(ctx.bracedInitList());
        return new InitializerClauseNode(new Location(ctx.getStart()), ctx.getText(), expr, isAssignment);
    }

    @Override
    public ASTNode visitInitializerList(MxParser.InitializerListContext ctx) {
        ArrayList<InitializerClauseNode> clauses = new ArrayList<>();
        for (var clause: ctx.initializerClause())
            clauses.add((InitializerClauseNode) visit(clause));
        return new InitializerListNode(new Location(ctx.getStart()), ctx.getText(), clauses);
    }

    @Override
    public ASTNode visitBracedInitList(MxParser.BracedInitListContext ctx) {
        BracedInitListNode node = new BracedInitListNode(new Location(ctx.getStart()), ctx.getText());
        if (ctx.initializerList()!=null)
            node.setInitList((InitializerListNode) visit(ctx.initializerList()));
        return node;
    }

    @Override
    public ASTNode visitCvQualifier(MxParser.CvQualifierContext ctx) {
        if (ctx.Const()!=null)
            return new NonTypeSpecifierNode(new Location(ctx.getStart()), "const");
        else return new NonTypeSpecifierNode(new Location(ctx.getStart()), "volatile");
    }

    /* function */

    @Override
    public ASTNode visitParametersAndQualifiers(MxParser.ParametersAndQualifiersContext ctx) {
        ArrayList<VarNode> parameters = new ArrayList<>();
        if (ctx.parameterDeclarationList()!=null)
            for (var parameter: ctx.parameterDeclarationList().parameterDeclaration())
                parameters.add((VarNode) visit(parameter));
        return new ParametersAndQualifiersNode(new Location(ctx.getStart()), parameters);
    }

    @Override
    public ASTNode visitParameterDeclarationList(MxParser.ParameterDeclarationListContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitParameterDeclaration(MxParser.ParameterDeclarationContext ctx) {
        Location loc = new Location(ctx.getStart());
        DeclSpecifierSeqNode specifier = (DeclSpecifierSeqNode) visit(ctx.declSpecifierSeq());
        String name = ((IdExprNode) visit(ctx.declarator())).getIdentifier();
        InitializerNode initializer = (InitializerNode) visit(ctx.initializerClause());
        return new VarNode(loc, specifier, name, initializer);
    }

    @Override
    public ASTNode visitFunctionDefinition(MxParser.FunctionDefinitionContext ctx) {
        DeclSpecifierSeqNode specifier = null;
        if (ctx.declSpecifierSeq()!=null)
            specifier = (DeclSpecifierSeqNode) visit(ctx.declSpecifierSeq());
        String name = ((IdExprNode) visit(ctx.declarator())).getIdentifier();
        CompoundStmtNode funcBody = (CompoundStmtNode) visit(ctx.functionBody());
        return new FuncNode(new Location(ctx.getStart()), specifier, name,
                ((ParametersAndQualifiersNode) visit(ctx.parametersAndQualifiers())).getParameters(),
                funcBody);
    }

    @Override
    public ASTNode visitFunctionBody(MxParser.FunctionBodyContext ctx) {
        return visit(ctx.compoundStatement());
    }

    /* class */

    @Override
    public ASTNode visitClassSpecifier(MxParser.ClassSpecifierContext ctx) {
        String className = ctx.classHead().className().Identifier().getText();

        MemberSpecificationNode tmp = null;
        if (ctx.memberSpecification()!=null) {
            tmp = (MemberSpecificationNode) visit(ctx.memberSpecification());
            tmp.correctConstructors(className); // remember to handle wrong constructors!
        }
        return new ClassSpecifierNode(new Location(ctx.getStart()), className, tmp);
    }

    @Override
    public ASTNode visitClassHead(MxParser.ClassHeadContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitClassKey(MxParser.ClassKeyContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitClassName(MxParser.ClassNameContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitMemberSpecification(MxParser.MemberSpecificationContext ctx) {
        ArrayList<VarNode> members = new ArrayList<>();
        ArrayList<FuncNode> constructors = new ArrayList<>();
        ArrayList<FuncNode> methods = new ArrayList<>();
        VarNode varTmp;
        DeclSpecifierSeqNode specifier;
        FuncNode funcTmp;
        for (var memDecl: ctx.memberDeclaration()) {
            if (memDecl.declSpecifierSeq()!=null) {
                specifier = (DeclSpecifierSeqNode) visit(memDecl.declSpecifierSeq());
                if (memDecl.memberDeclaratorList()!=null)
                    for (var node: memDecl.memberDeclaratorList().memberDeclarator()) {
                        varTmp = (VarNode) visit(node);
                        varTmp.setSpecifier(specifier);
                        members.add(varTmp);
                    }
            }
            else if (memDecl.functionDefinition()!=null) {
                funcTmp = (FuncNode) visit(memDecl.functionDefinition());
                if (funcTmp.getSpecifier()!=null)
                    methods.add(funcTmp);
                else
                    constructors.add(funcTmp);
            }
        }
        return new MemberSpecificationNode(new Location(ctx.getStart()),
                members, constructors, methods);
    }

    @Override
    public ASTNode visitMemberDeclaration(MxParser.MemberDeclarationContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitMemberDeclaratorList(MxParser.MemberDeclaratorListContext ctx) {
        return null;
    }

    @Override
    public ASTNode visitMemberDeclarator(MxParser.MemberDeclaratorContext ctx) {
        Location loc = new Location(ctx.getStart());
        DeclSpecifierSeqNode specifier = new DeclSpecifierSeqNode(loc,
                new BuiltInTypeSpecifierNode(loc, "#SpecifierToBeSet#"));
        String name = ((IdExprNode) visit(ctx.declarator())).getIdentifier();
        InitializerNode initializer = ctx.braceOrEqualInitializer()!=null ?
                (InitializerNode) visit(ctx.braceOrEqualInitializer()) : null;
        return new VarNode(loc, specifier, name, initializer);
    }

    /* basic */

    @Override
    public ASTNode visitBuiltinType(MxParser.BuiltinTypeContext ctx) {
        Location loc = new Location(ctx.getStart());
        if (ctx.Int()!=null)
            return new BuiltInTypeSpecifierNode(loc, "int");
        else if (ctx.Bool()!=null)
            return new BuiltInTypeSpecifierNode(loc, "bool");
        else if (ctx.String()!=null)
            return new BuiltInTypeSpecifierNode(loc, "string");
        else // Void
            return new BuiltInTypeSpecifierNode(loc, "void");
    }

    @Override
    public ASTNode visitLiteral(MxParser.LiteralContext ctx) {
        Location loc = new Location(ctx.getStart());
        String text = ctx.getText();
        String value = ctx.getText();
        if (ctx.BooleanLiteral()!=null)
            return new BoolLiteralNode(loc, text, value.equals("true"));
        else if (ctx.IntegerLiteral()!=null)
            return new IntLiteralNode(loc ,text, Integer.parseInt(value));
        else if (ctx.StringLiteral()!=null)
            return new StringLiteralNode(loc, text, value.substring(1, value.length()-1));
        else // Null
            return new NullLiteralNode(loc, text);
    }
}
