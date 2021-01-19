package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

public class WhileStmtNode extends StmtNode {
    private final ExprNode condition;
    private final StmtNode loopBody;

    public WhileStmtNode(Location loc, ExprNode condition, StmtNode loopBody) {
        super(loc);
        this.condition = condition;
        this.loopBody = loopBody;
    }

    public ExprNode getCondition() {
        return condition;
    }
    public boolean hasLoopBody() {
        return loopBody != null;
    }
    public StmtNode getLoopBody() {
        return loopBody;
    }

    @Override
    public String toString() {
        return "<WhileStmtNode>\n"
                + "condition:\n" + condition.toString()
                + "loop body:\n" + loopBody.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
