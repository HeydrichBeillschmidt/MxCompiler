package Mx.Utils;

import Mx.AST.Expressions.ExprNode;
import Mx.AST.Specifiers.*;
import Mx.AST.VarNode;
import Mx.Entities.*;
import Mx.Types.ArrayType;
import Mx.Types.ClassType;
import Mx.Types.Type;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
            return "U" + type.getTypename() + "@@";
        }
        else if (type instanceof ArrayTypeSpecifierNode) {
            return "PA" + typeNameDecorationCast(((ArrayTypeSpecifierNode)type).getBaseTypeSpecifier());
        }
        return "X";
    }
    private static String typeNameDecorationCast(Type type) {
        if (type instanceof ClassType) return "U" + type.getName() + "@@";
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
        StringBuilder decoratedName = new StringBuilder("?");
        if (type == FunctionEntity.FuncEntityType.function) {
            decoratedName.append(pureName).append("@@YG").append(
                    typeNameDecorationCast(specifier.getTypeSpecifier()) );
        }
        else {
            if (type == FunctionEntity.FuncEntityType.constructor) {
                decoratedName.append("?0").append(className).append("@@QEA");
            }
            else { // method
                decoratedName.append(pureName).append("@").append(className).append(
                        "@@QEA").append(typeNameDecorationCast(specifier.getTypeSpecifier()) );
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
            decoratedName.append("@Z");
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
            decoratedName.append("@Z");
            return decoratedName.toString();
        }
    }
    public static boolean funcCallMatched(String decoratedName, String decoratedEnd) {
        Pattern p = Pattern.compile(decoratedEnd);
        Matcher m = p.matcher(decoratedName);
        return m.find();
    }

    public static String extractPureFuncName(String decoratedName) {
        int last = decoratedName.indexOf("@@");
        if (decoratedName.charAt(1) == '?')
            return decoratedName.substring(3, last);
        else {
            last = decoratedName.indexOf("@");
            return decoratedName.substring(1, last);
        }
    }
}
