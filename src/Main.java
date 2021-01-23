package Mx;

import Mx.AST.ASTRoot;
import Mx.Frontend.*;
import Mx.Generated.MxLexer;
import Mx.Generated.MxParser;
import Mx.Utils.Errors.*;
import Mx.Utils.ExceptionHandler;
import Mx.Utils.MxErrorListener;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import java.io.FileInputStream;
import java.io.InputStream;

public class Main {
    public static void main(String[] args) {
        ExceptionHandler exceptionHandler = new ExceptionHandler();

        String filename = "test.mx";
        InputStream inputStream;
        CharStream input;
        try {
            inputStream = new FileInputStream(filename);
            input = CharStreams.fromStream(inputStream);
        }
        catch (Exception e) {
            exceptionHandler.error("Cannot open file \"" + filename + "\".");
            exceptionHandler.print();
            throw new RuntimeException();
        }

        MxLexer lexer;
        CommonTokenStream tokens;
        MxParser parser;
        ParseTree parseTreeRoot;
        lexer = new MxLexer(input);
        lexer.removeErrorListeners();
        lexer.addErrorListener(new MxErrorListener(exceptionHandler));
        tokens = new CommonTokenStream(lexer);
        parser = new MxParser(tokens);
        parser.removeErrorListeners();
        parser.addErrorListener(new MxErrorListener(exceptionHandler));
        parseTreeRoot = parser.translationUnit();
        if (exceptionHandler.hasError()) {
            exceptionHandler.print();
            throw new RuntimeException();
        }

        ASTBuilder astBuilder = new ASTBuilder(exceptionHandler);
        ASTRoot AST = (ASTRoot) astBuilder.visit(parseTreeRoot);

        try {
            TypeChecker typeChecker = new TypeChecker(exceptionHandler);
            AST.accept(typeChecker);
            SemanticChecker semanticChecker = new SemanticChecker(typeChecker.getTypeTable(),
                    exceptionHandler);
            AST.accept(semanticChecker);
        }
        catch (error err) {
            if (exceptionHandler.hasError()) {
                exceptionHandler.print();
                throw new RuntimeException();
            }
        }
        if (exceptionHandler.hasError()) {
            exceptionHandler.print();
            throw new RuntimeException();
        }
    }
}
