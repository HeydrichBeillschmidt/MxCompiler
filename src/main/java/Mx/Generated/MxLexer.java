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
		Class=6, Continue=7, Else=8, False_=9, For=10, Friend=11, If=12, Int=13, 
		Long=14, New=15, Null=16, Return=17, String=18, This=19, True_=20, Typedef=21, 
		Void=22, While=23, LeftParen=24, RightParen=25, LeftBracket=26, RightBracket=27, 
		LeftBrace=28, RightBrace=29, Dot=30, DotStar=31, Comma=32, Question=33, 
		Colon=34, Doublecolon=35, Semi=36, Arrow=37, ArrowStar=38, Ellipsis=39, 
		PlusPlus=40, MinusMinus=41, Plus=42, Minus=43, Star=44, Div=45, Mod=46, 
		Caret=47, And=48, Or=49, AndAnd=50, OrOr=51, Tilde=52, Not=53, LeftShift=54, 
		RightShift=55, Less=56, Greater=57, LessEqual=58, GreaterEqual=59, Equal=60, 
		NotEqual=61, Assign=62, PlusAssign=63, MinusAssign=64, StarAssign=65, 
		DivAssign=66, ModAssign=67, AndAssign=68, OrAssign=69, XorAssign=70, LeftShiftAssign=71, 
		RightShiftAssign=72, Identifier=73, WhiteSpace=74, NewLine=75, BlockComment=76, 
		LineComment=77;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"IntegerLiteral", "StringLiteral", "BooleanLiteral", "Bool", "Break", 
			"Class", "Continue", "Else", "False_", "For", "Friend", "If", "Int", 
			"Long", "New", "Null", "Return", "String", "This", "True_", "Typedef", 
			"Void", "While", "LeftParen", "RightParen", "LeftBracket", "RightBracket", 
			"LeftBrace", "RightBrace", "Dot", "DotStar", "Comma", "Question", "Colon", 
			"Doublecolon", "Semi", "Arrow", "ArrowStar", "Ellipsis", "PlusPlus", 
			"MinusMinus", "Plus", "Minus", "Star", "Div", "Mod", "Caret", "And", 
			"Or", "AndAnd", "OrOr", "Tilde", "Not", "LeftShift", "RightShift", "Less", 
			"Greater", "LessEqual", "GreaterEqual", "Equal", "NotEqual", "Assign", 
			"PlusAssign", "MinusAssign", "StarAssign", "DivAssign", "ModAssign", 
			"AndAssign", "OrAssign", "XorAssign", "LeftShiftAssign", "RightShiftAssign", 
			"Identifier", "Letter", "IChar", "DecimalLiteral", "Digit", "NonZeroDigit", 
			"SChar", "SimpleEscapeSequence", "WhiteSpace", "NewLine", "BlockComment", 
			"LineComment"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, "'bool'", "'break'", "'class'", "'continue'", 
			"'else'", "'false'", "'for'", "'friend'", "'if'", "'int'", "'long'", 
			"'new'", "'null'", "'return'", "'string'", "'this'", "'true'", "'typedef'", 
			"'void'", "'while'", "'('", "')'", "'['", "']'", "'{'", "'}'", "'.'", 
			"'.*'", "','", "'?'", "':'", "'::'", "';'", "'->'", "'->*'", "'...'", 
			"'++'", "'--'", "'+'", "'-'", "'*'", "'/'", "'%'", "'^'", "'&'", "'|'", 
			"'&&'", "'||'", "'~'", "'!'", "'<<'", "'>>'", "'<'", "'>'", "'<='", "'>='", 
			"'=='", "'!='", "'='", "'+='", "'-='", "'*='", "'/='", "'%='", "'&='", 
			"'|='", "'^='", "'<<='", "'>>='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "IntegerLiteral", "StringLiteral", "BooleanLiteral", "Bool", "Break", 
			"Class", "Continue", "Else", "False_", "For", "Friend", "If", "Int", 
			"Long", "New", "Null", "Return", "String", "This", "True_", "Typedef", 
			"Void", "While", "LeftParen", "RightParen", "LeftBracket", "RightBracket", 
			"LeftBrace", "RightBrace", "Dot", "DotStar", "Comma", "Question", "Colon", 
			"Doublecolon", "Semi", "Arrow", "ArrowStar", "Ellipsis", "PlusPlus", 
			"MinusMinus", "Plus", "Minus", "Star", "Div", "Mod", "Caret", "And", 
			"Or", "AndAnd", "OrOr", "Tilde", "Not", "LeftShift", "RightShift", "Less", 
			"Greater", "LessEqual", "GreaterEqual", "Equal", "NotEqual", "Assign", 
			"PlusAssign", "MinusAssign", "StarAssign", "DivAssign", "ModAssign", 
			"AndAssign", "OrAssign", "XorAssign", "LeftShiftAssign", "RightShiftAssign", 
			"Identifier", "WhiteSpace", "NewLine", "BlockComment", "LineComment"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2O\u0211\b\1\4\2\t"+
		"\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4"+
		",\t,\4-\t-\4.\t.\4/\t/\4\60\t\60\4\61\t\61\4\62\t\62\4\63\t\63\4\64\t"+
		"\64\4\65\t\65\4\66\t\66\4\67\t\67\48\t8\49\t9\4:\t:\4;\t;\4<\t<\4=\t="+
		"\4>\t>\4?\t?\4@\t@\4A\tA\4B\tB\4C\tC\4D\tD\4E\tE\4F\tF\4G\tG\4H\tH\4I"+
		"\tI\4J\tJ\4K\tK\4L\tL\4M\tM\4N\tN\4O\tO\4P\tP\4Q\tQ\4R\tR\4S\tS\4T\tT"+
		"\4U\tU\3\2\3\2\5\2\u00ae\n\2\3\3\3\3\7\3\u00b2\n\3\f\3\16\3\u00b5\13\3"+
		"\3\3\3\3\3\4\3\4\5\4\u00bb\n\4\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6"+
		"\3\6\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\t\3"+
		"\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3\n\3\13\3\13\3\13\3\13\3\f\3\f\3\f"+
		"\3\f\3\f\3\f\3\f\3\r\3\r\3\r\3\16\3\16\3\16\3\16\3\17\3\17\3\17\3\17\3"+
		"\17\3\20\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3"+
		"\22\3\22\3\22\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\24\3\24\3\24\3\24\3"+
		"\24\3\25\3\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3"+
		"\27\3\27\3\27\3\27\3\27\3\30\3\30\3\30\3\30\3\30\3\30\3\31\3\31\3\32\3"+
		"\32\3\33\3\33\3\34\3\34\3\35\3\35\3\36\3\36\3\37\3\37\3 \3 \3 \3!\3!\3"+
		"\"\3\"\3#\3#\3$\3$\3$\3%\3%\3&\3&\3&\3\'\3\'\3\'\3\'\3(\3(\3(\3(\3)\3"+
		")\3)\3*\3*\3*\3+\3+\3,\3,\3-\3-\3.\3.\3/\3/\3\60\3\60\3\61\3\61\3\62\3"+
		"\62\3\63\3\63\3\63\3\64\3\64\3\64\3\65\3\65\3\66\3\66\3\67\3\67\3\67\3"+
		"8\38\38\39\39\3:\3:\3;\3;\3;\3<\3<\3<\3=\3=\3=\3>\3>\3>\3?\3?\3@\3@\3"+
		"@\3A\3A\3A\3B\3B\3B\3C\3C\3C\3D\3D\3D\3E\3E\3E\3F\3F\3F\3G\3G\3G\3H\3"+
		"H\3H\3H\3I\3I\3I\3I\3J\3J\7J\u01ae\nJ\fJ\16J\u01b1\13J\3K\3K\3L\3L\3L"+
		"\5L\u01b8\nL\3M\3M\7M\u01bc\nM\fM\16M\u01bf\13M\3N\3N\3O\3O\3P\3P\5P\u01c7"+
		"\nP\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\3Q\5Q"+
		"\u01de\nQ\3Q\5Q\u01e1\nQ\3Q\3Q\3Q\3Q\5Q\u01e7\nQ\3R\6R\u01ea\nR\rR\16"+
		"R\u01eb\3R\3R\3S\3S\5S\u01f2\nS\3S\5S\u01f5\nS\3S\3S\3T\3T\3T\3T\7T\u01fd"+
		"\nT\fT\16T\u0200\13T\3T\3T\3T\3T\3T\3U\3U\3U\3U\7U\u020b\nU\fU\16U\u020e"+
		"\13U\3U\3U\3\u01fe\2V\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27"+
		"\r\31\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33"+
		"\65\34\67\359\36;\37= ?!A\"C#E$G%I&K\'M(O)Q*S+U,W-Y.[/]\60_\61a\62c\63"+
		"e\64g\65i\66k\67m8o9q:s;u<w=y>{?}@\177A\u0081B\u0083C\u0085D\u0087E\u0089"+
		"F\u008bG\u008dH\u008fI\u0091J\u0093K\u0095\2\u0097\2\u0099\2\u009b\2\u009d"+
		"\2\u009f\2\u00a1\2\u00a3L\u00a5M\u00a7N\u00a9O\3\2\t\4\2C\\c|\3\2aa\3"+
		"\2\62;\3\2\63;\6\2\f\f\17\17$$^^\4\2\13\13\"\"\4\2\f\f\17\17\2\u0223\2"+
		"\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2"+
		"\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2"+
		"\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2"+
		"\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3\2\2\2"+
		"\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67\3\2\2\2\29\3\2\2\2\2;\3\2"+
		"\2\2\2=\3\2\2\2\2?\3\2\2\2\2A\3\2\2\2\2C\3\2\2\2\2E\3\2\2\2\2G\3\2\2\2"+
		"\2I\3\2\2\2\2K\3\2\2\2\2M\3\2\2\2\2O\3\2\2\2\2Q\3\2\2\2\2S\3\2\2\2\2U"+
		"\3\2\2\2\2W\3\2\2\2\2Y\3\2\2\2\2[\3\2\2\2\2]\3\2\2\2\2_\3\2\2\2\2a\3\2"+
		"\2\2\2c\3\2\2\2\2e\3\2\2\2\2g\3\2\2\2\2i\3\2\2\2\2k\3\2\2\2\2m\3\2\2\2"+
		"\2o\3\2\2\2\2q\3\2\2\2\2s\3\2\2\2\2u\3\2\2\2\2w\3\2\2\2\2y\3\2\2\2\2{"+
		"\3\2\2\2\2}\3\2\2\2\2\177\3\2\2\2\2\u0081\3\2\2\2\2\u0083\3\2\2\2\2\u0085"+
		"\3\2\2\2\2\u0087\3\2\2\2\2\u0089\3\2\2\2\2\u008b\3\2\2\2\2\u008d\3\2\2"+
		"\2\2\u008f\3\2\2\2\2\u0091\3\2\2\2\2\u0093\3\2\2\2\2\u00a3\3\2\2\2\2\u00a5"+
		"\3\2\2\2\2\u00a7\3\2\2\2\2\u00a9\3\2\2\2\3\u00ad\3\2\2\2\5\u00af\3\2\2"+
		"\2\7\u00ba\3\2\2\2\t\u00bc\3\2\2\2\13\u00c1\3\2\2\2\r\u00c7\3\2\2\2\17"+
		"\u00cd\3\2\2\2\21\u00d6\3\2\2\2\23\u00db\3\2\2\2\25\u00e1\3\2\2\2\27\u00e5"+
		"\3\2\2\2\31\u00ec\3\2\2\2\33\u00ef\3\2\2\2\35\u00f3\3\2\2\2\37\u00f8\3"+
		"\2\2\2!\u00fc\3\2\2\2#\u0101\3\2\2\2%\u0108\3\2\2\2\'\u010f\3\2\2\2)\u0114"+
		"\3\2\2\2+\u0119\3\2\2\2-\u0121\3\2\2\2/\u0126\3\2\2\2\61\u012c\3\2\2\2"+
		"\63\u012e\3\2\2\2\65\u0130\3\2\2\2\67\u0132\3\2\2\29\u0134\3\2\2\2;\u0136"+
		"\3\2\2\2=\u0138\3\2\2\2?\u013a\3\2\2\2A\u013d\3\2\2\2C\u013f\3\2\2\2E"+
		"\u0141\3\2\2\2G\u0143\3\2\2\2I\u0146\3\2\2\2K\u0148\3\2\2\2M\u014b\3\2"+
		"\2\2O\u014f\3\2\2\2Q\u0153\3\2\2\2S\u0156\3\2\2\2U\u0159\3\2\2\2W\u015b"+
		"\3\2\2\2Y\u015d\3\2\2\2[\u015f\3\2\2\2]\u0161\3\2\2\2_\u0163\3\2\2\2a"+
		"\u0165\3\2\2\2c\u0167\3\2\2\2e\u0169\3\2\2\2g\u016c\3\2\2\2i\u016f\3\2"+
		"\2\2k\u0171\3\2\2\2m\u0173\3\2\2\2o\u0176\3\2\2\2q\u0179\3\2\2\2s\u017b"+
		"\3\2\2\2u\u017d\3\2\2\2w\u0180\3\2\2\2y\u0183\3\2\2\2{\u0186\3\2\2\2}"+
		"\u0189\3\2\2\2\177\u018b\3\2\2\2\u0081\u018e\3\2\2\2\u0083\u0191\3\2\2"+
		"\2\u0085\u0194\3\2\2\2\u0087\u0197\3\2\2\2\u0089\u019a\3\2\2\2\u008b\u019d"+
		"\3\2\2\2\u008d\u01a0\3\2\2\2\u008f\u01a3\3\2\2\2\u0091\u01a7\3\2\2\2\u0093"+
		"\u01ab\3\2\2\2\u0095\u01b2\3\2\2\2\u0097\u01b7\3\2\2\2\u0099\u01b9\3\2"+
		"\2\2\u009b\u01c0\3\2\2\2\u009d\u01c2\3\2\2\2\u009f\u01c6\3\2\2\2\u00a1"+
		"\u01e6\3\2\2\2\u00a3\u01e9\3\2\2\2\u00a5\u01f4\3\2\2\2\u00a7\u01f8\3\2"+
		"\2\2\u00a9\u0206\3\2\2\2\u00ab\u00ae\7\62\2\2\u00ac\u00ae\5\u0099M\2\u00ad"+
		"\u00ab\3\2\2\2\u00ad\u00ac\3\2\2\2\u00ae\4\3\2\2\2\u00af\u00b3\7$\2\2"+
		"\u00b0\u00b2\5\u009fP\2\u00b1\u00b0\3\2\2\2\u00b2\u00b5\3\2\2\2\u00b3"+
		"\u00b1\3\2\2\2\u00b3\u00b4\3\2\2\2\u00b4\u00b6\3\2\2\2\u00b5\u00b3\3\2"+
		"\2\2\u00b6\u00b7\7$\2\2\u00b7\6\3\2\2\2\u00b8\u00bb\5)\25\2\u00b9\u00bb"+
		"\5\23\n\2\u00ba\u00b8\3\2\2\2\u00ba\u00b9\3\2\2\2\u00bb\b\3\2\2\2\u00bc"+
		"\u00bd\7d\2\2\u00bd\u00be\7q\2\2\u00be\u00bf\7q\2\2\u00bf\u00c0\7n\2\2"+
		"\u00c0\n\3\2\2\2\u00c1\u00c2\7d\2\2\u00c2\u00c3\7t\2\2\u00c3\u00c4\7g"+
		"\2\2\u00c4\u00c5\7c\2\2\u00c5\u00c6\7m\2\2\u00c6\f\3\2\2\2\u00c7\u00c8"+
		"\7e\2\2\u00c8\u00c9\7n\2\2\u00c9\u00ca\7c\2\2\u00ca\u00cb\7u\2\2\u00cb"+
		"\u00cc\7u\2\2\u00cc\16\3\2\2\2\u00cd\u00ce\7e\2\2\u00ce\u00cf\7q\2\2\u00cf"+
		"\u00d0\7p\2\2\u00d0\u00d1\7v\2\2\u00d1\u00d2\7k\2\2\u00d2\u00d3\7p\2\2"+
		"\u00d3\u00d4\7w\2\2\u00d4\u00d5\7g\2\2\u00d5\20\3\2\2\2\u00d6\u00d7\7"+
		"g\2\2\u00d7\u00d8\7n\2\2\u00d8\u00d9\7u\2\2\u00d9\u00da\7g\2\2\u00da\22"+
		"\3\2\2\2\u00db\u00dc\7h\2\2\u00dc\u00dd\7c\2\2\u00dd\u00de\7n\2\2\u00de"+
		"\u00df\7u\2\2\u00df\u00e0\7g\2\2\u00e0\24\3\2\2\2\u00e1\u00e2\7h\2\2\u00e2"+
		"\u00e3\7q\2\2\u00e3\u00e4\7t\2\2\u00e4\26\3\2\2\2\u00e5\u00e6\7h\2\2\u00e6"+
		"\u00e7\7t\2\2\u00e7\u00e8\7k\2\2\u00e8\u00e9\7g\2\2\u00e9\u00ea\7p\2\2"+
		"\u00ea\u00eb\7f\2\2\u00eb\30\3\2\2\2\u00ec\u00ed\7k\2\2\u00ed\u00ee\7"+
		"h\2\2\u00ee\32\3\2\2\2\u00ef\u00f0\7k\2\2\u00f0\u00f1\7p\2\2\u00f1\u00f2"+
		"\7v\2\2\u00f2\34\3\2\2\2\u00f3\u00f4\7n\2\2\u00f4\u00f5\7q\2\2\u00f5\u00f6"+
		"\7p\2\2\u00f6\u00f7\7i\2\2\u00f7\36\3\2\2\2\u00f8\u00f9\7p\2\2\u00f9\u00fa"+
		"\7g\2\2\u00fa\u00fb\7y\2\2\u00fb \3\2\2\2\u00fc\u00fd\7p\2\2\u00fd\u00fe"+
		"\7w\2\2\u00fe\u00ff\7n\2\2\u00ff\u0100\7n\2\2\u0100\"\3\2\2\2\u0101\u0102"+
		"\7t\2\2\u0102\u0103\7g\2\2\u0103\u0104\7v\2\2\u0104\u0105\7w\2\2\u0105"+
		"\u0106\7t\2\2\u0106\u0107\7p\2\2\u0107$\3\2\2\2\u0108\u0109\7u\2\2\u0109"+
		"\u010a\7v\2\2\u010a\u010b\7t\2\2\u010b\u010c\7k\2\2\u010c\u010d\7p\2\2"+
		"\u010d\u010e\7i\2\2\u010e&\3\2\2\2\u010f\u0110\7v\2\2\u0110\u0111\7j\2"+
		"\2\u0111\u0112\7k\2\2\u0112\u0113\7u\2\2\u0113(\3\2\2\2\u0114\u0115\7"+
		"v\2\2\u0115\u0116\7t\2\2\u0116\u0117\7w\2\2\u0117\u0118\7g\2\2\u0118*"+
		"\3\2\2\2\u0119\u011a\7v\2\2\u011a\u011b\7{\2\2\u011b\u011c\7r\2\2\u011c"+
		"\u011d\7g\2\2\u011d\u011e\7f\2\2\u011e\u011f\7g\2\2\u011f\u0120\7h\2\2"+
		"\u0120,\3\2\2\2\u0121\u0122\7x\2\2\u0122\u0123\7q\2\2\u0123\u0124\7k\2"+
		"\2\u0124\u0125\7f\2\2\u0125.\3\2\2\2\u0126\u0127\7y\2\2\u0127\u0128\7"+
		"j\2\2\u0128\u0129\7k\2\2\u0129\u012a\7n\2\2\u012a\u012b\7g\2\2\u012b\60"+
		"\3\2\2\2\u012c\u012d\7*\2\2\u012d\62\3\2\2\2\u012e\u012f\7+\2\2\u012f"+
		"\64\3\2\2\2\u0130\u0131\7]\2\2\u0131\66\3\2\2\2\u0132\u0133\7_\2\2\u0133"+
		"8\3\2\2\2\u0134\u0135\7}\2\2\u0135:\3\2\2\2\u0136\u0137\7\177\2\2\u0137"+
		"<\3\2\2\2\u0138\u0139\7\60\2\2\u0139>\3\2\2\2\u013a\u013b\7\60\2\2\u013b"+
		"\u013c\7,\2\2\u013c@\3\2\2\2\u013d\u013e\7.\2\2\u013eB\3\2\2\2\u013f\u0140"+
		"\7A\2\2\u0140D\3\2\2\2\u0141\u0142\7<\2\2\u0142F\3\2\2\2\u0143\u0144\7"+
		"<\2\2\u0144\u0145\7<\2\2\u0145H\3\2\2\2\u0146\u0147\7=\2\2\u0147J\3\2"+
		"\2\2\u0148\u0149\7/\2\2\u0149\u014a\7@\2\2\u014aL\3\2\2\2\u014b\u014c"+
		"\7/\2\2\u014c\u014d\7@\2\2\u014d\u014e\7,\2\2\u014eN\3\2\2\2\u014f\u0150"+
		"\7\60\2\2\u0150\u0151\7\60\2\2\u0151\u0152\7\60\2\2\u0152P\3\2\2\2\u0153"+
		"\u0154\7-\2\2\u0154\u0155\7-\2\2\u0155R\3\2\2\2\u0156\u0157\7/\2\2\u0157"+
		"\u0158\7/\2\2\u0158T\3\2\2\2\u0159\u015a\7-\2\2\u015aV\3\2\2\2\u015b\u015c"+
		"\7/\2\2\u015cX\3\2\2\2\u015d\u015e\7,\2\2\u015eZ\3\2\2\2\u015f\u0160\7"+
		"\61\2\2\u0160\\\3\2\2\2\u0161\u0162\7\'\2\2\u0162^\3\2\2\2\u0163\u0164"+
		"\7`\2\2\u0164`\3\2\2\2\u0165\u0166\7(\2\2\u0166b\3\2\2\2\u0167\u0168\7"+
		"~\2\2\u0168d\3\2\2\2\u0169\u016a\7(\2\2\u016a\u016b\7(\2\2\u016bf\3\2"+
		"\2\2\u016c\u016d\7~\2\2\u016d\u016e\7~\2\2\u016eh\3\2\2\2\u016f\u0170"+
		"\7\u0080\2\2\u0170j\3\2\2\2\u0171\u0172\7#\2\2\u0172l\3\2\2\2\u0173\u0174"+
		"\7>\2\2\u0174\u0175\7>\2\2\u0175n\3\2\2\2\u0176\u0177\7@\2\2\u0177\u0178"+
		"\7@\2\2\u0178p\3\2\2\2\u0179\u017a\7>\2\2\u017ar\3\2\2\2\u017b\u017c\7"+
		"@\2\2\u017ct\3\2\2\2\u017d\u017e\7>\2\2\u017e\u017f\7?\2\2\u017fv\3\2"+
		"\2\2\u0180\u0181\7@\2\2\u0181\u0182\7?\2\2\u0182x\3\2\2\2\u0183\u0184"+
		"\7?\2\2\u0184\u0185\7?\2\2\u0185z\3\2\2\2\u0186\u0187\7#\2\2\u0187\u0188"+
		"\7?\2\2\u0188|\3\2\2\2\u0189\u018a\7?\2\2\u018a~\3\2\2\2\u018b\u018c\7"+
		"-\2\2\u018c\u018d\7?\2\2\u018d\u0080\3\2\2\2\u018e\u018f\7/\2\2\u018f"+
		"\u0190\7?\2\2\u0190\u0082\3\2\2\2\u0191\u0192\7,\2\2\u0192\u0193\7?\2"+
		"\2\u0193\u0084\3\2\2\2\u0194\u0195\7\61\2\2\u0195\u0196\7?\2\2\u0196\u0086"+
		"\3\2\2\2\u0197\u0198\7\'\2\2\u0198\u0199\7?\2\2\u0199\u0088\3\2\2\2\u019a"+
		"\u019b\7(\2\2\u019b\u019c\7?\2\2\u019c\u008a\3\2\2\2\u019d\u019e\7~\2"+
		"\2\u019e\u019f\7?\2\2\u019f\u008c\3\2\2\2\u01a0\u01a1\7`\2\2\u01a1\u01a2"+
		"\7?\2\2\u01a2\u008e\3\2\2\2\u01a3\u01a4\7>\2\2\u01a4\u01a5\7>\2\2\u01a5"+
		"\u01a6\7?\2\2\u01a6\u0090\3\2\2\2\u01a7\u01a8\7@\2\2\u01a8\u01a9\7@\2"+
		"\2\u01a9\u01aa\7?\2\2\u01aa\u0092\3\2\2\2\u01ab\u01af\5\u0095K\2\u01ac"+
		"\u01ae\5\u0097L\2\u01ad\u01ac\3\2\2\2\u01ae\u01b1\3\2\2\2\u01af\u01ad"+
		"\3\2\2\2\u01af\u01b0\3\2\2\2\u01b0\u0094\3\2\2\2\u01b1\u01af\3\2\2\2\u01b2"+
		"\u01b3\t\2\2\2\u01b3\u0096\3\2\2\2\u01b4\u01b8\t\3\2\2\u01b5\u01b8\5\u0095"+
		"K\2\u01b6\u01b8\5\u009bN\2\u01b7\u01b4\3\2\2\2\u01b7\u01b5\3\2\2\2\u01b7"+
		"\u01b6\3\2\2\2\u01b8\u0098\3\2\2\2\u01b9\u01bd\5\u009dO\2\u01ba\u01bc"+
		"\5\u009bN\2\u01bb\u01ba\3\2\2\2\u01bc\u01bf\3\2\2\2\u01bd\u01bb\3\2\2"+
		"\2\u01bd\u01be\3\2\2\2\u01be\u009a\3\2\2\2\u01bf\u01bd\3\2\2\2\u01c0\u01c1"+
		"\t\4\2\2\u01c1\u009c\3\2\2\2\u01c2\u01c3\t\5\2\2\u01c3\u009e\3\2\2\2\u01c4"+
		"\u01c7\n\6\2\2\u01c5\u01c7\5\u00a1Q\2\u01c6\u01c4\3\2\2\2\u01c6\u01c5"+
		"\3\2\2\2\u01c7\u00a0\3\2\2\2\u01c8\u01c9\7^\2\2\u01c9\u01e7\7)\2\2\u01ca"+
		"\u01cb\7^\2\2\u01cb\u01e7\7$\2\2\u01cc\u01cd\7^\2\2\u01cd\u01e7\7A\2\2"+
		"\u01ce\u01cf\7^\2\2\u01cf\u01e7\7^\2\2\u01d0\u01d1\7^\2\2\u01d1\u01e7"+
		"\7c\2\2\u01d2\u01d3\7^\2\2\u01d3\u01e7\7d\2\2\u01d4\u01d5\7^\2\2\u01d5"+
		"\u01e7\7h\2\2\u01d6\u01d7\7^\2\2\u01d7\u01e7\7p\2\2\u01d8\u01d9\7^\2\2"+
		"\u01d9\u01e7\7t\2\2\u01da\u01e0\7^\2\2\u01db\u01dd\7\17\2\2\u01dc\u01de"+
		"\7\f\2\2\u01dd\u01dc\3\2\2\2\u01dd\u01de\3\2\2\2\u01de\u01e1\3\2\2\2\u01df"+
		"\u01e1\7\f\2\2\u01e0\u01db\3\2\2\2\u01e0\u01df\3\2\2\2\u01e1\u01e7\3\2"+
		"\2\2\u01e2\u01e3\7^\2\2\u01e3\u01e7\7v\2\2\u01e4\u01e5\7^\2\2\u01e5\u01e7"+
		"\7x\2\2\u01e6\u01c8\3\2\2\2\u01e6\u01ca\3\2\2\2\u01e6\u01cc\3\2\2\2\u01e6"+
		"\u01ce\3\2\2\2\u01e6\u01d0\3\2\2\2\u01e6\u01d2\3\2\2\2\u01e6\u01d4\3\2"+
		"\2\2\u01e6\u01d6\3\2\2\2\u01e6\u01d8\3\2\2\2\u01e6\u01da\3\2\2\2\u01e6"+
		"\u01e2\3\2\2\2\u01e6\u01e4\3\2\2\2\u01e7\u00a2\3\2\2\2\u01e8\u01ea\t\7"+
		"\2\2\u01e9\u01e8\3\2\2\2\u01ea\u01eb\3\2\2\2\u01eb\u01e9\3\2\2\2\u01eb"+
		"\u01ec\3\2\2\2\u01ec\u01ed\3\2\2\2\u01ed\u01ee\bR\2\2\u01ee\u00a4\3\2"+
		"\2\2\u01ef\u01f1\7\17\2\2\u01f0\u01f2\7\f\2\2\u01f1\u01f0\3\2\2\2\u01f1"+
		"\u01f2\3\2\2\2\u01f2\u01f5\3\2\2\2\u01f3\u01f5\7\f\2\2\u01f4\u01ef\3\2"+
		"\2\2\u01f4\u01f3\3\2\2\2\u01f5\u01f6\3\2\2\2\u01f6\u01f7\bS\2\2\u01f7"+
		"\u00a6\3\2\2\2\u01f8\u01f9\7\61\2\2\u01f9\u01fa\7,\2\2\u01fa\u01fe\3\2"+
		"\2\2\u01fb\u01fd\13\2\2\2\u01fc\u01fb\3\2\2\2\u01fd\u0200\3\2\2\2\u01fe"+
		"\u01ff\3\2\2\2\u01fe\u01fc\3\2\2\2\u01ff\u0201\3\2\2\2\u0200\u01fe\3\2"+
		"\2\2\u0201\u0202\7,\2\2\u0202\u0203\7\61\2\2\u0203\u0204\3\2\2\2\u0204"+
		"\u0205\bT\2\2\u0205\u00a8\3\2\2\2\u0206\u0207\7\61\2\2\u0207\u0208\7\61"+
		"\2\2\u0208\u020c\3\2\2\2\u0209\u020b\n\b\2\2\u020a\u0209\3\2\2\2\u020b"+
		"\u020e\3\2\2\2\u020c\u020a\3\2\2\2\u020c\u020d\3\2\2\2\u020d\u020f\3\2"+
		"\2\2\u020e\u020c\3\2\2\2\u020f\u0210\bU\2\2\u0210\u00aa\3\2\2\2\22\2\u00ad"+
		"\u00b3\u00ba\u01af\u01b7\u01bd\u01c6\u01dd\u01e0\u01e6\u01eb\u01f1\u01f4"+
		"\u01fe\u020c\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}