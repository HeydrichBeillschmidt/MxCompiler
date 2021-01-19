package Mx.Types;

import Mx.AST.Specifiers.BuiltInTypeSpecifierNode;
import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.Utils.Location;

import java.util.ArrayList;

public class ArrayType extends Type {
    private final Type baseType;
    private final int dimension;
    private final ArrayList<FunctionEntity> builtinMethods;

    public ArrayType(Type baseType, int dimension) {
        super(baseType.getName());
        this.baseType = baseType;
        this.dimension = dimension;

        builtinMethods = new ArrayList<>();
        FunctionEntity builtinMethod;
        Location location = new Location(0,0);
        ArrayList<VarEntity> builtinMethodParameters;

        // int size();
        builtinMethodParameters = new ArrayList<>();
        builtinMethod = new FunctionEntity("size", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);
    }

    public Type getBaseType() {
        return baseType;
    }
    public int getDimension() {
        return dimension;
    }
    public ArrayList<FunctionEntity> getBuiltinMethods() {
        return builtinMethods;
    }
    public boolean hasMethod(String name) {
        for (var method: builtinMethods)
            if (method.getName().equals(name))
                return true;
        return false;
    }
    public FunctionEntity getMethod(String name) {
        for (var method: builtinMethods)
            if (method.getName().equals(name))
                return method;
        return null;
    }

    @Override
    public String toString() {
        return getName() + "[]".repeat(dimension);
    }
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof ArrayType)
            return baseType.equals(((ArrayType) obj).baseType)
                    && dimension==((ArrayType) obj).dimension;
        else return false;
    }
}
