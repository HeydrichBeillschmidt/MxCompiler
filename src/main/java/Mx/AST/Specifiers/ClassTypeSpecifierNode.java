package Mx.AST.Specifiers;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ClassTypeSpecifierNode extends SimpleTypeSpecifierNode {
    public ClassTypeSpecifierNode(Location loc, String typename) {
        super(loc, typename);
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        return "<ClassNameTypeNode>\n" + "typename = " + getTypename() + "\n";
    }
}
