package Mx.AST.Expressions.Literals;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class NullLiteralNode extends LiteralNode {
    public NullLiteralNode(Location loc, String text) {
        super(loc, text);
    }

    @Override
    public String toString() {
        return "<NullLiteralNode>\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
