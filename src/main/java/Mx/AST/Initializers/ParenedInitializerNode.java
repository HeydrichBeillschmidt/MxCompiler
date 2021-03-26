package Mx.AST.Initializers;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ParenedInitializerNode extends InitializerNode {
    private final InitializerListNode list;

    public ParenedInitializerNode(Location loc, String text,
                                  InitializerListNode list) {
        super(loc, text);
        this.list = list;
    }

    public InitializerListNode getInitList() {
        return list;
    }

    @Override
    public String toString() {
        return "<ParenedInitializerNode>\n" + "("
                + "initializer list:\n" + list.toString()
                + ")";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
