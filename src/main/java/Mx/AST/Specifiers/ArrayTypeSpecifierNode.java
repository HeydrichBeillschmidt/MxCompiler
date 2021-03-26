package Mx.AST.Specifiers;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ArrayTypeSpecifierNode extends SimpleTypeSpecifierNode {
    private final SimpleTypeSpecifierNode baseTypeSpecifier;
    private final int dimension;

    public ArrayTypeSpecifierNode(Location loc, SimpleTypeSpecifierNode preSpecifier) {
        super(loc, preSpecifier.getTypename());
        if (preSpecifier instanceof ArrayTypeSpecifierNode) {
            baseTypeSpecifier = ((ArrayTypeSpecifierNode) preSpecifier).baseTypeSpecifier;
            dimension = ((ArrayTypeSpecifierNode) preSpecifier).dimension + 1;
        }
        else {
            baseTypeSpecifier = preSpecifier;
            dimension = 1;
        }
    }

    public SimpleTypeSpecifierNode getBaseTypeSpecifier() {
        return baseTypeSpecifier;
    }
    public int getDimension() {
        return dimension;
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        return "<ArrayTypeSpecifierNode>\n"
                + "baseTypeSpecifier = " + baseTypeSpecifier.toString()
                + "dimension = " + dimension + "\n";
    }
}
