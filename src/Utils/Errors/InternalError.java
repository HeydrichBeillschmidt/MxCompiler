package Mx.Utils.Errors;

import Mx.Utils.Location;

public class InternalError extends error {
    public InternalError() {}
    public InternalError(String msg, Location loc) {
        super("Internal Error: " + msg, loc);
    }
}
