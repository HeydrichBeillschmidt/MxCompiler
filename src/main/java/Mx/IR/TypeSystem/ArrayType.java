package Mx.IR.TypeSystem;

public class ArrayType extends IRType {
    private final int len;
    private final IRType type;

    public ArrayType(int len, IRType type) {
        super();
        this.len = len;
        this.type = type;
    }

    public int getLen() {
        return len;
    }
    public IRType getType() {
        return type;
    }

    @Override
    public int size() {
        return type.size() * len;
    }
    @Override
    public String toString() {
        return "[" + len + " x " + type.toString() + "]";
    }
}
