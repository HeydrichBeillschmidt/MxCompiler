package Mx.AST.Initializers;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class InitializerListNode extends EqualInitializerNode {
    private final ArrayList<InitializerClauseNode> clauses;

    public InitializerListNode(Location loc, String text,
                               ArrayList<InitializerClauseNode> clauses) {
        super(loc, text);
        this.clauses = clauses;
    }

    public ArrayList<InitializerClauseNode> getInitClauses() {
        return clauses;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<InitializerListNode>\n");
        string.append("InitializerNodes:\n");
        for (var clause: clauses)
            string.append(clause.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
