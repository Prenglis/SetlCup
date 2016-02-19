Diese Grammatik beschreibt den Aufbau eines Parsers für eine einfache Programmiersprache.
%%%

STRING      := \"(?:\\.|[^\"])*\" ;
WHITESPACE  := [ \t\v\r\s] ;
SKIP        := {WHITESPACE}|\n|//[^\n]* ;
INTEGER     := 0|[1-9][0-9]* ;
DECIMAL     := 0\.[0-9]+|[1-9][0-9]*\.[0-9]+ ;
ZID         := [a-zA-Z_][a-zA-Z0-9_]* ;
%%%
program 
    ::= dfnStmntList:d {: result := Program(d); :}
    ;

dfnStmntList 
    ::= definition:d dfnStmntList:dl {: result := [d] + dl; :}
     |  statement:stmts  dfnStmntList:dsl {: result := [stmts] + dsl; :}
     | {: result := []; :}
     ;

definition 
    ::= 'function' ZID:function_name '(' paramList:param_list ')' '{' stmntList:statement_list '}'
        {: result := Function(function_name, param_list, statement_list);:}
     ;

stmntList
    ::= statement:s stmntList:sl {: result := [s] + sl ; :}
     |  {: result := []; :}
     ;

statement 
    ::= assignment:a ';'                                    {: result := Assignment(a); :}    
     |  'print' '(' printExprList:printexpr_list ')' ';'      {: result := Print(printexpr_list); :}
     |  'if' '(' boolExpr:b ')' '{' stmntList:st_list1 '}'    {: result := If(b, st_list1); :}
     |  'while' '(' boolExpr:b ')' '{' stmntList:st_list2 '}' {: result := While(b, st_list2); :}
     |  'for' '(' assignment:i_a ';' boolExpr:b ';' assignment:e_a ')' '{' stmntList:st_list3 '}' 
                                                            {: result := For(i_a, b, e_a, st_list3);  :}
     |  'return' expr:e ';'                                   {: result := Return(e); :}
     |  'return' ';'                                          {: result := Return(); :}
     |  expr:e ';'                                          {: result := Expr(e); :}      
     |  'quit' ';'                                            {: result := Exit(); :}
     ;

printExprList 
    ::= printExpr:p ',' nePrintExprList:np {: result := [p] + np ; :}
     |  printExpr:p                        {: result := [p]; :}
     |                                     {: result := []; :}
     ;

nePrintExprList
    ::= printExpr:p                        {: result := [p]; :}
     |  printExpr:p ',' nePrintExprList:np {: result := [p] + np ; :}
     ;

printExpr 
    ::= STRING:string {: result := PrintString(string); :}
     |  expr:e        {: result := e; :}
     ;

assignment 
    ::= ZID:id '=' expr:e {: result := Assign(id, e); :}
     ;

paramList 
    ::= ZID:id ',' neIDList:nid {: result := [id] + nid ; :}
     |  ZID:id                  {: result := [id] ; :}
     |                          {: result := []; :}
     ;

neIDList
    ::= ZID:id ',' neIDList:nid {: result := [id] + nid ; :}
     |  ZID:id                  {: result := [id] ; :}
     ;


boolExpr 
    ::= expr:lhs '==' expr:rhs                {: result := Equation(lhs,rhs); :}
     |  expr:lhs '!=' expr:rhs                {: result := Inequation(lhs,rhs); :}
     |  disjunction:lhs '==' disjunction:rhs  {: result := Equation(lhs,rhs); :}
     |  disjunction:lhs '!=' disjunction:rhs  {: result := Inequation(lhs,rhs); :}
     |  expr:lhs '<=' expr:rhs                {: result := LessOrEqual(lhs,rhs); :}
     |  expr:lhs '>=' expr:rhs                {: result := GreaterOrEqual(lhs,rhs); :}
     |  expr:lhs '<' expr:rhs                 {: result := LessThan(lhs,rhs); :}
     |  expr:lhs '>' expr:rhs                 {: result := GreaterThan(lhs,rhs); :}
     |  disjunction:d                         {: result := d; :}
     ;
disjunction
    ::= disjunction:d '||' conjunction:c {: result := Disjunction(d,c); :}
     |  conjunction:c                    {: result := c; :}
     ;
conjunction
    ::= conjunction:c '&&' boolFactor:f {:result := Conjunction(c,f); :}
     | boolFactor:f                     {: result := f; :}
     ;
boolFactor
    ::= '(' boolExpr:be_par ')' {:  result := be_par; :}
     | '!' boolExpr:e           {: result := Negation(e); :}
     ;


expr 
    ::= expr:e '+'   prod:p {: result := Sum(e,p); :} 
      |  expr:e '-'  prod:p {: result := Difference(e,p); :} 
      |  prod:p             {: result := p;     :}
      ;
prod 
    ::= prod:p '*'  fact:f    {: result := Product(p,f); :}
      |  prod:p '\' fact:f    {: result := Quotient(p,f); :} 
      |  prod:p '%'    fact:f {: result := Mod(p,f); :} 
      |  fact:f               {: result := f;     :}
      ;
fact 
    ::= '(' expr:e_par ')'            {: result := e_par;   :} 
      |  INTEGER:n                    {: result := Integer(eval(n));   :} 
      |  DECIMAL:d                    {: result := Decimal(eval(d)); :}
      |  ZID:id_1 '(' exprList:el ')' {: result := FunctionCall(id_1,el); :}
      |  ZID:id_2                     {: result := Variable(id_2); :}
      ;

exprList
    ::= expr:e ',' neExprList:el {: result := [e] + el; :}
     |  expr:e                   {: result := [e]; :}
     |                           {: result := []; :}
     ;

neExprList
    ::= expr:e ',' neExprList:el {: result := [e] + el; :}
     |  expr:e                   {: result := [e]; :}
     ;

