package Mx.Utils.Errors;

import Mx.Utils.Location;

public class SemanticError extends error {
    public SemanticError() {}
    public SemanticError(String msg, Location loc) {
        super("Semantic Error: " + msg,loc);
    }
}
