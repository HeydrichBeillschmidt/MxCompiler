package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.AST.Expressions.ExprNode;
import Mx.IR.IRBlock;
import Mx.Utils.Location;

public class ForStmtNode extends StmtNode {
    private final StmtNode forInitStmt;
    private final ExprNode condition;
    private final ExprNode stepExpr;
    private final StmtNode loopBody;

    private IRBlock condBlock;
    private IRBlock incBlock;
    private IRBlock bodyBlock;
    private IRBlock endBlock;

    public ForStmtNode(Location loc, StmtNode forInitStmt,
                       ExprNode condition, ExprNode stepExpr,
                       StmtNode loopBody) {
        super(loc);
        this.forInitStmt = forInitStmt;
        this.condition = condition;
        this.stepExpr = stepExpr;
        this.loopBody = loopBody;
    }

    public boolean hasInit() {
        return forInitStmt != null;
    }
    public StmtNode getForInitStmt() {
        return forInitStmt;
    }
    public boolean hasCondition() {
        return condition != null;
    }
    public ExprNode getCondition() {
        return condition;
    }
    public boolean hasStepExpr() {
        return stepExpr != null;
    }
    public ExprNode getStepExpr() {
        return stepExpr;
    }
    public boolean hasLoopBody() {
        return loopBody != null;
    }
    public StmtNode getLoopBody() {
        return loopBody;
    }

    public IRBlock getCondBlock() {
        return condBlock;
    }
    public void setCondBlock(IRBlock condBlock) {
        this.condBlock = condBlock;
    }
    public IRBlock getIncBlock() {
        return incBlock;
    }
    public void setIncBlock(IRBlock incBlock) {
        this.incBlock = incBlock;
    }
    public IRBlock getBodyBlock() {
        return bodyBlock;
    }
    public void setBodyBlock(IRBlock bodyBlock) {
        this.bodyBlock = bodyBlock;
    }
    public IRBlock getEndBlock() {
        return endBlock;
    }
    public void setEndBlock(IRBlock endBlock) {
        this.endBlock = endBlock;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<ForStmtNode>\n");
        if (hasInit())
            string.append("for initial statement =\n").append(forInitStmt.toString());
        if (hasCondition())
            string.append("condition =\n").append(condition.toString());
        if (hasStepExpr())
            string.append("step statement =\n").append(stepExpr.toString());
        string.append("body =\n").append(loopBody.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
