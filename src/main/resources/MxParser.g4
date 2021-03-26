parser grammar MxParser;

options {tokenVocab = MxLexer;}

translationUnit: declarationSeq? EOF;

/* expressions */

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

expressionList: initializerList;

unaryExpression
    : postfixExpression
	| (PlusPlus | MinusMinus | unaryOperator) unaryExpression
	| newExpression
	;

unaryOperator: Or | Star | And | Plus | Tilde | Minus | Not;

newExpression: New newTypeId newInitializer?;

newTypeId: typeSpecifierSeq newDeclarator?;

newDeclarator
    : LeftBracket expression RightBracket
    | newDeclarator LeftBracket constantExpression? RightBracket
    ;

newInitializer
    : LeftParen expressionList? RightParen
	| bracedInitList
    ;

multiplicativeExpression
    : unaryExpression (
        multiplicativeOperator unaryExpression
    )*
    ;

multiplicativeOperator: Star | Div | Mod;

additiveExpression
    : multiplicativeExpression (
		additiveOperator multiplicativeExpression
	)*
    ;

additiveOperator: Plus | Minus;

shiftExpression
    : additiveExpression (
        shiftOperator additiveExpression
    )*
    ;

shiftOperator: LeftShift | RightShift;

relationalExpression
    : shiftExpression (
		relationalOperator shiftExpression
	)*
    ;

relationalOperator: Less | Greater | LessEqual | GreaterEqual;

equalityExpression
    : relationalExpression (
		equalityOperator relationalExpression
	)*
    ;

equalityOperator: Equal | NotEqual;

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

conditionalExpression: logicalOrExpression;

assignmentExpression
    : conditionalExpression
	| logicalOrExpression assignmentOperator initializerClause
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

constantExpression: conditionalExpression;

/* statements */

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
    :   ( Break
		| Continue
		| Return (expression | bracedInitList)?
	) Semi
    ;

declarationStatement: blockDeclaration;

/* declarations */

declarationSeq: declaration+;

declaration
    : blockDeclaration
    | functionDefinition
    | emptyDeclaration
    ;

blockDeclaration: simpleDeclaration;

simpleDeclaration: declSpecifierSeq initDeclaratorList? Semi;

emptyDeclaration: Semi;

/* specifiers */

declSpecifier
    : storageClassSpecifier
    | functionSpecifier
    | Friend
    | Typedef
    | Constexpr
    | trailingTypeSpecifier
    ;

declSpecifierSeq: declSpecifier* typeSpecifier;

storageClassSpecifier
    : Register
    | Static
    | Thread_local
    | Extern
    | Mutable
    ;

functionSpecifier
    : Inline
    | Virtual
    | Explicit
    ;

typeSpecifier
    : simpleTypeSpecifier
	| classSpecifier
	;

trailingTypeSpecifier: cvQualifier;

typeSpecifierSeq: trailingTypeSpecifier* typeSpecifier;

simpleTypeSpecifier
    : simpleTypeSpecifier LeftBracket RightBracket
    | nonArrayTypeSpecifier
	;

nonArrayTypeSpecifier
    : className
    | builtinType
    ;

/* declarators and initializers */

initDeclaratorList: initDeclarator (Comma initDeclarator)*;

initDeclarator: declarator initializer?;

declarator: idExpression;

initializer
    : braceOrEqualInitializer
	| LeftParen expressionList RightParen
    ;

/* Why not named equalInitializer: in C++,
 * braceOrEqualInitializer
 *     : Assign initializerClause
 *     | bracedInitList
 *     ;
 */
braceOrEqualInitializer: Assign initializerClause;

initializerClause: assignmentExpression | bracedInitList;

initializerList
    : initializerClause (
		Comma initializerClause
	)*
    ;

bracedInitList: LeftBrace initializerList? RightBrace;

//cvQualifier: Const | Volatile;
cvQualifier: Volatile;

/* function */

parametersAndQualifiers: LeftParen parameterDeclarationList? RightParen;

parameterDeclarationList: parameterDeclaration (Comma parameterDeclaration)*;

parameterDeclaration: declSpecifierSeq declarator (Assign initializerClause)?;

functionDefinition: declSpecifierSeq? declarator parametersAndQualifiers functionBody;

functionBody: compoundStatement;

/* class */

classSpecifier: classHead LeftBrace memberSpecification? RightBrace;

classHead: classKey className;

classKey: Class | Struct;

className: Identifier;

memberSpecification: memberDeclaration+;

memberDeclaration
    : declSpecifierSeq memberDeclaratorList? Semi
    | functionDefinition
    | emptyDeclaration
    ;

memberDeclaratorList: memberDeclarator (Comma memberDeclarator)*;

memberDeclarator: declarator braceOrEqualInitializer?;

/* basic definitions */

builtinType
    : Int
    | Bool
    | String
    | Void
    ;

literal
    : BooleanLiteral
    | IntegerLiteral
    | StringLiteral
    | Null
    ;