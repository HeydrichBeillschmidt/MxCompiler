package Mx.AST.Specifiers;

import Mx.AST.ASTNode;
import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

abstract public class DeclSpecifierNode extends ASTNode {
    private String typename;
    private boolean typed;

    public DeclSpecifierNode(Location loc) {
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
