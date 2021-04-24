package Mx.IR;

import Mx.AST.Expressions.ExprNode;
import Mx.IR.Operand.ConstString;
import Mx.IR.Operand.GlobalVariable;
import Mx.IR.Operand.Parameter;
import Mx.IR.TypeSystem.*;
import Mx.IR.TypeSystem.BoolType;
import Mx.IR.TypeSystem.VoidType;
import Mx.Types.*;
import Mx.Types.ArrayType;
import Mx.Utils.FuncNameDecorator;
import Mx.Utils.TypeTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class IRModule {
    private final Map<String, Function> externalFunctions;
    private final Map<String, Function> functions;
    private final Map<String, GlobalVariable> globalVariables;
    private final Map<String, GlobalVariable> constStrings;
    private final Map<String, StructureType> structures;
    public static IRType stringT = new PointerType(new IntegerType(1)),
            charT = new IntegerType(1), voidT = new VoidType(),
            int32T = new IntegerType(4), boolT = new BoolType();

    public IRModule(TypeTable astTypeTable) {
        this.externalFunctions = new HashMap<>();
        this.functions = new HashMap<>();
        this.globalVariables = new HashMap<>();
        this.constStrings = new HashMap<>();
        this.structures = new HashMap<>();

        // dump AST types
        for (var ty: astTypeTable.getTypeTable().values()) {
            if (ty instanceof ClassType) {
                ArrayList<IRType> memberTypes = new ArrayList<>();
                String name = "class." + ty.getName();
                addStructure(new StructureType(name, memberTypes));
            }
        }
        for (var ty: astTypeTable.getTypeTable().values()) {
            if (ty instanceof ClassType) {
                ArrayList<IRType> memberTypes = new ArrayList<>();
                for (var mb: ((ClassType)ty).getMembers()) {
                    Type mbType = astTypeTable.getType(mb.getSpecifier());
                    IRType tmp = getIRType(mbType);
                    memberTypes.add(tmp);
                }
                String name = "class." + ty.getName();
                structures.remove(name);
                addStructure(new StructureType(name, memberTypes));
            }
        }

        // Add external functions
        //  - the last step of the constructor
        IRType retType;
        ArrayList<Parameter> parameters;
        Function func;
        // void print(string str);
        retType = new VoidType();
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str"));
        func = new Function(this, retType, "_print$$YGXPAD$Z", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // void println(string str);
        retType = new VoidType();
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str"));
        func = new Function(this, retType, "_println$$YGXPAD$Z", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // void printInt(int n);
        retType = new VoidType();
        parameters = new ArrayList<>();
        parameters.add(new Parameter(int32T, "n"));
        func = new Function(this, retType, "_printInt$$YGXH$Z", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // void printlnInt(int n);
        retType = new VoidType();
        parameters = new ArrayList<>();
        parameters.add(new Parameter(int32T, "n"));
        func = new Function(this, retType, "_printlnInt$$YGXH$Z", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // string getString();
        retType = stringT;
        parameters = new ArrayList<>();
        func = new Function(this, retType, "_getString$$YGPADXZ", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // int getInt();
        retType = int32T;
        parameters = new ArrayList<>();
        func = new Function(this, retType, "_getInt$$YGHXZ", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // string toString(int i);
        retType = stringT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(int32T, "i"));
        func = new Function(this, retType, "_toString$$YGPADH$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // char* malloc(int size);
        retType = stringT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(int32T, "size"));
        func = new Function(this, retType, "_malloc$$YGPADH$Z", parameters);
        func.setSideEffect(true);
        externalFunctions.put(func.getName(), func);
        // int string.length(string str);
        retType = int32T;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str"));
        func = new Function(this, retType, "_length$string$$QEAHXZ", parameters);
        externalFunctions.put(func.getName(), func);
        // string string.substring(string str, int left, int right);
        retType = stringT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str"));
        parameters.add(new Parameter(int32T, "left"));
        parameters.add(new Parameter(int32T, "right"));
        func = new Function(this, retType, "_substring$string$$QEAPADHH$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // int string.parseInt(string str);
        retType = int32T;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str"));
        func = new Function(this, retType, "_parseInt$string$$QEAHXZ", parameters);
        externalFunctions.put(func.getName(), func);
        // int string.ord(string str, int pos);
        retType = int32T;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str"));
        parameters.add(new Parameter(int32T, "pos"));
        func = new Function(this, retType, "_ord$string$$QEAHH$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // string strcat(string str1, string str2);
        retType = stringT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcat$$YGPADPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // bool strcmp_eq(string str1, string str2);
        retType = boolT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcmp_eq$$YG_NPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // bool strcmp_neq(string str1, string str2);
        retType = boolT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcmp_neq$$YG_NPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // bool strcmp_lt(string str1, string str2);
        retType = boolT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcmp_lt$$YG_NPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // bool strcmp_gt(string str1, string str2);
        retType = boolT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcmp_gt$$YG_NPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // bool strcmp_le(string str1, string str2);
        retType = boolT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcmp_le$$YG_NPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
        // bool strcmp_ge(string str1, string str2);
        retType = boolT;
        parameters = new ArrayList<>();
        parameters.add(new Parameter(stringT, "str1"));
        parameters.add(new Parameter(stringT, "str2"));
        func = new Function(this, retType, "_strcmp_ge$$YG_NPADPAD$Z", parameters);
        externalFunctions.put(func.getName(), func);
    }

    public Map<String, Function> getExternalFunctions() {
        return externalFunctions;
    }
    public Function getExternalFunction(String pureName) {
        for (var efn: externalFunctions.keySet()) {
            if (FuncNameDecorator.extractPureFuncName(efn).equals(pureName))
                return externalFunctions.get(efn);
        }
        return null;
    }
    public Map<String, Function> getFunctions() {
        return functions;
    }
    public Function getFunction(String decoratedName) {
        if (functions.containsKey(decoratedName))
            return functions.get(decoratedName);
        return externalFunctions.get(decoratedName);
    }
    public boolean hasNoFunction(String decoratedName) {
        return !functions.containsKey(decoratedName);
    }
    public void addFunction(Function func) {
        functions.put(func.getName(), func);
    }
    public Map<String, GlobalVariable> getGlobalVariables() {
        return globalVariables;
    }
    public void addGlobalVariable(GlobalVariable gVar) {
        globalVariables.put(gVar.getName(), gVar);
    }
    public Map<String, StructureType> getStructures() {
        return structures;
    }
    public StructureType getStructure(String name) {
        return structures.get(name);
    }
    public void addStructure(StructureType struct) {
        structures.put(struct.getName(), struct);
    }
    public Map<String, GlobalVariable> getConstStrings() {
        return constStrings;
    }
    public GlobalVariable addConstString(String value, String name) {
        value = value.replace("\\\\", "\\");
        value = value.replace("\\n", "\n");
        value = value.replace("\\t", "\t");
        value = value.replace("\\\"", "\"");
        value = value + "\0";
        if (constStrings.containsKey(value)) {
            return constStrings.get(value);
        }
        else {
            GlobalVariable gv = new GlobalVariable(new PointerType(
                    new Mx.IR.TypeSystem.ArrayType(value.length(), charT)),
                    name, new ConstString(value));
            globalVariables.put(name, gv);
            constStrings.put(value, gv);
            return gv;
        }
    }
    public GlobalVariable getConstStrByValue(String value) {
        value = value.replace("\\\\", "\\");
        value = value.replace("\\n", "\n");
        value = value.replace("\\t", "\t");
        value = value.replace("\\\"", "\"");
        value = value + "\0";
        return constStrings.getOrDefault(value, null);
    }
    public IRType getIRType(Type ty) {
        if (ty instanceof IntType) return int32T;
        else if (ty instanceof Mx.Types.BoolType) return boolT;
        else if (ty instanceof StringType) return stringT;
        else if (ty instanceof Mx.Types.VoidType) return voidT;
        else if (ty instanceof Mx.Types.ArrayType) {
            IRType tmp = getIRType(((ArrayType)ty).getBaseType());
            for (int i = 0, it = ((ArrayType) ty).getDimension();
                 i < it; ++i) {
                tmp = new PointerType(tmp);
            }
            return tmp;
        }
        else if (ty instanceof ClassType) {
            String name = "class." + ty.getName();
            return new PointerType(structures.get(name));
        }
        else return new VoidType();
    }

    public void accept(IRVisitor visitor) {
        visitor.visit(this);
    }
}
