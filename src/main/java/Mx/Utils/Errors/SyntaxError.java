package Mx.Utils.Errors;

import Mx.Utils.Location;

public class SyntaxError extends error {
    public SyntaxError() {}
    public SyntaxError(String msg, Location loc) {
        super("Syntax Error: " + msg, loc);
    }
}
