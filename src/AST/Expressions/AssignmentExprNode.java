package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.AST.Initializers.InitializerClauseNode;
import Mx.Utils.Location;

public class AssignmentExprNode extends ExprNode {
    private final LogicalOrExprNode lhs;
    private final String op;
    private final InitializerClauseNode rhs;

    public AssignmentExprNode(Location loc, String text,
                              LogicalOrExprNode lhs, String op,
                              InitializerClauseNode rhs) {
        super(loc, text);
        this.lhs = lhs;
        this.op = op;
        this.rhs = rhs;
    }

    public LogicalOrExprNode getLhs() {
        return lhs;
    }
    public String getOperator() {
        return op;
    }
    public InitializerClauseNode getRhs() {
        return rhs;
    }

    @Override
    public String toString() {
        return "<AssignmentExprNode>"
                + "assign operator =\n" + op + "\n"
                + "lhs =\n" + lhs.toString()
                + "rhs =\n" + rhs.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
