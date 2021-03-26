package Mx.AST.Specifiers;

import Mx.AST.ASTVisitor;
import Mx.AST.FuncNode;
import Mx.AST.MemberSpecificationNode;
import Mx.AST.VarNode;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.Types.ClassType;
import Mx.Utils.Location;

import java.util.ArrayList;

public class ClassSpecifierNode extends TypeSpecifierNode {
    private final String className;
    private final ArrayList<VarNode> members;
    private final ArrayList<FuncNode> constructors;
    private final ArrayList<FuncNode> methods;

    public ClassSpecifierNode(Location loc, String className,
                              MemberSpecificationNode MS) {
        super(loc);
        this.className = className;
        this.setTypeName(className);
        if (MS!=null) {
            this.members = MS.getMembers();
            this.constructors = MS.getConstructors();
            this.methods = MS.getMethods();
        }
        else {
            this.members = null;
            this.constructors = null;
            this.methods = null;
        }
    }

    public String getClassName() {
        return className;
    }
    public ArrayList<VarNode> getMembers() {
        return members;
    }
    public void addMember(VarNode newMember) {
        members.add(newMember);
    }
    public void addMembers(ArrayList<VarNode> newMembers) {
        members.addAll(newMembers);
    }
    public ArrayList<FuncNode> getMethods() {
        return methods;
    }
    public void addMethod(FuncNode newMethod) {
        methods.add(newMethod);
    }
    public void addMethods(ArrayList<FuncNode> newMethods) {
        methods.addAll(newMethods);
    }
    public boolean hasConstructor() {
        return constructors != null && constructors.size() != 0;
    }
    public ArrayList<FuncNode> getConstructors() {
        return constructors;
    }
    public ClassType generateClassType() {
        ArrayList<VarEntity> memberList = new ArrayList<>();
        ArrayList<FunctionEntity> constructorList = new ArrayList<>();
        ArrayList<FunctionEntity> methodList = new ArrayList<>();
        if (members!=null) {
            for (var varNode: members) {
                memberList.add(varNode.generateEntity(VarEntity.VarEntityType.member));
            }
        }
        if (constructors!=null) {
            for (var funcNode: constructors) {
                constructorList.add(funcNode.generateEntity(
                        FunctionEntity.FuncEntityType.constructor, className) );
            }
        }
        if (methods!=null) {
            for (var funcNode: methods) {
                methodList.add(funcNode.generateEntity(
                        FunctionEntity.FuncEntityType.method, className));
            }
        }
        return new ClassType(className, memberList, constructorList, methodList);
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<ClassSpecifierNode>\n");
        string.append("class name = ").append(className);
        string.append("\nmembers:\n");
        if (members!=null) {
            for (var mem: members)
                string.append(mem.toString());
        }
        if (hasConstructor()) {
            string.append("constructors:\n");
            for (var cstr : constructors)
                string.append(cstr.toString());
        }
        string.append("methods:\n");
        if (methods!=null) {
            for (var method: methods)
                string.append(method.toString());
        }
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
