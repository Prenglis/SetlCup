
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
program ::= dfnStmntList:d {: print("d : $d$"); :};

dfnStmntList 
    ::= definition:d dfnStmntList:dl {: result := [d] + dl; :}
     |  statement:stmts  dfnStmntList:dsl {: result := [stmts] + dsl; :}
     | {: result := []; :}
     ;

definition ::= FUNCTION ZID:function_name LPAR paramList:param_list RPAR LBRACE stmntList:statement_list RBRACE 
        {: result := "$function_name$ := procedure($join(param_list, \",\")$) { $join(statement_list, \"\")$};";:}
     ;

stmntList
    ::= statement:s stmntList:sl {: result := [s] + sl ; :}
     |  {: result := []; :}
     ;

statement 
    ::= assignment:a SEMI {: result := "$a$;"; :}    
     |  PRINT LPAR printExprList:printexpr_list RPAR SEMI       {: result := "print($printexpr_list$)"; :}
     |  IF LPAR boolExpr:b RPAR LBRACE stmntList:st_list1 RBRACE           {: result := "if($b$){ $join(st_list1, \"\")$}" ; :}
     |  WHILE LPAR boolExpr:b RPAR LBRACE stmntList:st_list2 RBRACE        {: result := "while($b$){$join(st_list2, \"\")$}":}
     |  FOR LPAR assignment:i_a SEMI boolExpr:b SEMI assignment:e_a RPAR LBRACE stmntList:st_list3 RBRACE {: result := "for($i_a$;$b$;$e_a$;){$join(st_list3, \"\")$}";  :}
     |  RETURN expr:e SEMI {: result := "return $e$;"; :}
     |  RETURN SEMI {: result := "return ;"; :}
     |  expr:e SEMI {: result := "$e$;" ; :}      
     |  QUIT SEMI {: result := "exit;" ; :}
     ;

printExprList 
    ::= printExpr:p COMMA nePrintExprList:np {: result := p + np ; :}
     |  printExpr:p {: result := p ; :}
     |  
     ;

nePrintExprList
    ::= printExpr:p {: result := p; :}
     |  printExpr:p COMMA nePrintExprList:np {: result := p + np ; :}
     ;

printExpr 
    ::= STRING:string {: result := ["$string$"]; :}
     |  expr:e  {: result := [e]; :}
     ;

assignment 
    ::= ZID:id ASSIGN expr:e {: result := "$id$ := $e$"; :}
     ;

paramList 
    ::= ZID:id COMMA neIDList:nid {: result := [id] + nid ; :}
     |  ZID:id {: result := [id] ; :}
     |  
     ;

neIDList
    ::= ZID:id COMMA neIDList:nid {: result := [id] + nid ; :}
     |  ZID:id  {: result := [id] ; :}
     ;


boolExpr 
    ::= expr:lhs EQ expr:rhs  {: result := "$lhs$ == $rhs$"; :}
     |  expr:lhs NE expr:rhs  {: result := "$lhs$ != $rhs$"; :}
     |  disjunction:lhs EQ disjunction:rhs  {: result := "$lhs$ == $rhs$"; :}
     |  disjunction:lhs NE disjunction:rhs  {: result := "$lhs$ != $rhs$"; :}
     |  expr:lhs LE expr:rhs  {: result := "$lhs$ <= $rhs$"; :}
     |  expr:lhs GE expr:rhs  {: result := "$lhs$ >= $rhs$"; :}
     |  expr:lhs LT expr:rhs  {: result := "$lhs$ < $rhs$"; :}
     |  expr:lhs GT expr:rhs  {: result := "$lhs$ > $rhs$"; :}
     |  disjunction:d {: result := "$d"; :}
     ;
disjunction
    ::= disjunction:d OR conjunction:c {: result := "$d$ || $c$"; :}
     |  conjunction:c {: result := "$c$"; :}
     ;
conjunction
    ::= conjunction:c AND boolFactor:f {:result := "$c$ && $f$"; :}
     | boolFactor:f {: result := "$f$"; :}
     ;
boolFactor
    ::= LPAR boolExpr:e RPAR {:  result := "($e$)"; :}
     | NOT boolExpr:e {: result := "!$e$"; :}
     ;


expr ::= expr:e PLUS   prod:p {: result := "$e$ + $p$"; :} 
      |  expr:e MINUS  prod:p {: result := "$e$ - $p$"; :} 
      |  prod:p               {: result := "$p$";     :}
      ;
prod ::= prod:p TIMES  fact:f {: result := "$p$ * $f$"; :}
      |  prod:p DIV fact:f {: result := "$p$ / $f$"; :} 
      |  prod:p MOD    fact:f {: result := "$p$ % $f$"; :} 
      |  fact:f               {: result := "$f$";     :}
      ;
fact ::= LPAR expr:e RPAR {: result := "($e$)";   :} 
      |  INTEGER:n             {: result := "$n$";   :} 
      |  DECIMAL:d               {: result := "$d$"; :}
      |  ZID:id_1 LPAR exprList:el RPAR {: result := "$id_1$($join(el, \"\")$)"; :}
      | ZID:id_2 {: result := "$id_2$"; :}
      ;

exprList
    ::= expr:e COMMA neExprList:el {: result := [e] + el; :}
     |  expr:e {: result := [e]; :}
     |  
     ;

neExprList
    ::= expr:e COMMA neExprList:el {: result := [e] + el; :}
     |  expr:e {: result := [e]; :}
     ;

