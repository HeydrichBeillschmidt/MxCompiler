package Mx.IR.Operand;

import Mx.IR.TypeSystem.IRType;

public class Parameter extends Operand {
    private String name;

    public Parameter(IRType type, String name) {
        super(type);
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getOriginalName() {
        if (name.contains("_")) {
            String[] ss = name.split("_");
            if (!Character.isDigit(ss[ss.length-1].charAt(0))) return name;
            StringBuilder ans = new StringBuilder(ss[0]);
            for (int i = 1; i < ss.length-1; ++i) {
                ans.append("_").append(ss[i]);
            }
            return ans.toString();
        }
        else return name;
    }

    @Override
    public boolean isConstant() {
        return false;
    }
    @Override
    public String toString() {
        return "%" + name;
    }
}
