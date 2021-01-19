package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class InclusiveOrExprNode extends ExprNode {
    private final ArrayList<ExclusiveOrExprNode> tests;
    private final int opNum;

    public InclusiveOrExprNode(Location loc, String text,
                               ArrayList<ExclusiveOrExprNode> tests, int opNum) {
        super(loc, text);
        this.tests = tests;
        this.opNum = opNum;
    }

    public ArrayList<ExclusiveOrExprNode> getSubExpressions() {
        return tests;
    }
    public int getOpNum() {
        return opNum;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<InclusiveOrExprNode>\n");
        string.append(tests.get(0).toString());
        for (int i = 1, it = tests.size(); i < it; ++i) {
            string.append("|\n");
            string.append(tests.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
