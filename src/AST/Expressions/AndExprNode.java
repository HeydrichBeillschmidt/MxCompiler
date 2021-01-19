package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class AndExprNode extends ExprNode {
    private final ArrayList<EqualityExprNode> tests;
    private final int opNum;

    public AndExprNode(Location loc, String text,
                       ArrayList<EqualityExprNode> tests, int opNum) {
        super(loc, text);
        this.tests = tests;
        this.opNum = opNum;
    }

    public ArrayList<EqualityExprNode> getSubExpressions() {
        return tests;
    }
    public int getOpNum() {
        return opNum;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<AddExprNode>\n");
        string.append(tests.get(0).toString());
        for (int i = 1, it = tests.size(); i < it; ++i) {
            string.append("&\n");
            string.append(tests.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
