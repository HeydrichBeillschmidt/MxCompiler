package Mx.Entities;

import Mx.AST.Expressions.ExprNode;
import Mx.AST.Initializers.InitializerNode;
import Mx.AST.Specifiers.BuiltInTypeSpecifierNode;
import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.Utils.Location;

public class VarEntity extends Entity {
    public enum VarEntityType {
        global, local, parameter, member
    }
    private final DeclSpecifierSeqNode specifier;
    private final InitializerNode initializer;
    private final VarEntityType varEntityType;

    public VarEntity(String name, Location loc,
                     DeclSpecifierSeqNode specifier,
                     InitializerNode initializer,
                     VarEntityType varEntityType) {
        super(name, loc);
        this.specifier = specifier;
        this.initializer = initializer;
        this.varEntityType = varEntityType;
    }

    public static VarEntity builtinMethodParameter(String name, String specifier) {
        Location location = new Location(0,0);
        return new VarEntity(name, location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, specifier)),
                null, VarEntityType.parameter);
    }

    public DeclSpecifierSeqNode getSpecifier() {
        return specifier;
    }
    public ExprNode getInitializer() {
        return initializer;
    }
    public VarEntityType getEntityType() {
        return varEntityType;
    }
}
