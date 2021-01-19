package Mx.AST.Expressions.Literals;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class BoolLiteralNode extends LiteralNode {
    private final boolean value;

    public BoolLiteralNode(Location loc, String text, boolean value) {
        super(loc, text);
        this.value = value;
    }

    public boolean getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "<BoolLiteralNode>\n"
                + "value = " + value + "\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
