package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

public class ExprStmtNode extends StmtNode {
    private final ExprNode expr;

    public ExprStmtNode(Location loc, ExprNode expr) {
        super(loc);
        this.expr = expr;
    }

    public ExprNode getExpr() {
        return expr;
    }

    @Override
    public String toString() {
        return "<ExprStmtNode>\n"
                + expr.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
