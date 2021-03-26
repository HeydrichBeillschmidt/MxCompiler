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
        builtinMethod = new FunctionEntity("?length@string@@QEAHXZ", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);

        // string substring(int left, int right);
        builtinMethodParameters = new ArrayList<>();
        builtinMethodParameters.add(VarEntity.builtinMethodParameter("left", "int"));
        builtinMethodParameters.add(VarEntity.builtinMethodParameter("right","int"));
        builtinMethod = new FunctionEntity("?substring@string@@QEAPADHH@Z", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "string")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);

        // int parseInt();
        builtinMethodParameters = new ArrayList<>();
        builtinMethod = new FunctionEntity("?parseInt@string@@QEAHXZ", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);

        // int ord(int pos);
        builtinMethodParameters = new ArrayList<>();
        builtinMethodParameters.add(VarEntity.builtinMethodParameter("pos", "int"));
        builtinMethod = new FunctionEntity("?ord@string@@QEAHH@Z", location,
                new DeclSpecifierSeqNode(location, new BuiltInTypeSpecifierNode(location, "int")),
                builtinMethodParameters, null, FunctionEntity.FuncEntityType.method);
        builtinMethods.add(builtinMethod);
    }

    public ArrayList<FunctionEntity> getBuiltinMethods() {
        return builtinMethods;
    }
    public boolean hasMethod(String name) {
        for (var method: builtinMethods)
            if (method.getPureName().equals(name))
                return true;
        return false;
    }
    public FunctionEntity getMethod(String name) {
        for (var method: builtinMethods)
            if (method.getPureName().equals(name))
                return method;
        return null;
    }
}
