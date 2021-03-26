package Mx.AST.Specifiers;

import Mx.AST.ASTNode;
import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.HashSet;
import java.util.Set;

public class DeclSpecifierSeqNode extends ASTNode {
    private final TypeSpecifierNode typeSpecifier;
    public Set<NonTypeSpecifierNode> declSpecifiers;

    public DeclSpecifierSeqNode(Location loc, TypeSpecifierNode typeSpecifier,
                                Set<NonTypeSpecifierNode> declSpecifiers) {
        super(loc);
        this.typeSpecifier = typeSpecifier;
        this.declSpecifiers = declSpecifiers;
    }
    public DeclSpecifierSeqNode(Location loc, TypeSpecifierNode typeSpecifier) {
        super(loc);
        this.typeSpecifier = typeSpecifier;
        declSpecifiers = new HashSet<>();
    }

    public String getTypename() {
        return typeSpecifier.getTypename();
    }
    public TypeSpecifierNode getTypeSpecifier() {
        return typeSpecifier;
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<DeclSpecifierSeq>\n");
        string.append("TypeSpecifier:\n").append(typeSpecifier.toString());
        string.append("DeclSpecifiers:\n");
        for (var unit: declSpecifiers)
            string.append(unit.toString());
        return string.toString();
    }
}
