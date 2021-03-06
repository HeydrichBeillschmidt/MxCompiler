package Mx.Utils;

import java.io.PrintStream;

public class ExceptionHandler {
    private final PrintStream printStream;
    private int errorCnt;

    public ExceptionHandler() {
        printStream = System.err;
        errorCnt = 0;
    }

    public void error(String msg) {
        ++errorCnt;
        printStream.println("Error: " + msg);
    }
    public void error(String msg, Location loc) {
        error("in " + loc.toString() + ": " + msg);
    }

    public boolean hasError() {
        return errorCnt > 0;
    }
    public void print() {
        printStream.println("Exception: "
                + errorCnt   + " error(s).");
    }
}
