package Mx.AST.Initializers;

import Mx.AST.ASTVisitor;
import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

import java.util.Objects;

public class InitializerClauseNode extends EqualInitializerNode {
    private final ExprNode expr;
    private final BracedInitListNode braced;
    private final boolean isAssignment;

    public InitializerClauseNode(Location loc, String text,
                                 ExprNode expr, boolean isAssignment) {
        super(loc, text);
        this.isAssignment = isAssignment;
        if (isAssignment) {
            this.expr = expr;
            this.braced = null;
        }
        else {
            this.expr = null;
            this.braced = (BracedInitListNode) expr;
        }
    }

    public boolean isAtomic() {
        return isAssignment;
    }
    public ExprNode getAssignmentExpr() {
        return expr;
    }
    public BracedInitListNode getBraced(){
        return braced;
    }

    @Override
    public String toString() {
        return "<InitializerClauseNode>\n"
                + (isAssignment?
                ("assignmentExpr:\n" + Objects.requireNonNull(expr).toString()) :
                ("bracedInitList:\n" + Objects.requireNonNull(braced).toString()));
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
