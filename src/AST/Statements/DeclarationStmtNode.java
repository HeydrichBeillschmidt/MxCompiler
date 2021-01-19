package Mx.AST.Statements;

import Mx.AST.ASTVisitor;
import Mx.AST.VarNode;
import Mx.AST.VarSeqNode;
import Mx.Utils.Location;

import java.util.ArrayList;

public class DeclarationStmtNode extends StmtNode {
    ArrayList<VarNode> varNodes;

    public DeclarationStmtNode(Location loc, VarSeqNode varSeq) {
        super(loc);
        this.varNodes = varSeq.getVarNodes();
    }

    public ArrayList<VarNode> getVarNodes() {
        return varNodes;
    }
    public void addVarNode(VarNode node) {
        varNodes.add(node);
    }
    public void addVarNodes(ArrayList<VarNode> nodes) {
        varNodes.addAll(nodes);
    }
    public void addVarNodes(VarSeqNode seq) {
        varNodes.addAll(seq.getVarNodes());
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<DeclarationStmtNode>\n");
        string.append("variable nodes:\n");
        for (var node: varNodes)
            string.append(node.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
