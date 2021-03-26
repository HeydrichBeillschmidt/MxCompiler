package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class MemberExprNode extends ExprNode {
    private final ExprNode objectName;
    private final String memberName;

    public MemberExprNode(Location loc, String text,
                          ExprNode objectName, String memberName) {
        super(loc, text);
        this.objectName = objectName;
        this.memberName = memberName;
    }

    public ExprNode getObjectName() {
        return objectName;
    }
    public String getMemberName() {
        return memberName;
    }

    @Override
    public String toString() {
        return "<MemberExprNode>\n"
                + "object name:\n" + objectName.toString()
                + "member name:\n" + memberName.toString() + "\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
