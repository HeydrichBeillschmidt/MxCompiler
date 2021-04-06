package Mx;

import Mx.ASM.ASMModule;
import Mx.AST.ASTRoot;
import Mx.Backend.*;
import Mx.Frontend.*;
import Mx.Generated.MxLexer;
import Mx.Generated.MxParser;
import Mx.IR.IRBuilder;
import Mx.IR.IRModule;
import Mx.IR.IRPrinter;
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
        boolean doCodegen = true, emitLL = false;

        if (args.length > 0) {
            for (String arg: args) {
                switch (arg) {
                    case "-semantic": doCodegen = false;break;
                    case "-emit-llvm":emitLL = true;break;
                    default:break;
                }
            }
        }

        ExceptionHandler exceptionHandler = new ExceptionHandler();

        //String filename = "testcases/codegen/e1.mx";
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

        TypeChecker typeChecker = new TypeChecker(exceptionHandler);
        SemanticChecker semanticChecker
                = new SemanticChecker(typeChecker.getTypeTable(), exceptionHandler);
        try {
            AST.accept(typeChecker);
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

        if (doCodegen) {
            IRBuilder irBuilder = new IRBuilder(semanticChecker.getGlobalScope(),
                    semanticChecker.getTypeTable(), exceptionHandler);
            try {
                AST.accept(irBuilder);
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

            if (emitLL) new IRPrinter("test.ll").run(irBuilder.getModule());

            IRModule irModule = irBuilder.getModule();

            InstructionSelector instructionSelector = new InstructionSelector();
            irModule.accept(instructionSelector);

            ASMModule asmModule = instructionSelector.getAsmModule();

            RegisterAllocator registerAllocator = new RegisterAllocator(asmModule);
            registerAllocator.run();

            CodeEmitter codeEmitter = new CodeEmitter("output.s");
            codeEmitter.run(asmModule);
        }
    }
}
