package Mx.AST;

import Mx.Utils.Location;

import java.util.ArrayList;

public class VarSeqNode extends DeclarationNode {
    private final ArrayList<VarNode> varNodes;

    public VarSeqNode(Location loc, ArrayList<VarNode> varNodes) {
        super(loc);
        this.varNodes = varNodes;
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

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<VarSeqNode>\n");
        string.append("VarNodes:\n");
        for (var node: varNodes)
            string.append(node.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
