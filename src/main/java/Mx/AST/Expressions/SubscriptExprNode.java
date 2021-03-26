package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class SubscriptExprNode extends ExprNode {
    private final ExprNode name;
    private final ExprNode index;
    private final int dimension;

    public SubscriptExprNode(Location loc, String text,
                             ExprNode name, ExprNode index) {
        super(loc, text);
        this.name = name;
        if (name instanceof SubscriptExprNode)
            dimension = ((SubscriptExprNode) name).dimension + 1;
        else
            dimension = 1;
        this.index = index;
    }

    public ExprNode getName() {
        return name;
    }
    public ExprNode getIndex() {
        return index;
    }
    public int getDimension() {
        return dimension;
    }

    @Override
    public String toString() {
        return "<SubscriptExprNode>\n"
                + "name:\n" + name.toString()
                + "index:\n" + index.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
