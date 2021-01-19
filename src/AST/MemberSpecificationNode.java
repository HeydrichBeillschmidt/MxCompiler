package Mx.AST;

import Mx.Utils.Location;

import java.util.ArrayList;

public class MemberSpecificationNode extends DeclarationNode {
    private final ArrayList<VarNode> members;
    private ArrayList<FuncNode> constructors;
    private final ArrayList<FuncNode> methods;

    public MemberSpecificationNode(Location loc,
                                   ArrayList<VarNode> members,
                                   ArrayList<FuncNode> constructors,
                                   ArrayList<FuncNode> methods) {
        super(loc);
        this.members = members;
        this.constructors = constructors;
        this.methods = methods;
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
        return constructors != null;
    }
    public ArrayList<FuncNode> getConstructors() {
        return constructors;
    }
    public ArrayList<String> correctConstructors(String className) {
        ArrayList<FuncNode> correctedConstructors = new ArrayList<>();
        ArrayList<String> unknownConstructorNames = new ArrayList<>();
        for (var cstr: constructors) {
            if (cstr.getName().equals(className))
                correctedConstructors.add(cstr);
            else
                unknownConstructorNames.add(cstr.getName());
        }
        constructors = correctedConstructors;
        return unknownConstructorNames;
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<MemberSpecificationNode>\n");
        string.append("\nmembers:\n");
        for (var mem: members)
            string.append(mem.toString());
        if (hasConstructor()) {
            string.append("constructors:\n");
            for (var cstr : constructors)
                string.append(cstr.toString());
        }
        string.append("methods:\n");
        for (var method: methods)
            string.append(method.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
