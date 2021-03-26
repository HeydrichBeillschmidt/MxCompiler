package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class ShiftExprNode extends ExprNode {
    private final ArrayList<AdditiveExprNode> terms;
    private final ArrayList<String> ops;

    public ShiftExprNode(Location loc, String text,
                         ArrayList<AdditiveExprNode> terms,
                         ArrayList<String> ops) {
        super(loc, text);
        this.terms = terms;
        this.ops = ops;
    }

    public ArrayList<AdditiveExprNode> getSubExpressions() {
        return terms;
    }
    public ArrayList<String> getOps() {
        return ops;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<ShiftExprNode>\n");
        string.append(terms.get(0).toString());
        for (int i = 1, it = terms.size(); i < it; ++i) {
            string.append(ops.get(i-1));
            string.append("\n");
            string.append(terms.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
