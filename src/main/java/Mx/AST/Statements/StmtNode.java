package Mx.AST.Statements;

import Mx.AST.ASTNode;
import Mx.Utils.Location;

abstract public class StmtNode extends ASTNode {
    public StmtNode(Location loc) {
        super(loc);
    }
}
