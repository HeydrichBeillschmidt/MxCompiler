package Mx.AST.Initializers;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class BracedInitListNode extends EqualInitializerNode {
    private InitializerListNode list;

    public BracedInitListNode(Location loc, String text) {
        super(loc, text);
        list = null;
    }

    public InitializerListNode getInitList() {
        return list;
    }
    public void setInitList(InitializerListNode list) {
        this.list = list;
    }

    @Override
    public String toString() {
        return "<BracedInitListNode>\n" + "{"
                + (list==null ? "" : "initializer list:\n" + list.toString())
                + "}";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
