package Mx.AST.Specifiers;

import Mx.AST.ASTNode;
import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class DeclSpecifierSeqNode extends ASTNode {
    private String typename;
    private DeclSpecifierNode typeSpecifier;
    private boolean restrictedSpecifierSeq;
    public ArrayList<DeclSpecifierNode> declSpecifiers;

    public DeclSpecifierSeqNode(Location loc, ArrayList<DeclSpecifierNode> declSpecifiers) {
        super(loc);
        restrictedSpecifierSeq = true;
        this.declSpecifiers = declSpecifiers;

        boolean typed = false;
        for (var decl: this.declSpecifiers) {
            if (decl.isTypeSpecifier()) {
                if (!typed) {
                    typeSpecifier = decl;
                    typename = decl.getTypename();
                    typed = true;
                }
            }
            else if (restrictedSpecifierSeq)
                restrictedSpecifierSeq = false;
        }
    }
    public DeclSpecifierSeqNode(Location loc, DeclSpecifierNode declSpecifier) {
        super(loc);
        restrictedSpecifierSeq = true;
        declSpecifiers = new ArrayList<>();
        declSpecifiers.add(declSpecifier);

        if (declSpecifier.isTypeSpecifier())
            typename = declSpecifier.getTypename();
        else {
            restrictedSpecifierSeq = false;
        }
    }

    public String getTypename() {
        return typename;
    }
    public DeclSpecifierNode getTypeSpecifier() {
        return typeSpecifier;
    }
    public boolean isTypeSpecifierSeq() {
        return restrictedSpecifierSeq;
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<DeclSpecifierSeq>\n");
        string.append("DeclSpecifiers:\n");
        for (var unit: declSpecifiers)
            string.append(unit.toString());
        return string.toString();
    }
}
