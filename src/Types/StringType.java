package Mx.Types;

import Mx.AST.Specifiers.BuiltInTypeSpecifierNode;
import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.Utils.Location;

import java.util.ArrayList;

public class StringType extends Type {
    private final ArrayList<FunctionEntity> builtinMethods;

    public StringType() {
        super("string");

        builtinMethods = new ArrayList<>();
        FunctionEntity builtinMethod;
        Location location = new Location(0,0);
        ArrayList<VarEntity> builtinMethodParameters;

        // int length();
        builtinMethodParameters = new ArrayList<>();
        builtinMethod = new FunctionEntity("length", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);

        // string substring(int left, int right);
        builtinMethodParameters.clear();
        builtinMethodParameters.add(VarEntity.builtinMethodParameter("left", "int"));
        builtinMethodParameters.add(VarEntity.builtinMethodParameter("right","int"));
        builtinMethod = new FunctionEntity("substring", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "string")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);

        // int parseInt();
        builtinMethodParameters.clear();
        builtinMethod = new FunctionEntity("parseInt", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);

        // int ord(int pos);
        builtinMethodParameters.clear();
        builtinMethodParameters.add(VarEntity.builtinMethodParameter("pos", "int"));
        builtinMethod = new FunctionEntity("ord", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);
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
}
