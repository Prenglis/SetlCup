
%%%

SEMI := ; ;
TIMES := \* ;
MINUS   := - ;
DIV   := \\ ;
MOD := %;
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
SKIP := WHITESPACE | NEWLINE | COMMENTS ;
INTEGER := 0|[1-9][0-9]* ;
DECIMAL := 0\.[0-9]+|[1-9][0-9]*\.[0-9]+ ;
ZID := [a-zA-Z_][a-zA-Z0-9_]* ;


%%%
program ::= dfnStmntList:d ;

dfnStmntList 
    ::= definition:d dfnStmntList:dl 
     |  statement:stmts  dfnStmntList:dsl 
     | 
     ;

definition ::= FUNCTION ZID:function_name LPAR paramList:param_list RPAR LBRACE stmntList:statement_list RBRACE ;

stmntList
    ::= statement:s stmntList:sl 
     |  
     ;

statement 
    ::= assignment:a SEMI     
     |  PRINT LPAR printExprList:printexpr_list RPAR SEMI       
     |  IF LPAR boolExpr:b RPAR LBRACE stmntList:st_list1 RBRACE           
     |  WHILE LPAR boolExpr:b RPAR LBRACE stmntList:st_list2 RBRACE        
     |  FOR LPAR assignment:i_a SEMI boolExpr:b SEMI assignment:e_a RPAR LBRACE stmntList:st_list3 RBRACE 
     |  RETURN expr:e SEMI 
     |  RETURN SEMI 
     |  expr:e SEMI       
     |  QUIT SEMI 
     ;

printExprList 
    ::= printExpr:p COMMA nePrintExprList:np 
     |  printExpr:p 
     |  
     ;

nePrintExprList
    ::= printExpr:p 
     |  printExpr:p COMMA nePrintExprList:np 
     ;

printExpr 
    ::= STRING:string 
     |  expr:e  
     ;

assignment 
    ::= ZID:id ASSIGN expr:e 
     ;

paramList 
    ::= ZID:id COMMA neIDList:nid 
     |  ZID:id 
     |  
     ;

neIDList
    ::= ZID:id COMMA neIDList:nid 
     |  ZID:id  
     ;


boolExpr 
    ::= expr:lhs EQ expr:rhs  
     |  expr:lhs NE expr:rhs  
     |  disjunction:lhs EQ disjunction:rhs  
     |  disjunction:lhs NE disjunction:rhs  
     |  expr:lhs LE expr:rhs  
     |  expr:lhs GE expr:rhs  
     |  expr:lhs LT expr:rhs  
     |  expr:lhs GT expr:rhs  
     |  disjunction:d 
     ;
disjunction
    ::= disjunction:d OR conjunction:c 
     |  conjunction:c 
     ;
conjunction
    ::= conjunction:c AND boolFactor:f 
     | boolFactor:f 
     ;
boolFactor
    ::= LPAR boolExpr:e RPAR 
     | NOT boolExpr:e 
     ;


expr ::= expr:e PLUS   prod:p  
      |  expr:e MINUS  prod:p  
      |  prod:p               
      ;
prod ::= prod:p TIMES  fact:f 
      |  prod:p DIV fact:f  
      |  prod:p MOD    fact:f  
      |  fact:f               
      ;
fact ::= LPAR expr:e RPAR  
      |  INTEGER:n              
      |  DECIMAL:d               
      |  ZID:id_1 LPAR exprList:el RPAR 
      | ZID:id_2 
      ;

exprList
    ::= expr:e COMMA neExprList:el 
     |  expr:e 
     |  
     ;

neExprList
    ::= expr:e COMMA neExprList:el 
     |  expr:e 
     ;

