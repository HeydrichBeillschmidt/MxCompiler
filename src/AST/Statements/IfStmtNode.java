package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.AST.Expressions.ExprNode;
import Mx.Utils.Location;

public class IfStmtNode extends StmtNode {
    private final ExprNode condition;
    private final StmtNode thenBody;
    private final StmtNode elseBody;

    public IfStmtNode(Location loc, ExprNode condition,
                      StmtNode thenBody, StmtNode elseBody) {
        super(loc);
        this.condition = condition;
        this.thenBody = thenBody;
        this.elseBody = elseBody;
    }

    public ExprNode getCondition() {
        return condition;
    }
    public boolean hasThenBody() {
        return thenBody != null;
    }
    public StmtNode getThenBody() {
        return thenBody;
    }
    public boolean hasElseBody() {
        return elseBody != null;
    }
    public StmtNode getElseBody() {
        return elseBody;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<IfStmtNode>\n");
        string.append("condition:\n").append(condition.toString());
        string.append("then body:\n").append(thenBody.toString());
        if (hasElseBody())
            string.append("else body:\n").append(elseBody.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
