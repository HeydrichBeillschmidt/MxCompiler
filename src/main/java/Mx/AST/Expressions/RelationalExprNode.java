package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class RelationalExprNode extends ExprNode {
    private final ArrayList<ShiftExprNode> ariths;
    private final ArrayList<String> ops;

    public RelationalExprNode(Location loc, String text,
                              ArrayList<ShiftExprNode> ariths,
                              ArrayList<String> ops) {
        super(loc, text);
        this.ariths = ariths;
        this.ops = ops;
    }

    public ArrayList<ShiftExprNode> getSubExpressions() {
        return ariths;
    }
    public ArrayList<String> getOps() {
        return ops;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<RelationalExprNode>\n");
        string.append(ariths.get(0).toString());
        for (int i = 1, it = ariths.size(); i < it; ++i) {
            string.append(ops.get(i-1));
            string.append("\n");
            string.append(ariths.get(i).toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
