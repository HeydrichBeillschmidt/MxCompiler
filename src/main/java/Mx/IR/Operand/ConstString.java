package Mx.IR.Operand;

import Mx.IR.TypeSystem.ArrayType;
import Mx.IR.TypeSystem.IntegerType;
import Mx.IR.TypeSystem.PointerType;

public class ConstString extends Constant {
    private final String name;
    private final String value;

    public ConstString(String name, String value) {
        super(new PointerType(new ArrayType(value.length(),
                new IntegerType(8)) ) );
        this.value = value;
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        String text = value;
        text = text.replace("\\", "\\5C");
        text = text.replace("\n", "\\0A");
        text = text.replace("\0", "\\00");
        text = text.replace("\t", "\\09");
        text = text.replace("\"", "\\22");

        return "[" + value.length() + " x i8] c\"" + text + "\"";
    }
    @Override
    public boolean equals(Object obj) {
        return obj instanceof ConstString
                && value.equals(((ConstString)obj).value);
    }
}
