package Mx.IR.TypeSystem;

import java.util.ArrayList;

public class StructureType extends IRType {
    private final String name;
    private final int size;
    private final ArrayList<IRType> memberTypes;

    public StructureType(String name, ArrayList<IRType> memberTypes) {
        super();
        this.name = name;
        this.memberTypes = memberTypes;
        int sz = 0;
        for (var m: memberTypes)
            sz += m.size();
        size = sz;
    }

    public String getName() {
        return name;
    }
    public ArrayList<IRType> getMemberTypes() {
        return memberTypes;
    }
    public void addMemberTypes(ArrayList<IRType> mbTypes) {
        memberTypes.addAll(mbTypes);
    }
    public int calcOffset(int indexOfMember) {
        int ans = 0;
        for (int i = 0; i < indexOfMember; ++i)
            ans += memberTypes.get(i).size();
        return ans;
    }
    public String structureToString() {
        StringBuilder string = new StringBuilder(this.toString());
        string.append(" = type { ");
        for (int i = 0, it = memberTypes.size(); i < it; ++i) {
            string.append(memberTypes.get(i).toString());
            if (i < it-1) string.append(", ");
        }
        string.append(" }");
        return string.toString();
    }

    @Override
    public int size() {
        return size;
    }
    @Override
    public String toString() {
        return "%" + name;
    }
}
