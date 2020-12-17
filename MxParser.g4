parser grammar MxParser;

options {tokenVocab = MxLexer;}

/* expression */

primaryExpression
    : literal
    | LeftParen expression RightParen
    | This
    | idExpression
    ;

idExpression: Identifier;

postfixExpression
    : primaryExpression
    | postfixExpression LeftBracket expression RightBracket
	| postfixExpression LeftParen expressionList? RightParen
	| postfixExpression Dot idExpression
	| postfixExpression (PlusPlus | MinusMinus)
    ;

unaryExpression
    : postfixExpression
	| (PlusPlus | MinusMinus | unaryOperator) unaryExpression
	| newExpression
	;

unaryOperator: Star | And | Plus | Tilde | Minus | Not;

newExpression: New (newTypeId) newInitializer?;

newTypeId: simpleTypeSpecifier;

newInitializer
    : (LeftParen expression RightParen)+ (LeftParen RightParen)*
    | LeftBracket RightBracket
    | (LeftParen expression RightParen)+ (LeftParen RightParen)+ (LeftParen expression RightParen)
    ;

multiplicativeExpression
    : unaryExpression (
        (Star | Div | Mod) unaryExpression
    )*
    ;

additiveExpression
    : multiplicativeExpression (
		(Plus | Minus) multiplicativeExpression
	)*
    ;

shiftExpression
    : additiveExpression (
        shiftOperator additiveExpression
    )*
    ;

shiftOperator: LeftShift | RightShift;

relationalExpression
    : shiftExpression (
		(Less | Greater | LessEqual | GreaterEqual) shiftExpression
	)*
    ;

equalityExpression
    : relationalExpression (
		(Equal | NotEqual) relationalExpression
	)*
    ;

andExpression: equalityExpression (And equalityExpression)*;

exclusiveOrExpression: andExpression (Caret andExpression)*;

inclusiveOrExpression
    : exclusiveOrExpression (
        Or exclusiveOrExpression
    )*
    ;

logicalAndExpression
    : inclusiveOrExpression (
        AndAnd inclusiveOrExpression
    )*
    ;

logicalOrExpression
    : logicalAndExpression (
        OrOr logicalAndExpression
    )*
    ;

assignmentExpression:
	logicalOrExpression
	| logicalOrExpression assignmentOperator logicalOrExpression
    ;

assignmentOperator
    : Assign
	| StarAssign
	| DivAssign
	| ModAssign
	| PlusAssign
	| MinusAssign
	| RightShiftAssign
	| LeftShiftAssign
	| AndAssign
	| XorAssign
	| OrAssign
    ;

expression: assignmentExpression (Comma assignmentExpression)*;

expressionList: expression (Comma expression)*;

/* statement */

statement
    : expressionStatement
    | compoundStatement
    | selectionStatement
    | iterationStatement
    | jumpStatement
    | declarationStatement
    ;

expressionStatement: expression? Semi;

compoundStatement: LeftBrace statementSeq? RightBrace;

statementSeq: statement+;

selectionStatement: If LeftParen condition RightParen statement (Else statement)?;

condition: expression;

iterationStatement
    : While LeftParen condition RightParen statement
    | For LeftParen forInitStatement condition? Semi expression? RightParen statement
    ;

forInitStatement: expressionStatement | simpleDeclaration;

jumpStatement
    : ( Break
	| Continue
	| Return expression?
    ) Semi
    ;

declarationStatement: simpleDeclaration;

simpleDeclaration
    : simpleTypeSpecifier declaratorList Semi
    | classSpecifier declaratorList? Semi
    ;

typeSpecifier
    : simpleTypeSpecifier
    | classSpecifier
    ;

simpleTypeSpecifier
    : (className | builtinType) (LeftBracket RightBracket)*
    | Void
    ;

declaratorList: declarator (Comma declarator)*;

declarator: idExpression;

/* function */

functionDefinition: simpleTypeSpecifier? declarator LeftParen parameterDeclarationList RightParen functionBody;

parameterDeclarationList: parameterDeclaration (Comma parameterDeclaration)*;

parameterDeclaration: simpleTypeSpecifier declarator;

functionBody: compoundStatement;

/* class */

classSpecifier: classHead LeftBrace memberSpecification RightBrace;

classHead: Class className;

className: Identifier;

memberSpecification: memberDeclaration+;

memberDeclaration
    : typeSpecifier 
    | functionDefinition
    ;

/* basic definitions */

builtinType
    : Int
    | Bool
    | String
    ;

literal
    : BooleanLiteral
    | IntegerLiteral
    | StringLiteral
    | Null
    ;
