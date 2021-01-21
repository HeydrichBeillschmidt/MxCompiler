package Mx.Types;

public class MethodType extends Type {
    private Type objectType;

    public MethodType(String name, Type objectType) {
        super(name);
        this.objectType = objectType;
    }

    public Type getObjectType() {
        return objectType;
    }
}
