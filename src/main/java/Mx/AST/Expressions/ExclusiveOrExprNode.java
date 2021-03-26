package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class ExclusiveOrExprNode extends ExprNode {
    private final ArrayList<AndExprNode> tests;
    private final int opNum;

    public ExclusiveOrExprNode(Location loc, String text,
                       ArrayList<AndExprNode> tests, int opNum) {
        super(loc, text);
        this.tests = tests;
        this.opNum = opNum;
    }

    public ArrayList<AndExprNode> getSubExpressions() {
        return tests;
    }
    public int getOpNum() {
        return opNum;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<ExclusiveOrExprNode>\n");
        string.append(tests.get(0).toString());
        for (int i = 1, it = tests.size(); i < it; ++i) {
            string.append("^\n");
            string.append(tests.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
