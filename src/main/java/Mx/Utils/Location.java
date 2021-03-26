package Mx.Utils;

import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.antlr.v4.runtime.ParserRuleContext;

public class Location {
    private final int row;
    private final int col;

    public Location(int row, int col) {
        this.row = row;
        this.col = col;
    }
    public Location(Token token) {
        this.row = token.getLine();
        this.col = token.getCharPositionInLine();
    }
    public Location(TerminalNode terminal) {
        this(terminal.getSymbol());
    }
    public Location(ParserRuleContext ctx) {
        this(ctx.getStart());
    }

    public int getRow() {return row;}
    public int getCol() {return col;}

    public String toString() {
        return "(" + row + "," + col + ")";
    }
}