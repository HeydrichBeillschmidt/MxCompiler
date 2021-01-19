package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class ExprSeqNode extends ExprNode {
    private final ArrayList<AssignmentExprNode> tests;

    public ExprSeqNode(Location loc, String text,
                       ArrayList<AssignmentExprNode> tests) {
        super(loc, text);
        this.tests = tests;
    }

    public ArrayList<AssignmentExprNode> getSubExpressions() {
        return tests;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<ExprSeqNode>\n");
        for (var expr: tests)
            string.append(expr.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
