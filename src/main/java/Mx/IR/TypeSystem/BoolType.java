package Mx.IR.TypeSystem;

public class BoolType extends IRType {
    public BoolType() {
        super();
    }

    @Override
    public int size() {
        return 1;
    }
    @Override
    public String toString() {
        return "i1";
    }
}
