package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ThisExprNode extends ExprNode {
    public ThisExprNode(Location loc, String text) {
        super(loc, text);
    }

    @Override
    public String toString() {
        return "<ThisExprNode>\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
