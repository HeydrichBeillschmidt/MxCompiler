package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class LogicalOrExprNode extends ExprNode {
    private final ArrayList<LogicalAndExprNode> tests;
    private final int opNum;

    public LogicalOrExprNode(Location loc, String text,
                              ArrayList<LogicalAndExprNode> tests, int opNum) {
        super(loc, text);
        this.tests = tests;
        this.opNum = opNum;
    }

    public ArrayList<LogicalAndExprNode> getSubExpressions() {
        return tests;
    }
    public int getOpNum() {
        return opNum;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<LogicalOrExprNode>\n");
        string.append(tests.get(0).toString());
        for (int i = 1, it = tests.size(); i < it; ++i) {
            string.append("||\n");
            string.append(tests.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
