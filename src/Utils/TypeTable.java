package Mx.Utils;

import Mx.AST.Specifiers.*;
import Mx.Types.*;
import Mx.Utils.Errors.SemanticError;

import java.util.HashMap;
import java.util.Map;

public class TypeTable {
    private final Map<String, Type> typeTable;

    public TypeTable() {
        typeTable = new HashMap<>();

        typeTable.put("int"     , new IntType());
        typeTable.put("bool"    , new BoolType());
        typeTable.put("string"  , new StringType());
        typeTable.put("void"    , new VoidType());
    }

    public Map<String, Type> getTypeTable() {
        return typeTable;
    }
    public boolean hasType(DeclSpecifierSeqNode specifier) {
        if (specifier==null) return false;
        return typeTable.containsKey(specifier.getTypename());
    }
    public boolean hasType(String typeName) {
        if (typeName==null) return false;
        return typeTable.containsKey(typeName);
    }
    public void defType(DeclSpecifierSeqNode specifier, Type type,
                    ExceptionHandler exceptionHandler) throws SemanticError {
        if (hasType(specifier)) {
            exceptionHandler.error("Duplicate definition of type \""
                + specifier.getTypename() + "\".");
            throw new SemanticError();
        }
        else
            typeTable.put(specifier.getTypename(), type);
    }
    public Type getType(DeclSpecifierSeqNode specifier,
                        ExceptionHandler exceptionHandler) throws SemanticError {
        if (specifier==null) {
            throw new SemanticError();
        }
        if (!hasType(specifier)) {
            exceptionHandler.error("Undefined type \""
                    + specifier.getTypename() + "\".");
            throw new SemanticError();
        }
        TypeSpecifierNode typeSpecifier = specifier.getTypeSpecifier();
        if (typeSpecifier instanceof ArrayTypeSpecifierNode) {
            String baseTypeName
                    = ((ArrayTypeSpecifierNode) typeSpecifier).getBaseTypeSpecifier().getTypename();
            int dimension = ((ArrayTypeSpecifierNode) typeSpecifier).getDimension();
            return new ArrayType(typeTable.get(baseTypeName), dimension);
        }
        else
            return typeTable.get(specifier.getTypename());
    }
    public Type getType(DeclSpecifierSeqNode specifier) {
        TypeSpecifierNode typeSpecifier = specifier.getTypeSpecifier();
        if (typeSpecifier instanceof ArrayTypeSpecifierNode) {
            String baseTypeName
                    = ((ArrayTypeSpecifierNode) typeSpecifier).getBaseTypeSpecifier().getTypename();
            int dimension = ((ArrayTypeSpecifierNode) typeSpecifier).getDimension();
            return new ArrayType(typeTable.get(baseTypeName), dimension);
        }
        else
            return typeTable.get(specifier.getTypename());
    }
    public Type getType(String typeName) {
        return typeTable.get(typeName);
    }

    public void checkTypes(ExceptionHandler h) {
        for (var type: typeTable.values())
            checkRecursiveDefinition(type, h);
    }
    private void checkRecursiveDefinition(Type t, ExceptionHandler h) {
        _checkRecursiveDefinition(t, new HashMap<>(), h);
    }
    static final private Object checking = new Object();
    static final private Object checked = new Object();
    private void _checkRecursiveDefinition(Type t, Map<Type, Object> marks,
                                           ExceptionHandler h) {
        if (marks.get(t)==checking) {
            h.error("recursive type definition: " + t.toString());
        }
        else if (marks.get(t)!=checked) {
            marks.put(t, checking);
            if (t instanceof ClassType) {
                for (var slot: ((ClassType) t).getMembers()) {
                    Type slotType = typeTable.get(slot.getSpecifier().getTypename());
                    _checkRecursiveDefinition(slotType, marks, h);
                }
            }
            else if (t instanceof ArrayType) {
                _checkRecursiveDefinition(((ArrayType) t).getBaseType(), marks, h);
            }
            marks.put(t, checked);
        }
    }
}
