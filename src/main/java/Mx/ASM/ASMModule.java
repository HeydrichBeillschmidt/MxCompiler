package Mx.ASM;

import java.util.HashMap;
import java.util.Map;

public class ASMModule {
    private final Map<String, ASMFunction> externalFunctions;
    private final Map<String, ASMFunction> functions;

    public ASMModule(){
        externalFunctions = new HashMap<>();
        functions = new HashMap<>();
    }

    public Map<String, ASMFunction> getExternalFunctions() {
        return externalFunctions;
    }
    public Map<String, ASMFunction> getFunctions() {
        return functions;
    }
}
