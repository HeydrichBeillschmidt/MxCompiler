package Mx.IR.TypeSystem;

import Mx.IR.Operand.Operand;

import java.util.ArrayList;

public class FunctionType extends IRType {
    private final IRType returnType;
    private final ArrayList<IRType> parameterTypes;

    public FunctionType(IRType returnType, ArrayList<IRType> parameterTypes) {
        super();
        this.returnType = returnType;
        this.parameterTypes = parameterTypes;
    }

    public IRType getReturnType() {
        return returnType;
    }
    public ArrayList<IRType> getParameterTypes() {
        return parameterTypes;
    }

    @Override
    public int size() {
        return 0;
    }
    @Override
    public String toString() {
        StringBuilder string = new StringBuilder();
        string.append(returnType.toString()).append(" (");
        for (int i = 0, it = parameterTypes.size(); i < it; ++i) {
            string.append(parameterTypes.get(i).toString());
            if (i < it-1) string.append(", ");
        }
        string.append(")\n");
        return string.toString();
    }

    @Override
    public Operand getDefaultValue() {
        return null;
    }
}
