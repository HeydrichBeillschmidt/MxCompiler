package Mx.AST.Expressions.Literals;

import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

abstract public class LiteralNode extends ExprNode {
    public LiteralNode(Location loc, String text) {
        super(loc, text);
    }
}
