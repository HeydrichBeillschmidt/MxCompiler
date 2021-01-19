package Mx.AST.Specifiers;

import Mx.Utils.Location;

abstract public class SimpleTypeSpecifierNode extends DeclSpecifierNode{
    public SimpleTypeSpecifierNode(Location loc, String typename) {
        super(loc);
        this.setTypeName(typename);
    }
}
