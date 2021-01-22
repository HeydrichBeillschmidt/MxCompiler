package Mx.AST.Specifiers;

import Mx.AST.ASTNode;
import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

abstract public class TypeSpecifierNode extends ASTNode {
    private String typename;
    private boolean typed;

    public TypeSpecifierNode(Location loc) {
        super(loc);
        typename = "";
        typed = false;
    }

    public String getTypename() {
        return typename;
    }
    protected void setTypeName(String typename) {
        this.typename = typename;
        typed = true;
    }
    public boolean isTypeSpecifier() {
        return typed;
    }
}
