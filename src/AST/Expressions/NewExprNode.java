package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.Utils.Location;

import java.util.ArrayList;

public class NewExprNode extends ExprNode {
    private final DeclSpecifierSeqNode specifier;
    private final ArrayList<ExprNode> indexes;

    public NewExprNode(Location loc, String text,
                       DeclSpecifierSeqNode specifier,
                       ArrayList<ExprNode> indexes) {
        super(loc, text);
        this.specifier = specifier;
        this.indexes = indexes;
    }

    public DeclSpecifierSeqNode getSpecifier() {
        return specifier;
    }
    public ArrayList<ExprNode> getIndexes() {
        return indexes;
    }
    public int getDimension() {
        if (indexes!=null)
            return indexes.size();
        return 0;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<NewExprNode>\n");
        string.append("base type = ").append(specifier.getTypename());
        string.append("\ndimension = ").append(getDimension());
        string.append("\nindexes of dimensions:\n");
        for (var index: indexes)
            string.append(index.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
