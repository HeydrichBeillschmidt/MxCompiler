package Mx.AST;

import Mx.AST.Initializers.InitializerNode;
import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.Entities.VarEntity;
import Mx.Utils.Location;

public class VarNode extends DeclarationNode {
    private DeclSpecifierSeqNode specifier;
    private String name;
    private InitializerNode initializer;

    public VarNode(Location loc,
                   DeclSpecifierSeqNode specifier,
                   String name,
                   InitializerNode initializer) {
        super(loc);
        this.specifier = specifier;
        this.name = name;
        this.initializer = initializer;
    }

    public DeclSpecifierSeqNode getSpecifier() {
        return specifier;
    }
    public void setSpecifier(DeclSpecifierSeqNode specifier) {
        this.specifier = specifier;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public boolean hasInitializer() {
        return initializer!=null;
    }
    public InitializerNode getInitializer() {
        return initializer;
    }
    public void setInitializer(InitializerNode initializer) {
        this.initializer = initializer;
    }
    public VarEntity generateEntity(VarEntity.VarEntityType entityType) {
        return new VarEntity(name, getLocation(),
                specifier, initializer, entityType);
    }

    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
    @Override
    public String toString() {
        return "<SimpleDeclarationNode>\n"
                + "specifier =\n" + specifier.toString()
                + "name = " + name + "\n"
                + "initializer =\n" + initializer.toString();
    }
}
