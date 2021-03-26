package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

public class ContinueStmtNode extends StmtNode {
    private StmtNode dst;

    public ContinueStmtNode(Location loc) {
        super(loc);
    }

    public StmtNode getDst() {
        return dst;
    }
    public void setDst(StmtNode dst) {
        this.dst = dst;
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
