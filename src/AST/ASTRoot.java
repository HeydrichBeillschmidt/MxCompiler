package Mx.AST;

import Mx.Utils.Location;

import java.util.ArrayList;

public class ASTRoot extends ASTNode {
    private final ArrayList<DeclarationNode> decls;

    public ASTRoot(Location location, ArrayList<DeclarationNode> decls) {
        super(location);
        this.decls = decls;
    }

    public ArrayList<DeclarationNode> getDeclarations() {
        return decls;
    }
    public void addDeclaration(DeclarationNode decl) {
        decls.add(decl);
    }
    public void addDeclarationSeq(ArrayList<DeclarationNode> decls) {
        this.decls.addAll(decls);
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<AST>\n");
        for (var unit: decls)
            string.append(unit.toString());
        return string.toString();
    }
}
