package Mx.AST.Expressions.Literals;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class StringLiteralNode extends LiteralNode {
    private final String value;

    public StringLiteralNode(Location loc, String text, String value) {
        super(loc, text);
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "<StringLiteralNode>\n"
                + "value = " + value + "\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
