package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class ExprSeqNode extends ExprNode {
    private final ArrayList<ExprNode> tests;

    public ExprSeqNode(Location loc, String text,
                       ArrayList<ExprNode> tests) {
        super(loc, text);
        this.tests = tests;
    }

    public ArrayList<ExprNode> getSubExpressions() {
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
