package Mx.Utils;

import Mx.ASM.ASMBlock;
import Mx.ASM.Operand.VirtualReg;
import Mx.IR.IRBlock;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;

import java.util.*;

public class FuncSymbolTable {
    private final Map<String, ArrayList<Object>> symbolTable;

    public FuncSymbolTable() {
        symbolTable = new HashMap<>();
    }

    public void putIR(Object obj) {
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
    public void putASMUnique(Object obj) {
        String name;
        if (obj instanceof VirtualReg) name = ((VirtualReg)obj).getName();
        else if (obj instanceof ASMBlock) name = ((ASMBlock)obj).getName();
        else throw new RuntimeException();
        assert !symbolTable.containsKey(name);

        ArrayList<Object> arr = new ArrayList<>();
        arr.add(obj);
        symbolTable.put(name, arr);
    }
    public void putASMMultiple(Object obj) {
        String name;
        if (obj instanceof VirtualReg) name = ((VirtualReg)obj).getName();
        else throw new RuntimeException();

        ArrayList<Object> arr = new ArrayList<>();
        arr.add(obj);
        if (symbolTable.containsKey(name)) {
            int cnt = 1;
            while (symbolTable.containsKey(name + cnt)) ++cnt;
            name += cnt;
            ((VirtualReg) obj).setName(name);
        }
        symbolTable.put(name, arr);
    }
    public boolean contains(String name) {
        return symbolTable.containsKey(name);
    }
    public ArrayList<Object> get(String name) {
        return symbolTable.get(name);
    }
}
