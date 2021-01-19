lexer grammar MxLexer;

IntegerLiteral: '0' | DecimalLiteral;
StringLiteral: '"' SChar* '"';
BooleanLiteral: True_ | False_;

/* keywords */

Bool:       'bool';
Break:      'break';
Class:      'class';
Continue:   'continue';
Else:       'else';
False_:     'false';
For:        'for';
If:         'if';
Int:        'int';
Main:       'main';
New:        'new';
Null:       'null';
Return:     'return';
String:     'string';
This:       'this';
True_:      'true';
Void:       'void';
While:      'while';

/* operators */

LeftParen:      '(';
RightParen:     ')';
LeftBracket:    '[';
RightBracket:   ']';
LeftBrace:      '{';
RightBrace:     '}';

Dot:            '.';
Comma:          ',';
Question:       '?';
Colon:          ':';
Doublecolon:    '::';
Semi:           ';';
Arrow:          '->';
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