lexer grammar MxLexer;

Bool: 'bool';
Int: 'int';
String: 'string';
Void: 'void';

BooleanLiteral: True | False;
True: 'true';
False: 'false';

IntegerLiteral
    : '0'
    | DecimalLiteral
    ;
fragment DecimalLiteral: NonZeroDigit Digit*;
fragment Digit: [0-9];
fragment NonZeroDigit: [1-9];

StringLiteral: '"' SChar* '"';
fragment SChar
    : ~["\\\n\r]
    | '\\n'
    | '\\\\'
    | '\\"'
    ;

Identifier: Letter IChar*;
fragment Letter: [a-zA-Z];
fragment IChar
    : [_]
    | Letter
    | Digit
    ;

Class: 'class';

If: 'if';
Else: 'else';
While: 'while';
For: 'for';
Continue: 'continue';
Break: 'break';
Return: 'return';
New: 'new';

This: 'this';

Null: 'null';

LeftParen: '(';
RightParen: ')';
LeftBracket: '[';
RightBracket: ']';
LeftBrace: '{';
RightBrace: '}';

Dot: '.';
Comma: ',';
Question: '?';
Colon: ':';
Doublecolon: '::';
Semi: ';';
Arrow: '->';
Ellipsis: '...';

Not: '!' | 'not';
PlusPlus: '++';
MinusMinus: '--';

Plus: '+';
Minus: '-';
Star: '*';
Div: '/';
Mod: '%';
Caret: '^';
And: '&';
Or: '|';
AndAnd: '&&';
OrOr: '||';
Tilde: '~';
LeftShift: '<<';
RightShift: '>>';

Less: '<';
Greater: '>';
LessEqual: '<=';
GreaterEqual: '>=';
Equal: '==';
NotEqual: '!=';

Assign: '=';
PlusAssign: '+=';
MinusAssign: '-=';
StarAssign: '*=';
DivAssign: '/=';
ModAssign: '%=';
AndAssign: '&=';
OrAssign: '|=';
XorAssign: '^=';
LeftShiftAssign: '<<=';
RightShiftAssign: '>>=';

WhiteSpace: [ \t]+ -> skip;
NewLine: ('\r' '\n'? |'\n') -> skip;
LineComment: '//' ~ [\r\n]* -> skip;