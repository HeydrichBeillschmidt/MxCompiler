package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class MultiplicativeExprNode extends ExprNode {
    private final ArrayList<ExprNode> factors;
    private final ArrayList<String> ops;

    public MultiplicativeExprNode(Location loc, String text,
                                  ArrayList<ExprNode> factors,
                                  ArrayList<String> ops) {
        super(loc, text);
        this.factors = factors;
        this.ops = ops;
    }

    public ArrayList<ExprNode> getSubExpressions() {
        return factors;
    }
    public ArrayList<String> getOps() {
        return ops;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<MultiplicativeExprNode>\n");
        string.append(factors.get(0).toString());
        for (int i = 1, it = factors.size(); i < it; ++i) {
            string.append(ops.get(i-1));
            string.append("\n");
            string.append(factors.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
