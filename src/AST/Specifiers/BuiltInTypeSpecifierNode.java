package Mx.AST.Specifiers;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class BuiltInTypeSpecifierNode extends SimpleTypeSpecifierNode {
    public BuiltInTypeSpecifierNode(Location loc, String typename) {
        super(loc, typename);
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        return "<BuiltInTypeNode>\n" + "typename = " + getTypename() + "\n";
    }
}
