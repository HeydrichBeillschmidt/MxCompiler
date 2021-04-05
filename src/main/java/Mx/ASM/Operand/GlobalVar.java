package Mx.ASM.Operand;

import Mx.ASM.ASMVisitor;

public class GlobalVar extends VirtualReg {
    private boolean isInt;
    private int intVal;
    private boolean isBool;
    private int boolVal;
    private boolean isString;
    private String strVal;

    public GlobalVar(String name, int size) {
        super(size, name);
        isInt = false;
        intVal = 0;
        isBool = false;
        boolVal = 0;
        isString = false;
        strVal = null;
    }

    public boolean isInt() {
        return isInt;
    }
    public void setIntVal(int val) {
        isInt = true;
        intVal = val;
    }
    public boolean isBool() {
        return isBool;
    }
    public void setBoolVal(int val) {
        isBool = true;
        boolVal = val;
    }
    public boolean isString() {
        return isString;
    }
    public void setStrVal(String val) {
        isString = true;
        strVal = val;
    }

    @Override
    public String emitCode() {
        if (isInt) {
            return "\t.word\t" + Integer.toUnsignedLong(intVal)
                    + " ".repeat(24 - Integer.toUnsignedString(intVal).length())
                    + "# " + intVal;
        }
        else if (isBool) {
            return "\t.byte\t" + boolVal + " ".repeat(24 - 1) + "# " + (boolVal==1);
        }
        else if (isString) {
            String str = strVal.replace("\\", "\\\\");
            str = str.replace("\n", "\\n");
            str = str.replace("\0", "");
            str = str.replace("\t", "\\t");
            str = str.replace("\"", "\\\"");
            return "\t.asciz\t\"" + str + "\"";
        }
        return getName();
    }

    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
