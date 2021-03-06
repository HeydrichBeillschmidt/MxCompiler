// Generated from C:/Days/Learning/SJTU/ACM/ComputerSystem/Compiler/MxCompiler/src/main/resources\MxLexer.g4 by ANTLR 4.9.1
package Mx.Generated;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class MxLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		IntegerLiteral=1, StringLiteral=2, BooleanLiteral=3, Bool=4, Break=5, 
		Class=6, Continue=7, Else=8, False_=9, For=10, If=11, Int=12, New=13, 
		Null=14, Return=15, String=16, This=17, True_=18, Void=19, While=20, LeftParen=21, 
		RightParen=22, LeftBracket=23, RightBracket=24, LeftBrace=25, RightBrace=26, 
		Dot=27, DotStar=28, Comma=29, Question=30, Colon=31, Doublecolon=32, Semi=33, 
		Arrow=34, ArrowStar=35, Ellipsis=36, PlusPlus=37, MinusMinus=38, Plus=39, 
		Minus=40, Star=41, Div=42, Mod=43, Caret=44, And=45, Or=46, AndAnd=47, 
		OrOr=48, Tilde=49, Not=50, LeftShift=51, RightShift=52, Less=53, Greater=54, 
		LessEqual=55, GreaterEqual=56, Equal=57, NotEqual=58, Assign=59, PlusAssign=60, 
		MinusAssign=61, StarAssign=62, DivAssign=63, ModAssign=64, AndAssign=65, 
		OrAssign=66, XorAssign=67, LeftShiftAssign=68, RightShiftAssign=69, Identifier=70, 
		WhiteSpace=71, NewLine=72, BlockComment=73, LineComment=74;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"IntegerLiteral", "StringLiteral", "BooleanLiteral", "Bool", "Break", 
			"Class", "Continue", "Else", "False_", "For", "If", "Int", "New", "Null", 
			"Return", "String", "This", "True_", "Void", "While", "LeftParen", "RightParen", 
			"LeftBracket", "RightBracket", "LeftBrace", "RightBrace", "Dot", "DotStar", 
			"Comma", "Question", "Colon", "Doublecolon", "Semi", "Arrow", "ArrowStar", 
			"Ellipsis", "PlusPlus", "MinusMinus", "Plus", "Minus", "Star", "Div", 
			"Mod", "Caret", "And", "Or", "AndAnd", "OrOr", "Tilde", "Not", "LeftShift", 
			"RightShift", "Less", "Greater", "LessEqual", "GreaterEqual", "Equal", 
			"NotEqual", "Assign", "PlusAssign", "MinusAssign", "StarAssign", "DivAssign", 
			"ModAssign", "AndAssign", "OrAssign", "XorAssign", "LeftShiftAssign", 
			"RightShiftAssign", "Identifier", "Letter", "IChar", "DecimalLiteral", 
			"Digit", "NonZeroDigit", "SChar", "SimpleEscapeSequence", "WhiteSpace", 
			"NewLine", "BlockComment", "LineComment"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, "'bool'", "'break'", "'class'", "'continue'", 
			"'else'", "'false'", "'for'", "'if'", "'int'", "'new'", "'null'", "'return'", 
			"'string'", "'this'", "'true'", "'void'", "'while'", "'('", "')'", "'['", 
			"']'", "'{'", "'}'", "'.'", "'.*'", "','", "'?'", "':'", "'::'", "';'", 
			"'->'", "'->*'", "'...'", "'++'", "'--'", "'+'", "'-'", "'*'", "'/'", 
			"'%'", "'^'", "'&'", "'|'", "'&&'", "'||'", "'~'", "'!'", "'<<'", "'>>'", 
			"'<'", "'>'", "'<='", "'>='", "'=='", "'!='", "'='", "'+='", "'-='", 
			"'*='", "'/='", "'%='", "'&='", "'|='", "'^='", "'<<='", "'>>='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "IntegerLiteral", "StringLiteral", "BooleanLiteral", "Bool", "Break", 
			"Class", "Continue", "Else", "False_", "For", "If", "Int", "New", "Null", 
			"Return", "String", "This", "True_", "Void", "While", "LeftParen", "RightParen", 
			"LeftBracket", "RightBracket", "LeftBrace", "RightBrace", "Dot", "DotStar", 
			"Comma", "Question", "Colon", "Doublecolon", "Semi", "Arrow", "ArrowStar", 
			"Ellipsis", "PlusPlus", "MinusMinus", "Plus", "Minus", "Star", "Div", 
			"Mod", "Caret", "And", "Or", "AndAnd", "OrOr", "Tilde", "Not", "LeftShift", 
			"RightShift", "Less", "Greater", "LessEqual", "GreaterEqual", "Equal", 
			"NotEqual", "Assign", "PlusAssign", "MinusAssign", "StarAssign", "DivAssign", 
			"ModAssign", "AndAssign", "OrAssign", "XorAssign", "LeftShiftAssign", 
			"RightShiftAssign", "Identifier", "WhiteSpace", "NewLine", "BlockComment", 
			"LineComment"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}


	public MxLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "MxLexer.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2L\u01f7\b\1\4\2\t"+
		"\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4"+
		",\t,\4-\t-\4.\t.\4/\t/\4\60\t\60\4\61\t\61\4\62\t\62\4\63\t\63\4\64\t"+
		"\64\4\65\t\65\4\66\t\66\4\67\t\67\48\t8\49\t9\4:\t:\4;\t;\4<\t<\4=\t="+
		"\4>\t>\4?\t?\4@\t@\4A\tA\4B\tB\4C\tC\4D\tD\4E\tE\4F\tF\4G\tG\4H\tH\4I"+
		"\tI\4J\tJ\4K\tK\4L\tL\4M\tM\4N\tN\4O\tO\4P\tP\4Q\tQ\4R\tR\3\2\3\2\5\2"+
		"\u00a8\n\2\3\3\3\3\7\3\u00ac\n\3\f\3\16\3\u00af\13\3\3\3\3\3\3\4\3\4\5"+
		"\4\u00b5\n\4\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\3\7\3\7\3\7\3"+
		"\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3\t\3\n"+
		"\3\n\3\n\3\n\3\n\3\n\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r\3\r\3"+
		"\16\3\16\3\16\3\16\3\17\3\17\3\17\3\17\3\17\3\20\3\20\3\20\3\20\3\20\3"+
		"\20\3\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3"+
		"\23\3\23\3\23\3\23\3\23\3\24\3\24\3\24\3\24\3\24\3\25\3\25\3\25\3\25\3"+
		"\25\3\25\3\26\3\26\3\27\3\27\3\30\3\30\3\31\3\31\3\32\3\32\3\33\3\33\3"+
		"\34\3\34\3\35\3\35\3\35\3\36\3\36\3\37\3\37\3 \3 \3!\3!\3!\3\"\3\"\3#"+
		"\3#\3#\3$\3$\3$\3$\3%\3%\3%\3%\3&\3&\3&\3\'\3\'\3\'\3(\3(\3)\3)\3*\3*"+
		"\3+\3+\3,\3,\3-\3-\3.\3.\3/\3/\3\60\3\60\3\60\3\61\3\61\3\61\3\62\3\62"+
		"\3\63\3\63\3\64\3\64\3\64\3\65\3\65\3\65\3\66\3\66\3\67\3\67\38\38\38"+
		"\39\39\39\3:\3:\3:\3;\3;\3;\3<\3<\3=\3=\3=\3>\3>\3>\3?\3?\3?\3@\3@\3@"+
		"\3A\3A\3A\3B\3B\3B\3C\3C\3C\3D\3D\3D\3E\3E\3E\3E\3F\3F\3F\3F\3G\3G\7G"+
		"\u0194\nG\fG\16G\u0197\13G\3H\3H\3I\3I\3I\5I\u019e\nI\3J\3J\7J\u01a2\n"+
		"J\fJ\16J\u01a5\13J\3K\3K\3L\3L\3M\3M\5M\u01ad\nM\3N\3N\3N\3N\3N\3N\3N"+
		"\3N\3N\3N\3N\3N\3N\3N\3N\3N\3N\3N\3N\3N\3N\5N\u01c4\nN\3N\5N\u01c7\nN"+
		"\3N\3N\3N\3N\5N\u01cd\nN\3O\6O\u01d0\nO\rO\16O\u01d1\3O\3O\3P\3P\5P\u01d8"+
		"\nP\3P\5P\u01db\nP\3P\3P\3Q\3Q\3Q\3Q\7Q\u01e3\nQ\fQ\16Q\u01e6\13Q\3Q\3"+
		"Q\3Q\3Q\3Q\3R\3R\3R\3R\7R\u01f1\nR\fR\16R\u01f4\13R\3R\3R\3\u01e4\2S\3"+
		"\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37"+
		"\21!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33\65\34\67\359\36;\37="+
		" ?!A\"C#E$G%I&K\'M(O)Q*S+U,W-Y.[/]\60_\61a\62c\63e\64g\65i\66k\67m8o9"+
		"q:s;u<w=y>{?}@\177A\u0081B\u0083C\u0085D\u0087E\u0089F\u008bG\u008dH\u008f"+
		"\2\u0091\2\u0093\2\u0095\2\u0097\2\u0099\2\u009b\2\u009dI\u009fJ\u00a1"+
		"K\u00a3L\3\2\t\4\2C\\c|\3\2aa\3\2\62;\3\2\63;\6\2\f\f\17\17$$^^\4\2\13"+
		"\13\"\"\4\2\f\f\17\17\2\u0209\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t"+
		"\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2"+
		"\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2"+
		"\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2"+
		"+\3\2\2\2\2-\3\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2"+
		"\2\67\3\2\2\2\29\3\2\2\2\2;\3\2\2\2\2=\3\2\2\2\2?\3\2\2\2\2A\3\2\2\2\2"+
		"C\3\2\2\2\2E\3\2\2\2\2G\3\2\2\2\2I\3\2\2\2\2K\3\2\2\2\2M\3\2\2\2\2O\3"+
		"\2\2\2\2Q\3\2\2\2\2S\3\2\2\2\2U\3\2\2\2\2W\3\2\2\2\2Y\3\2\2\2\2[\3\2\2"+
		"\2\2]\3\2\2\2\2_\3\2\2\2\2a\3\2\2\2\2c\3\2\2\2\2e\3\2\2\2\2g\3\2\2\2\2"+
		"i\3\2\2\2\2k\3\2\2\2\2m\3\2\2\2\2o\3\2\2\2\2q\3\2\2\2\2s\3\2\2\2\2u\3"+
		"\2\2\2\2w\3\2\2\2\2y\3\2\2\2\2{\3\2\2\2\2}\3\2\2\2\2\177\3\2\2\2\2\u0081"+
		"\3\2\2\2\2\u0083\3\2\2\2\2\u0085\3\2\2\2\2\u0087\3\2\2\2\2\u0089\3\2\2"+
		"\2\2\u008b\3\2\2\2\2\u008d\3\2\2\2\2\u009d\3\2\2\2\2\u009f\3\2\2\2\2\u00a1"+
		"\3\2\2\2\2\u00a3\3\2\2\2\3\u00a7\3\2\2\2\5\u00a9\3\2\2\2\7\u00b4\3\2\2"+
		"\2\t\u00b6\3\2\2\2\13\u00bb\3\2\2\2\r\u00c1\3\2\2\2\17\u00c7\3\2\2\2\21"+
		"\u00d0\3\2\2\2\23\u00d5\3\2\2\2\25\u00db\3\2\2\2\27\u00df\3\2\2\2\31\u00e2"+
		"\3\2\2\2\33\u00e6\3\2\2\2\35\u00ea\3\2\2\2\37\u00ef\3\2\2\2!\u00f6\3\2"+
		"\2\2#\u00fd\3\2\2\2%\u0102\3\2\2\2\'\u0107\3\2\2\2)\u010c\3\2\2\2+\u0112"+
		"\3\2\2\2-\u0114\3\2\2\2/\u0116\3\2\2\2\61\u0118\3\2\2\2\63\u011a\3\2\2"+
		"\2\65\u011c\3\2\2\2\67\u011e\3\2\2\29\u0120\3\2\2\2;\u0123\3\2\2\2=\u0125"+
		"\3\2\2\2?\u0127\3\2\2\2A\u0129\3\2\2\2C\u012c\3\2\2\2E\u012e\3\2\2\2G"+
		"\u0131\3\2\2\2I\u0135\3\2\2\2K\u0139\3\2\2\2M\u013c\3\2\2\2O\u013f\3\2"+
		"\2\2Q\u0141\3\2\2\2S\u0143\3\2\2\2U\u0145\3\2\2\2W\u0147\3\2\2\2Y\u0149"+
		"\3\2\2\2[\u014b\3\2\2\2]\u014d\3\2\2\2_\u014f\3\2\2\2a\u0152\3\2\2\2c"+
		"\u0155\3\2\2\2e\u0157\3\2\2\2g\u0159\3\2\2\2i\u015c\3\2\2\2k\u015f\3\2"+
		"\2\2m\u0161\3\2\2\2o\u0163\3\2\2\2q\u0166\3\2\2\2s\u0169\3\2\2\2u\u016c"+
		"\3\2\2\2w\u016f\3\2\2\2y\u0171\3\2\2\2{\u0174\3\2\2\2}\u0177\3\2\2\2\177"+
		"\u017a\3\2\2\2\u0081\u017d\3\2\2\2\u0083\u0180\3\2\2\2\u0085\u0183\3\2"+
		"\2\2\u0087\u0186\3\2\2\2\u0089\u0189\3\2\2\2\u008b\u018d\3\2\2\2\u008d"+
		"\u0191\3\2\2\2\u008f\u0198\3\2\2\2\u0091\u019d\3\2\2\2\u0093\u019f\3\2"+
		"\2\2\u0095\u01a6\3\2\2\2\u0097\u01a8\3\2\2\2\u0099\u01ac\3\2\2\2\u009b"+
		"\u01cc\3\2\2\2\u009d\u01cf\3\2\2\2\u009f\u01da\3\2\2\2\u00a1\u01de\3\2"+
		"\2\2\u00a3\u01ec\3\2\2\2\u00a5\u00a8\7\62\2\2\u00a6\u00a8\5\u0093J\2\u00a7"+
		"\u00a5\3\2\2\2\u00a7\u00a6\3\2\2\2\u00a8\4\3\2\2\2\u00a9\u00ad\7$\2\2"+
		"\u00aa\u00ac\5\u0099M\2\u00ab\u00aa\3\2\2\2\u00ac\u00af\3\2\2\2\u00ad"+
		"\u00ab\3\2\2\2\u00ad\u00ae\3\2\2\2\u00ae\u00b0\3\2\2\2\u00af\u00ad\3\2"+
		"\2\2\u00b0\u00b1\7$\2\2\u00b1\6\3\2\2\2\u00b2\u00b5\5%\23\2\u00b3\u00b5"+
		"\5\23\n\2\u00b4\u00b2\3\2\2\2\u00b4\u00b3\3\2\2\2\u00b5\b\3\2\2\2\u00b6"+
		"\u00b7\7d\2\2\u00b7\u00b8\7q\2\2\u00b8\u00b9\7q\2\2\u00b9\u00ba\7n\2\2"+
		"\u00ba\n\3\2\2\2\u00bb\u00bc\7d\2\2\u00bc\u00bd\7t\2\2\u00bd\u00be\7g"+
		"\2\2\u00be\u00bf\7c\2\2\u00bf\u00c0\7m\2\2\u00c0\f\3\2\2\2\u00c1\u00c2"+
		"\7e\2\2\u00c2\u00c3\7n\2\2\u00c3\u00c4\7c\2\2\u00c4\u00c5\7u\2\2\u00c5"+
		"\u00c6\7u\2\2\u00c6\16\3\2\2\2\u00c7\u00c8\7e\2\2\u00c8\u00c9\7q\2\2\u00c9"+
		"\u00ca\7p\2\2\u00ca\u00cb\7v\2\2\u00cb\u00cc\7k\2\2\u00cc\u00cd\7p\2\2"+
		"\u00cd\u00ce\7w\2\2\u00ce\u00cf\7g\2\2\u00cf\20\3\2\2\2\u00d0\u00d1\7"+
		"g\2\2\u00d1\u00d2\7n\2\2\u00d2\u00d3\7u\2\2\u00d3\u00d4\7g\2\2\u00d4\22"+
		"\3\2\2\2\u00d5\u00d6\7h\2\2\u00d6\u00d7\7c\2\2\u00d7\u00d8\7n\2\2\u00d8"+
		"\u00d9\7u\2\2\u00d9\u00da\7g\2\2\u00da\24\3\2\2\2\u00db\u00dc\7h\2\2\u00dc"+
		"\u00dd\7q\2\2\u00dd\u00de\7t\2\2\u00de\26\3\2\2\2\u00df\u00e0\7k\2\2\u00e0"+
		"\u00e1\7h\2\2\u00e1\30\3\2\2\2\u00e2\u00e3\7k\2\2\u00e3\u00e4\7p\2\2\u00e4"+
		"\u00e5\7v\2\2\u00e5\32\3\2\2\2\u00e6\u00e7\7p\2\2\u00e7\u00e8\7g\2\2\u00e8"+
		"\u00e9\7y\2\2\u00e9\34\3\2\2\2\u00ea\u00eb\7p\2\2\u00eb\u00ec\7w\2\2\u00ec"+
		"\u00ed\7n\2\2\u00ed\u00ee\7n\2\2\u00ee\36\3\2\2\2\u00ef\u00f0\7t\2\2\u00f0"+
		"\u00f1\7g\2\2\u00f1\u00f2\7v\2\2\u00f2\u00f3\7w\2\2\u00f3\u00f4\7t\2\2"+
		"\u00f4\u00f5\7p\2\2\u00f5 \3\2\2\2\u00f6\u00f7\7u\2\2\u00f7\u00f8\7v\2"+
		"\2\u00f8\u00f9\7t\2\2\u00f9\u00fa\7k\2\2\u00fa\u00fb\7p\2\2\u00fb\u00fc"+
		"\7i\2\2\u00fc\"\3\2\2\2\u00fd\u00fe\7v\2\2\u00fe\u00ff\7j\2\2\u00ff\u0100"+
		"\7k\2\2\u0100\u0101\7u\2\2\u0101$\3\2\2\2\u0102\u0103\7v\2\2\u0103\u0104"+
		"\7t\2\2\u0104\u0105\7w\2\2\u0105\u0106\7g\2\2\u0106&\3\2\2\2\u0107\u0108"+
		"\7x\2\2\u0108\u0109\7q\2\2\u0109\u010a\7k\2\2\u010a\u010b\7f\2\2\u010b"+
		"(\3\2\2\2\u010c\u010d\7y\2\2\u010d\u010e\7j\2\2\u010e\u010f\7k\2\2\u010f"+
		"\u0110\7n\2\2\u0110\u0111\7g\2\2\u0111*\3\2\2\2\u0112\u0113\7*\2\2\u0113"+
		",\3\2\2\2\u0114\u0115\7+\2\2\u0115.\3\2\2\2\u0116\u0117\7]\2\2\u0117\60"+
		"\3\2\2\2\u0118\u0119\7_\2\2\u0119\62\3\2\2\2\u011a\u011b\7}\2\2\u011b"+
		"\64\3\2\2\2\u011c\u011d\7\177\2\2\u011d\66\3\2\2\2\u011e\u011f\7\60\2"+
		"\2\u011f8\3\2\2\2\u0120\u0121\7\60\2\2\u0121\u0122\7,\2\2\u0122:\3\2\2"+
		"\2\u0123\u0124\7.\2\2\u0124<\3\2\2\2\u0125\u0126\7A\2\2\u0126>\3\2\2\2"+
		"\u0127\u0128\7<\2\2\u0128@\3\2\2\2\u0129\u012a\7<\2\2\u012a\u012b\7<\2"+
		"\2\u012bB\3\2\2\2\u012c\u012d\7=\2\2\u012dD\3\2\2\2\u012e\u012f\7/\2\2"+
		"\u012f\u0130\7@\2\2\u0130F\3\2\2\2\u0131\u0132\7/\2\2\u0132\u0133\7@\2"+
		"\2\u0133\u0134\7,\2\2\u0134H\3\2\2\2\u0135\u0136\7\60\2\2\u0136\u0137"+
		"\7\60\2\2\u0137\u0138\7\60\2\2\u0138J\3\2\2\2\u0139\u013a\7-\2\2\u013a"+
		"\u013b\7-\2\2\u013bL\3\2\2\2\u013c\u013d\7/\2\2\u013d\u013e\7/\2\2\u013e"+
		"N\3\2\2\2\u013f\u0140\7-\2\2\u0140P\3\2\2\2\u0141\u0142\7/\2\2\u0142R"+
		"\3\2\2\2\u0143\u0144\7,\2\2\u0144T\3\2\2\2\u0145\u0146\7\61\2\2\u0146"+
		"V\3\2\2\2\u0147\u0148\7\'\2\2\u0148X\3\2\2\2\u0149\u014a\7`\2\2\u014a"+
		"Z\3\2\2\2\u014b\u014c\7(\2\2\u014c\\\3\2\2\2\u014d\u014e\7~\2\2\u014e"+
		"^\3\2\2\2\u014f\u0150\7(\2\2\u0150\u0151\7(\2\2\u0151`\3\2\2\2\u0152\u0153"+
		"\7~\2\2\u0153\u0154\7~\2\2\u0154b\3\2\2\2\u0155\u0156\7\u0080\2\2\u0156"+
		"d\3\2\2\2\u0157\u0158\7#\2\2\u0158f\3\2\2\2\u0159\u015a\7>\2\2\u015a\u015b"+
		"\7>\2\2\u015bh\3\2\2\2\u015c\u015d\7@\2\2\u015d\u015e\7@\2\2\u015ej\3"+
		"\2\2\2\u015f\u0160\7>\2\2\u0160l\3\2\2\2\u0161\u0162\7@\2\2\u0162n\3\2"+
		"\2\2\u0163\u0164\7>\2\2\u0164\u0165\7?\2\2\u0165p\3\2\2\2\u0166\u0167"+
		"\7@\2\2\u0167\u0168\7?\2\2\u0168r\3\2\2\2\u0169\u016a\7?\2\2\u016a\u016b"+
		"\7?\2\2\u016bt\3\2\2\2\u016c\u016d\7#\2\2\u016d\u016e\7?\2\2\u016ev\3"+
		"\2\2\2\u016f\u0170\7?\2\2\u0170x\3\2\2\2\u0171\u0172\7-\2\2\u0172\u0173"+
		"\7?\2\2\u0173z\3\2\2\2\u0174\u0175\7/\2\2\u0175\u0176\7?\2\2\u0176|\3"+
		"\2\2\2\u0177\u0178\7,\2\2\u0178\u0179\7?\2\2\u0179~\3\2\2\2\u017a\u017b"+
		"\7\61\2\2\u017b\u017c\7?\2\2\u017c\u0080\3\2\2\2\u017d\u017e\7\'\2\2\u017e"+
		"\u017f\7?\2\2\u017f\u0082\3\2\2\2\u0180\u0181\7(\2\2\u0181\u0182\7?\2"+
		"\2\u0182\u0084\3\2\2\2\u0183\u0184\7~\2\2\u0184\u0185\7?\2\2\u0185\u0086"+
		"\3\2\2\2\u0186\u0187\7`\2\2\u0187\u0188\7?\2\2\u0188\u0088\3\2\2\2\u0189"+
		"\u018a\7>\2\2\u018a\u018b\7>\2\2\u018b\u018c\7?\2\2\u018c\u008a\3\2\2"+
		"\2\u018d\u018e\7@\2\2\u018e\u018f\7@\2\2\u018f\u0190\7?\2\2\u0190\u008c"+
		"\3\2\2\2\u0191\u0195\5\u008fH\2\u0192\u0194\5\u0091I\2\u0193\u0192\3\2"+
		"\2\2\u0194\u0197\3\2\2\2\u0195\u0193\3\2\2\2\u0195\u0196\3\2\2\2\u0196"+
		"\u008e\3\2\2\2\u0197\u0195\3\2\2\2\u0198\u0199\t\2\2\2\u0199\u0090\3\2"+
		"\2\2\u019a\u019e\t\3\2\2\u019b\u019e\5\u008fH\2\u019c\u019e\5\u0095K\2"+
		"\u019d\u019a\3\2\2\2\u019d\u019b\3\2\2\2\u019d\u019c\3\2\2\2\u019e\u0092"+
		"\3\2\2\2\u019f\u01a3\5\u0097L\2\u01a0\u01a2\5\u0095K\2\u01a1\u01a0\3\2"+
		"\2\2\u01a2\u01a5\3\2\2\2\u01a3\u01a1\3\2\2\2\u01a3\u01a4\3\2\2\2\u01a4"+
		"\u0094\3\2\2\2\u01a5\u01a3\3\2\2\2\u01a6\u01a7\t\4\2\2\u01a7\u0096\3\2"+
		"\2\2\u01a8\u01a9\t\5\2\2\u01a9\u0098\3\2\2\2\u01aa\u01ad\n\6\2\2\u01ab"+
		"\u01ad\5\u009bN\2\u01ac\u01aa\3\2\2\2\u01ac\u01ab\3\2\2\2\u01ad\u009a"+
		"\3\2\2\2\u01ae\u01af\7^\2\2\u01af\u01cd\7)\2\2\u01b0\u01b1\7^\2\2\u01b1"+
		"\u01cd\7$\2\2\u01b2\u01b3\7^\2\2\u01b3\u01cd\7A\2\2\u01b4\u01b5\7^\2\2"+
		"\u01b5\u01cd\7^\2\2\u01b6\u01b7\7^\2\2\u01b7\u01cd\7c\2\2\u01b8\u01b9"+
		"\7^\2\2\u01b9\u01cd\7d\2\2\u01ba\u01bb\7^\2\2\u01bb\u01cd\7h\2\2\u01bc"+
		"\u01bd\7^\2\2\u01bd\u01cd\7p\2\2\u01be\u01bf\7^\2\2\u01bf\u01cd\7t\2\2"+
		"\u01c0\u01c6\7^\2\2\u01c1\u01c3\7\17\2\2\u01c2\u01c4\7\f\2\2\u01c3\u01c2"+
		"\3\2\2\2\u01c3\u01c4\3\2\2\2\u01c4\u01c7\3\2\2\2\u01c5\u01c7\7\f\2\2\u01c6"+
		"\u01c1\3\2\2\2\u01c6\u01c5\3\2\2\2\u01c7\u01cd\3\2\2\2\u01c8\u01c9\7^"+
		"\2\2\u01c9\u01cd\7v\2\2\u01ca\u01cb\7^\2\2\u01cb\u01cd\7x\2\2\u01cc\u01ae"+
		"\3\2\2\2\u01cc\u01b0\3\2\2\2\u01cc\u01b2\3\2\2\2\u01cc\u01b4\3\2\2\2\u01cc"+
		"\u01b6\3\2\2\2\u01cc\u01b8\3\2\2\2\u01cc\u01ba\3\2\2\2\u01cc\u01bc\3\2"+
		"\2\2\u01cc\u01be\3\2\2\2\u01cc\u01c0\3\2\2\2\u01cc\u01c8\3\2\2\2\u01cc"+
		"\u01ca\3\2\2\2\u01cd\u009c\3\2\2\2\u01ce\u01d0\t\7\2\2\u01cf\u01ce\3\2"+
		"\2\2\u01d0\u01d1\3\2\2\2\u01d1\u01cf\3\2\2\2\u01d1\u01d2\3\2\2\2\u01d2"+
		"\u01d3\3\2\2\2\u01d3\u01d4\bO\2\2\u01d4\u009e\3\2\2\2\u01d5\u01d7\7\17"+
		"\2\2\u01d6\u01d8\7\f\2\2\u01d7\u01d6\3\2\2\2\u01d7\u01d8\3\2\2\2\u01d8"+
		"\u01db\3\2\2\2\u01d9\u01db\7\f\2\2\u01da\u01d5\3\2\2\2\u01da\u01d9\3\2"+
		"\2\2\u01db\u01dc\3\2\2\2\u01dc\u01dd\bP\2\2\u01dd\u00a0\3\2\2\2\u01de"+
		"\u01df\7\61\2\2\u01df\u01e0\7,\2\2\u01e0\u01e4\3\2\2\2\u01e1\u01e3\13"+
		"\2\2\2\u01e2\u01e1\3\2\2\2\u01e3\u01e6\3\2\2\2\u01e4\u01e5\3\2\2\2\u01e4"+
		"\u01e2\3\2\2\2\u01e5\u01e7\3\2\2\2\u01e6\u01e4\3\2\2\2\u01e7\u01e8\7,"+
		"\2\2\u01e8\u01e9\7\61\2\2\u01e9\u01ea\3\2\2\2\u01ea\u01eb\bQ\2\2\u01eb"+
		"\u00a2\3\2\2\2\u01ec\u01ed\7\61\2\2\u01ed\u01ee\7\61\2\2\u01ee\u01f2\3"+
		"\2\2\2\u01ef\u01f1\n\b\2\2\u01f0\u01ef\3\2\2\2\u01f1\u01f4\3\2\2\2\u01f2"+
		"\u01f0\3\2\2\2\u01f2\u01f3\3\2\2\2\u01f3\u01f5\3\2\2\2\u01f4\u01f2\3\2"+
		"\2\2\u01f5\u01f6\bR\2\2\u01f6\u00a4\3\2\2\2\22\2\u00a7\u00ad\u00b4\u0195"+
		"\u019d\u01a3\u01ac\u01c3\u01c6\u01cc\u01d1\u01d7\u01da\u01e4\u01f2\3\b"+
		"\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}