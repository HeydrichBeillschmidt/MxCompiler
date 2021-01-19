package Mx.AST.Initializers;

import Mx.Utils.Location;

abstract public class EqualInitializerNode extends InitializerNode {
    public EqualInitializerNode(Location loc, String text) {
        super(loc, text);
    }
}
