package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class LogicalAndExprNode extends ExprNode {
    private final ArrayList<InclusiveOrExprNode> tests;
    private final int opNum;

    public LogicalAndExprNode(Location loc, String text,
                               ArrayList<InclusiveOrExprNode> tests, int opNum) {
        super(loc, text);
        this.tests = tests;
        this.opNum = opNum;
    }

    public ArrayList<InclusiveOrExprNode> getSubExpressions() {
        return tests;
    }
    public int getOpNum() {
        return opNum;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<LogicalAndExprNode>\n");
        string.append(tests.get(0).toString());
        for (int i = 1, it = tests.size(); i < it; ++i) {
            string.append("&&\n");
            string.append(tests.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
