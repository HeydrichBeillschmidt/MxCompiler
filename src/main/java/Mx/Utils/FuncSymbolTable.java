package Mx.Utils;

import Mx.IR.IRBlock;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class FuncSymbolTable {
    private final Map<String, ArrayList<Object>> symbolTable;

    public FuncSymbolTable() {
        symbolTable = new HashMap<>();
    }

    public void put(Object obj) {
        String name;
        if (obj instanceof IRBlock) name = ((IRBlock)obj).getName();
        else if (obj instanceof Parameter) name = ((Parameter)obj).getName();
        else if (obj instanceof Register) name = ((Register)obj).getName();
        else throw new RuntimeException();
        String objLabel = "";
        if (symbolTable.containsKey(name)) {
            ArrayList<Object> arr = symbolTable.get(name);
            arr.add(obj);
            objLabel += arr.size();
        }
        else {
            ArrayList<Object> arr = new ArrayList<>();
            arr.add(obj);
            symbolTable.put(name, arr);
        }
        if (obj instanceof IRBlock) ((IRBlock)obj).setName(name+objLabel);
        else if (obj instanceof Parameter) ((Parameter)obj).setName(name+objLabel);
        else ((Register)obj).setName(name+objLabel);
    }
    public boolean contains(String name) {
        return symbolTable.containsKey(name);
    }
    public ArrayList<Object> get(String name) {
        return symbolTable.get(name);
    }
}
