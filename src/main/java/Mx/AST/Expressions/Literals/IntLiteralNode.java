package Mx.AST.Expressions.Literals;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class IntLiteralNode extends LiteralNode {
    private final int value;

    public IntLiteralNode(Location loc, String text, int value) {
        super(loc, text);
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "<IntLiteralNode>\n"
                + "value = " + value + "\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
