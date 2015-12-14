import java_cup.runtime.*;

terminal ID, NUMBER, STRING;
terminal ASSIGN, SEMI;
terminal AND, OR, NOT;
terminal NE, EQ, LT, GT, LE, GE;
terminal PLUS, MINUS, TIMES, DIV, MOD;
terminal PRINT, IF, ELSE, WHILE, FOR, RETURN, QUIT, FUNCTION;
terminal LBRACE, RBRACE, LPAR, RPAR, COMMA;

nonterminal program, dfnStmntList, definition, stmntList, statement;
nonterminal printExprList, nePrintExprList, printExpr, assignment;
nonterminal paramList, neIDList, boolExpr, expr, exprList, neExprList;

precedence left  OR;
precedence left  AND;
precedence right NOT;
precedence left  PLUS, MINUS;
precedence left  TIMES, DIV, MOD;
%%%

SEMI := \; ;
TIMES := \* ;
MINUS   := \- ;
DIV   := \\ ;
MOD := \%;
PLUS  := \+ ;
LPAR := \( ;
RPAR := \) ;
LBRACE := \{ ;
RBRACE := \} ;
COMMA := , ;
ASSIGN := = ;
EQ := == ;
NE := != ;
LT := < ;
GT := > ;
LE := <= ;
GE := >= ;
AND := && ;
OR := \|\| ;
NOT := ! ;
FUNCTION := function ;
RETURN := return ;
IF := if ;
ELSE := else ;
WHILE := while ;
FOR := for ;
PRINT := print ;
QUIT := exit ;
STRING := \"[^\"]*\" ;
NEWLINE := \n ;
COMMENTS := // [^\n]* ;
WHITESPACE := [ \t\v\n\r\s] ;

INTEGER := 0|[1-9][0-9]* ;
DECIMAL := 0\.[0-9]+|[1-9][0-9]*\.[0-9]+ ;
ZID := [a-zA-Z_][a-zA-Z0-9_]* ;


%%%
program ::= dfnStmntList ;

dfnStmntList 
    ::= definition dfnStmntList
     |  statement  dfnStmntList
     |  
     ;

definition 
    ::= FUNCTION ZID LPAR paramList RPAR LBRACE stmntList RBRACE 
     ;

stmntList
    ::= statement stmntList
     |  
     ;

statement 
    ::= assignment SEMI     
     |  PRINT LPAR printExprList RPAR SEMI       
     |  IF LPAR boolExpr RPAR LBRACE stmntList RBRACE 
     |  WHILE LPAR boolExpr RPAR LBRACE stmntList RBRACE 
     |  FOR LPAR assignment SEMI boolExpr SEMI assignment RPAR LBRACE stmntList RBRACE
     |  RETURN expr SEMI 
     |  RETURN SEMI 
     |  expr SEMI       
     |  QUIT SEMI
     ;

printExprList 
    ::= printExpr COMMA nePrintExprList 
     |  printExpr
     |  
     ;

nePrintExprList
    ::= printExpr
     |  printExpr COMMA nePrintExprList
     ;

printExpr 
    ::= STRING 
     |  expr   
     ;

assignment 
    ::= ZID ASSIGN expr 
     ;

paramList 
    ::= ZID COMMA neIDList
     |  ZID
     |  
     ;

neIDList
    ::= ZID COMMA neIDList
     |  ZID
     ;

boolExpr 
    ::= boolExpr OR  boolExpr
     |  boolExpr AND boolExpr
     |  NOT boolExpr 
     |  LPAR boolExpr RPAR 
     |  expr EQ expr  
     |  expr NE expr 
     |  expr LE expr 
     |  expr GE expr 
     |  expr LT expr 
     |  expr GT expr 
     ;

expr
    ::= expr PLUS expr
     |  expr MINUS expr
     |  expr TIMES expr
     |  expr DIV   expr
     |  expr MOD   expr
     |  LPAR expr RPAR      
     |  ZID    
     |  INTEGER
     |  DECIMAL        
     |  ZID LPAR exprList RPAR
     ;

exprList
    ::= expr COMMA neExprList
     |  expr
     |  
     ;

neExprList
    ::= expr COMMA neExprList
     |  expr
     ;

