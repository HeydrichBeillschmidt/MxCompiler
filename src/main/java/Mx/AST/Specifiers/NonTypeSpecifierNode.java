package Mx.AST.Specifiers;

import Mx.AST.ASTNode;
import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class NonTypeSpecifierNode extends ASTNode {
    private final String specifier;

    public NonTypeSpecifierNode(Location loc, String specifier) {
        super(loc);
        this.specifier = specifier;
    }

    public String getSpecifier() {
        return specifier;
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        return "<NonTypeSpecifierNode>\n"
                + "specifier = " + specifier + "\n";
    }
}
