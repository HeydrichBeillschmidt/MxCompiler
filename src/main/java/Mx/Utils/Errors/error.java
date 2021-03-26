package Mx.Utils.Errors;

import Mx.Utils.Location;

abstract public class error extends RuntimeException {
    private Location loc;

    public error() {}
    public error(String msg, Location loc) {
        super(msg);
        this.loc = loc;
    }

    public String getMessage() {
        return super.getMessage() + " in " + loc.toString();
    }
}
