package Mx.IR.TypeSystem;

public class IntegerType extends IRType {
    private final int size;

    public IntegerType(int size) {
        super();
        this.size = size;
    }

    @Override
    public int size() {
        return Math.max(size, 8);
    }
    @Override
    public String toString() {
        return "i" + size;
    }
}
