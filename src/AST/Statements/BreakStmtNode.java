package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class BreakStmtNode extends StmtNode {
    public BreakStmtNode(Location loc) {
        super(loc);
    }

    @Override
    public String toString() {
        return "<BreakStmtNode>\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
