package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ConditionalExprNode extends ExprNode {
    private final LogicalOrExprNode logic;

    public ConditionalExprNode(Location loc, String text,
                               LogicalOrExprNode logic) {
        super(loc, text);
        this.logic = logic;
    }

    public LogicalOrExprNode getConditionExpr() {
        return logic;
    }

    @Override
    public String toString() {
        return "<ConditionalExprNode>\n"
                + "condition = " + logic.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
