package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

public class ReturnStmtNode extends StmtNode {
    private final ExprNode returnValue;

    public ReturnStmtNode(Location location, ExprNode returnValue) {
        super(location);
        this.returnValue = returnValue;
    }
    public boolean hasReturnValue() {
        return returnValue != null;
    }
    public ExprNode getReturnValue() {
        return returnValue;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<ReturnStmtNode>\n");
        if (hasReturnValue())
            string.append("return value:\n").append(returnValue.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
