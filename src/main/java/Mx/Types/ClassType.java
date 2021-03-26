package Mx.Types;

import Mx.AST.Expressions.ExprNode;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.Utils.FuncNameDecorator;

import java.util.ArrayList;

public class ClassType extends Type {
    private final ArrayList<VarEntity> members;
    private final ArrayList<FunctionEntity> constructors;
    private final ArrayList<FunctionEntity> methods;

    public ClassType(String name,
                     ArrayList<VarEntity> members,
                     ArrayList<FunctionEntity> constructors,
                     ArrayList<FunctionEntity> methods) {
        super(name);
        this.members = members;
        this.constructors = constructors;
        this.methods = methods;
    }

    public ArrayList<VarEntity> getMembers() {
        return members;
    }
    public boolean hasMember(String name) {
        for (var member: members)
            if (member.getName().equals(name))
                return true;
        return false;
    }
    public VarEntity getMember(String name) {
        for (var member: members)
            if (member.getName().equals(name))
                return member;
        return null;
    }
    public boolean hasConstructor() {
        return constructors != null && constructors.size() != 0;
    }
    public FunctionEntity getDefaultConstructor() {
        String decoratedName = FuncNameDecorator.funcNameDecorationCast(
                null, getName(), null,
                FunctionEntity.FuncEntityType.constructor, getName() );
        for (var c: constructors) {
            if (c.getName().equals(decoratedName))
                return c;
        }
        return null;
    }
    public ArrayList<FunctionEntity> getConstructors() {
        return constructors;
    }
    public ArrayList<FunctionEntity> getMethods() {
        return methods;
    }
    public boolean hasMethod(String name) {
        for (var method: methods)
            if (method.getPureName().equals(name))
                return true;
        return false;
    }
    public FunctionEntity getMethod(String pureName, ArrayList<ExprNode> parameters) {
        String decoratedEnd = FuncNameDecorator.funcCallDecoratedEnd(parameters);
        for (var method: methods) {
            if (method.getPureName().equals(pureName)
                    && FuncNameDecorator.funcCallMatched(
                            method.getName(),decoratedEnd) )
                return method;
        }
        return null;
    }
}
