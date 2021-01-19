package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class PrefixExprNode extends ExprNode {
    private final String op;
    private final ExprNode expr;

    public PrefixExprNode(Location loc, String text, String op, ExprNode expr) {
        super(loc, text);
        this.op = op;
        this.expr = expr;
    }

    public String getOperator() {
        return op;
    }
    public ExprNode getSubExpr() {
        return expr;
    }

    @Override
    public String toString() {
        return "<PrefixExprNode>\n"
                + "operator = " + op + "\n"
                + "subexpression = \n" + expr.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
