package Mx.Types;

import Mx.IR.Operand.Operand;

abstract public class Type {
    private final String nameOfType;

    public Type(String name) {
        this.nameOfType = name;
    }

    public String getName() {
        return nameOfType;
    }

    public static boolean canNotAssign(Type left, Type right) {
        if ((left instanceof ArrayType || left instanceof ClassType)
                && right instanceof  NullType)
            return false;
        return !left.equals(right);
    }

    public String toString() {
        return "Type{" +
                "nameOfType='" + nameOfType + '\'' +
                '}';
    }
    public boolean equals(Object obj) {
        if (obj instanceof Type)
            return toString().equals(obj.toString());
        else return false;
    }

    abstract public Operand getDefaultValue();
}
