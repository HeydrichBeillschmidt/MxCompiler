lexer grammar MxLexer;

IntegerLiteral: '0' | DecimalLiteral;
StringLiteral: '"' SChar* '"';
BooleanLiteral: True_ | False_;

/* keywords */
// hate those test cases using C++ keywords as variable names...

//Alignas:            'alignas';
//Alignof:            'alignof';
//Asm:                'asm';
//Auto:               'auto';
Bool:               'bool';
Break:              'break';
//Case:               'case';
//Catch:              'catch';
//Char:               'char';
//Char16:             'char16_t';
//Char32:             'char32_t';
Class:              'class';
//Const:              'const';
//Constexpr:          'constexpr';
//Const_cast:         'const_cast';
Continue:           'continue';
//Decltype:           'decltype';
//Default:            'default';
//Delete:             'delete';
//Do:                 'do';
//Double:             'double';
//Dynamic_cast:       'dynamic_cast';
Else:               'else';
//Enum:               'enum';
//Explicit:           'explicit';
//Export:             'export';
//Extern:             'extern';
False_:             'false';
//Final:              'final';
//Float:              'float';
For:                'for';
//Friend:             'friend';
//Goto:               'goto';
If:                 'if';
//Inline:             'inline';
Int:                'int';
//Long:               'long';
//Mutable:            'mutable';
//Namespace:          'namespace';
New:                'new';
//Noexcept:           'noexcept';
Null:               'null';
//Nullptr:            'nullptr';
//Operator:           'operator';
//Override:           'override';
//Private:            'private';
//Protected:          'protected';
//Public:             'public';
//Register:           'register';
//Reinterpret_cast:   'reinterpret_cast';
Return:             'return';
//Short:              'short';
//Signed:             'signed';
//Sizeof:             'sizeof';
//Static:             'static';
//Static_assert:      'static_assert';
//Static_cast:        'static_cast';
String:             'string';
//Struct:             'struct';
//Switch:             'switch';
//Template:           'template';
This:               'this';
//Thread_local:       'thread_local';
//Throw:              'throw';
True_:              'true';
//Try:                'try';
//Typedef:            'typedef';
//Typeid_:            'typeid';
//Typename_:          'typename';
//Union:              'union';
//Unsigned:           'unsigned';
//Using:              'using';
//Virtual:            'virtual';
Void:               'void';
//Volatile:           'volatile';
//Wchar:              'wchar_t';
While:              'while';

/* operators */

LeftParen:      '(';
RightParen:     ')';
LeftBracket:    '[';
RightBracket:   ']';
LeftBrace:      '{';
RightBrace:     '}';

Dot:            '.';
DotStar:        '.*';
Comma:          ',';
Question:       '?';
Colon:          ':';
Doublecolon:    '::';
Semi:           ';';
Arrow:          '->';
ArrowStar:      '->*';
Ellipsis:       '...';

PlusPlus:   '++';
MinusMinus: '--';

Plus:       '+';
Minus:      '-';
Star:       '*';
Div:        '/';
Mod:        '%';
Caret:      '^';
And:        '&';
Or:         '|';
AndAnd:     '&&';
OrOr:       '||';
Tilde:      '~';
Not:        '!';
LeftShift:  '<<';
RightShift: '>>';

Less:           '<';
Greater:        '>';
LessEqual:      '<=';
GreaterEqual:   '>=';
Equal:          '==';
NotEqual:       '!=';

Assign:             '=';
PlusAssign:         '+=';
MinusAssign:        '-=';
StarAssign:         '*=';
DivAssign:          '/=';
ModAssign:          '%=';
AndAssign:          '&=';
OrAssign:           '|=';
XorAssign:          '^=';
LeftShiftAssign:    '<<=';
RightShiftAssign:   '>>=';

Identifier: Letter IChar*;
fragment Letter: [a-zA-Z];
fragment IChar
    : [_]
    | Letter
    | Digit
    ;

fragment DecimalLiteral: NonZeroDigit Digit*;
fragment Digit: [0-9];
fragment NonZeroDigit: [1-9];

fragment SChar: ~["\\\n\r] | SimpleEscapeSequence;
fragment SimpleEscapeSequence
    : '\\\''
	| '\\"'
	| '\\?'
	| '\\\\'
	| '\\a'
	| '\\b'
	| '\\f'
	| '\\n'
	| '\\r'
	| ('\\' ('\r' '\n'? | '\n'))
	| '\\t'
	| '\\v'
	;

WhiteSpace:          [ \t]+ -> skip;
NewLine: ('\r' '\n'? |'\n') -> skip;
BlockComment: '/*' .*? '*/' -> skip;
LineComment: '//' ~ [\r\n]* -> skip;