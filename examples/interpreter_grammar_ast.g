
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
STRING := \"(?:\\.|[^\"])*\" ;
NEWLINE := \n ;
COMMENTS := //[^\n]* ;
WHITESPACE := [ \t\v\n\r\s] ;
SKIP := WHITESPACE | NEWLINE | COMMENTS ;
INTEGER := 0|[1-9][0-9]* ;
DECIMAL := 0\.[0-9]+|[1-9][0-9]*\.[0-9]+ ;
ZID := [a-zA-Z_][a-zA-Z0-9_]* ;


%%%
program ::= dfnStmntList:d {: result := Program(d); :};

dfnStmntList 
    ::= definition:d dfnStmntList:dl {: result := [d] + dl; :}
     |  statement:stmts  dfnStmntList:dsl {: result := [stmts] + dsl; :}
     | {: result := []; :}
     ;

definition ::= FUNCTION ZID:function_name LPAR paramList:param_list RPAR LBRACE stmntList:statement_list RBRACE 
        {: result := Function(function_name, param_list, statement_list);:}
     ;

stmntList
    ::= statement:s stmntList:sl {: result := [s] + sl ; :}
     |  {: result := []; :}
     ;

statement 
    ::= assignment:a SEMI {: result := Ass(a); :}    
     |  PRINT LPAR printExprList:printexpr_list RPAR SEMI       {: result := Print(printexpr_list); :}
     |  IF LPAR boolExpr:b RPAR LBRACE stmntList:st_list1 RBRACE           {: result := If(b, st_list1); :}
     |  WHILE LPAR boolExpr:b RPAR LBRACE stmntList:st_list2 RBRACE        {: result := While(b, st_list2); :}
     |  FOR LPAR assignment:i_a SEMI boolExpr:b SEMI assignment:e_a RPAR LBRACE stmntList:st_list3 RBRACE {: result := For(i_a, b, e_a, st_list3);  :}
     |  RETURN expr:e SEMI {: result := Return(e); :}
     |  RETURN SEMI {: result := Return(); :}
     |  expr:e SEMI {: result := Expr(e); :}      
     |  QUIT SEMI {: result := Exit(); :}
     ;

printExprList 
    ::= printExpr:p COMMA nePrintExprList:np {: result := [p] + np ; :}
     |  printExpr:p {: result := [p]; :}
     |  {: result := []; :}
     ;

nePrintExprList
    ::= printExpr:p {: result := [p]; :}
     |  printExpr:p COMMA nePrintExprList:np {: result := [p] + np ; :}
     ;

printExpr 
    ::= STRING:string {: result := PrintString(string); :}
     |  expr:e  {: result := Expr(e); :}
     ;

assignment 
    ::= ZID:id ASSIGN expr:e {: result := Assign(id, e); :}
     ;

paramList 
    ::= ZID:id COMMA neIDList:nid {: result := [id] + nid ; :}
     |  ZID:id {: result := [id] ; :}
     |  {: result := []; :}
     ;

neIDList
    ::= ZID:id COMMA neIDList:nid {: result := [id] + nid ; :}
     |  ZID:id  {: result := [id] ; :}
     ;


boolExpr 
    ::= expr:lhs EQ expr:rhs  {: result := Equation(lhs,rhs); :}
     |  expr:lhs NE expr:rhs  {: result := Inequation(lhs,rhs); :}
     |  disjunction:lhs EQ disjunction:rhs  {: result := Equation(lhs,rhs); :}
     |  disjunction:lhs NE disjunction:rhs  {: result := Inequation(lhs,rhs); :}
     |  expr:lhs LE expr:rhs  {: result := LessOrEqual(lhs,rhs); :}
     |  expr:lhs GE expr:rhs  {: result := GreaterOrEqual(lhs,rhs); :}
     |  expr:lhs LT expr:rhs  {: result := LessThan(lhs,rhs); :}
     |  expr:lhs GT expr:rhs  {: result := GreaterThan(lhs,rhs); :}
     |  disjunction:d {: result := d; :}
     ;
disjunction
    ::= disjunction:d OR conjunction:c {: result := Disjunction(d,c); :}
     |  conjunction:c {: result := c; :}
     ;
conjunction
    ::= conjunction:c AND boolFactor:f {:result := Conjunction(c,f); :}
     | boolFactor:f {: result := f; :}
     ;
boolFactor
    ::= LPAR boolExpr:be_par RPAR {:  result := be_par; :}
     | NOT boolExpr:e {: result := Negation(e); :}
     ;


expr ::= expr:e PLUS   prod:p {: result := Sum(e,p); :} 
      |  expr:e MINUS  prod:p {: result := Difference(e,p); :} 
      |  prod:p               {: result := p;     :}
      ;
prod ::= prod:p TIMES  fact:f {: result := Product(p,f); :}
      |  prod:p DIV fact:f {: result := Quotient(p,f); :} 
      |  prod:p MOD    fact:f {: result := Mod(p,f); :} 
      |  fact:f               {: result := f;     :}
      ;
fact ::= LPAR expr:e_par RPAR {: result := e_par;   :} 
      |  INTEGER:n             {: result := Integer(eval(n));   :} 
      |  DECIMAL:d               {: result := Decimal(eval(d)); :}
      |  ZID:id_1 LPAR exprList:el RPAR {: result := FunctionCall(id_1,el); :}
      | ZID:id_2 {: result := Variable(id_2); :}
      ;

exprList
    ::= expr:e COMMA neExprList:el {: result := [e] + el; :}
     |  expr:e {: result := [e]; :}
     |  {: result := []; :}
     ;

neExprList
    ::= expr:e COMMA neExprList:el {: result := [e] + el; :}
     |  expr:e {: result := [e]; :}
     ;

