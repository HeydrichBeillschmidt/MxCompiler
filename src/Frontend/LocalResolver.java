package Mx.Frontend;

import Mx.AST.*;
import Mx.Utils.Errors.*;
import Mx.Utils.ExceptionHandler;
import Mx.Utils.Scope;
import java.util.ArrayList;

public class LocalResolver {
    private ArrayList<Scope> scopeStack;
    private ExceptionHandler exceptionHandler;

    public LocalResolver(ExceptionHandler h) {
        this.scopeStack = new ArrayList<>();
        this.exceptionHandler = h;
    }

    public void resolve(ASTNode ast) throws SemanticError {
        Scope toplevel = new Scope(null);
        scopeStack.add(toplevel);
    }
}
