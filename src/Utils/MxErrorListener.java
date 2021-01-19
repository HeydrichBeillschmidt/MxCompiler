package Mx.Utils;

import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;

public class MxErrorListener extends BaseErrorListener {
    private final ExceptionHandler exceptionHandler;

    public MxErrorListener(ExceptionHandler e) {
        this.exceptionHandler = e;
    }

    @Override
    public void syntaxError(Recognizer<?, ?> recognizer,
                            Object offendingSymbol,
                            int line, int charPositionInLine,
                            String msg,
                            RecognitionException e) {
        exceptionHandler.error(msg, new Location(line, charPositionInLine));
    }
}
