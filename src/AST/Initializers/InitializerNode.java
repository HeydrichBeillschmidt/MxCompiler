package Mx.AST.Initializers;

import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

abstract public class InitializerNode extends ExprNode {
    public InitializerNode(Location loc, String text) {
        super(loc, text);
    }
}
