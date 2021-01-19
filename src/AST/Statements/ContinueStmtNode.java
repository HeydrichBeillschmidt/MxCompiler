package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ContinueStmtNode extends StmtNode {
    public ContinueStmtNode(Location loc) {
        super(loc);
    }

    @Override
    public String toString() {
        return "<ContinueStmtNode>\n";
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
