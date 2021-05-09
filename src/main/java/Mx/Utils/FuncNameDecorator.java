package Mx.Utils;

import Mx.AST.Expressions.ExprNode;
import Mx.AST.Specifiers.*;
import Mx.AST.VarNode;
import Mx.Entities.*;
import Mx.Types.ArrayType;
import Mx.Types.ClassType;
import Mx.Types.Type;

import java.util.ArrayList;

/*  decorate function name to uniquely identify it
 *  ---decoration rule---
 *  a decorated name begin with "_"
 *
 *  types have their identifier:
 *      int  - "H"
 *      bool - "_N"
 *      char - "D"
 *      void - "X"
 *      pointer - prefixed"PA"
 *      struct  - "U" + class name + "$$"
 *
 *  for a global function, the begin "_" is then followed by its function identifier,
 *      followed by "$$YG", indicating it's a __stdcall
 *  for a constructor, the begin "_" is then followed by "_0" + class name + "$$"
 *  for a method, the begin "_" is then followed by its function identifier with an extra "$" + class name
 *  for these member functions, the decorated name will append "$$QEA", indicating it's public
 *
 *  then the decorated name will append the return type identifier, "" for constructors
 *      with the list of identifiers of parameter list
 *  the decorated name ends with "XZ" if it has no parameter, or "$Z" otherwise.
 *
 *  ---tips---
 *  In regular C++ compiler the decoration should begin with "?",
 *  a constructor is decorated by "?0" rather than "_0",
 *  and all "$"s above should be "@"s.
 *
 *  However, those origin criterion just block in idiot llvm interpretation.
 */
public class FuncNameDecorator {
    private static String typeNameDecorationCast(TypeSpecifierNode type) {
        if (type instanceof BuiltInTypeSpecifierNode) {
            switch (type.getTypename()) {
                case "int":     return "H";
                case "string":  return "PAD";
                case "bool":    return "_N";
                default:/*void*/return "X";
            }
        }
        else if (type instanceof ClassSpecifierNode
                || type instanceof ClassTypeSpecifierNode) {
            return "U" + type.getTypename() + "$$";
        }
        else if (type instanceof ArrayTypeSpecifierNode) {
            return "PA" + typeNameDecorationCast(((ArrayTypeSpecifierNode)type).getBaseTypeSpecifier());
        }
        return "X";
    }
    private static String typeNameDecorationCast(Type type) {
        if (type instanceof ClassType) return "U" + type.getName() + "$$";
        else if (type instanceof ArrayType)
            return "PA" + typeNameDecorationCast(((ArrayType) type).getBaseType());
        switch (type.getName()) {
            case "int":     return "H";
            case "string":  return "PAD";
            case "bool":    return "_N";
            default:        return "X";
        }
    }
    public static String funcNameDecorationCast(DeclSpecifierSeqNode specifier,
                                                String pureName, ArrayList<?> parameters,
                                                FunctionEntity.FuncEntityType type,
                                                String className) {
        StringBuilder decoratedName = new StringBuilder("_");
        if (type == FunctionEntity.FuncEntityType.function) {
            decoratedName.append(pureName).append("$$YG").append(
                    typeNameDecorationCast(specifier.getTypeSpecifier()) );
        }
        else {
            if (type == FunctionEntity.FuncEntityType.constructor) {
                decoratedName.append("_0").append(className).append("$$QEA");
            }
            else { // method
                decoratedName.append(pureName).append("$").append(className).append(
                        "$$QEA").append(typeNameDecorationCast(specifier.getTypeSpecifier()) );
            }
        }
        if (parameters==null || parameters.size()==0) decoratedName.append("XZ");
        else {
            for (var p: parameters) {
                TypeSpecifierNode typeSpecifier = p instanceof VarNode
                        ? ((VarNode)p).getSpecifier().getTypeSpecifier()
                        : ((VarEntity)p).getSpecifier().getTypeSpecifier();
                decoratedName.append(typeNameDecorationCast(typeSpecifier));
            }
            decoratedName.append("$Z");
        }
        return decoratedName.toString();
    }

    public static String funcCallDecoratedEnd(ArrayList<ExprNode> parameters) {
        if (parameters==null || parameters.size()==0) return "XZ";
        else {
            StringBuilder decoratedName = new StringBuilder();
            for (var p: parameters) {
                decoratedName.append((typeNameDecorationCast(p.getType())));
            }
            decoratedName.append("$Z");
            return decoratedName.toString();
        }
    }
    public static boolean funcCallMatched(String decoratedName, String decoratedEnd) {
        return extractDecoratedEnd(decoratedName).equals(decoratedEnd);
    }

    public static String extractPureFuncName(String decoratedName) {
        int last;
        if (decoratedName.charAt(1) == '_') { // constructor
            last = decoratedName.indexOf("$$");
            return decoratedName.substring(3, last);
        }
        else {
            last = decoratedName.indexOf("$");
            return decoratedName.substring(1, last);
        }
    }
    private static String extractDecoratedEnd(String decoratedName) {
        int begin;
        if (decoratedName.charAt(1)=='_') { // constructor
            begin = decoratedName.indexOf("$$QEA") + 5;
        }
        else {
            int tmp = decoratedName.indexOf("$$YG");
            if (tmp > 0) { // function
                begin = tmp + 4;
            }
            else { // method
                begin = decoratedName.indexOf("$$QEA") + 5;
            }
            // discard return type decoration
            switch (decoratedName.charAt(begin)) {
                case 'P': // pointer; can repeat multiple times
                    while (decoratedName.charAt(begin)=='P') begin += 2;
                case 'U': { // struct
                    begin += decoratedName.substring(begin).indexOf("$$") + 2;
                    break;
                }
                case '_': { // bool
                    begin += 2;
                    break;
                }
                default: ++begin;
            }
        }
        return decoratedName.substring(begin);
    }
}
