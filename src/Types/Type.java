package Mx.Types;

public class Type {
    private final String nameOfType;

    public Type(String name) {
        this.nameOfType = name;
    }

    public String getName() {
        return nameOfType;
    }

    public static boolean canAssign(Type left, Type right) {
        if ((left instanceof ArrayType || left instanceof ClassType)
                && right instanceof  NullType)
            return true;
        return left.equals(right);
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
}
