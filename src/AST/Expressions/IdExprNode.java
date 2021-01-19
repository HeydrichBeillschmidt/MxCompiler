package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class IdExprNode extends ExprNode {
    private final String identifier;

    public IdExprNode(Location loc, String text, String identifier) {
        super(loc, text);
        this.identifier = identifier;
    }

    public String getIdentifier() {
        return identifier;
    }

    @Override
    public String toString() {
        return "<IdExprNode>\n"
                + "identifier = " + getIdentifier() + "\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
