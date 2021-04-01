package Mx.ASM;

import Mx.ASM.Operand.GlobalVar;

import java.util.HashMap;
import java.util.Map;

public class ASMModule {
    private final Map<String, ASMFunction> externalFunctions;
    private final Map<String, ASMFunction> functions;
    private final Map<String, GlobalVar> globalVars;
    private final Map<GlobalVar, String> strValues;

    public ASMModule(){
        externalFunctions = new HashMap<>();
        functions = new HashMap<>();
        globalVars = new HashMap<>();
        strValues = new HashMap<>();
    }

    public Map<String, ASMFunction> getExternalFunctions() {
        return externalFunctions;
    }
    public Map<String, ASMFunction> getFunctions() {
        return functions;
    }
    public ASMFunction getFunction(String name) {
        if (functions.containsKey(name)) return functions.get(name);
        return externalFunctions.get(name);
    }
    public Map<String, GlobalVar> getGlobalVars() {
        return globalVars;
    }
    public Map<GlobalVar, String> getStrValues() {
        return strValues;
    }

    public void accept(ASMVisitor visitor) {
        visitor.visit(this);
    }
}
