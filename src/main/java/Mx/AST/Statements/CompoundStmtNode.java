package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class CompoundStmtNode extends StmtNode {
    private ArrayList<StmtNode> stmts;

    public CompoundStmtNode(Location loc, ArrayList<StmtNode> stmts) {
        super(loc);
        this.stmts = stmts;
    }

    public ArrayList<StmtNode> getStatements() {
        return stmts;
    }
    public void addStatement(StmtNode stmt) {
        stmts.add(stmt);
    }
    public void addStatements(ArrayList<StmtNode> stmts) {
        this.stmts.addAll(stmts);
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<CompoundStmtNode\n>");
        string.append("statements:\n");
        for (var stmt: stmts)
            string.append(stmt.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
