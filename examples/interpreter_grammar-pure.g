
%%%

FUNCTION    := function ;
RETURN      := return ;
IF          := if ;
ELSE        := else ;
WHILE       := while ;
FOR         := for ;
PRINT       := print ;
QUIT        := exit ;
STRING      := \"(?:\\.|[^\"])*\" ;
WHITESPACE  := [ \t\v\r\s] ;
SKIP        := {WHITESPACE}|\n|//[^\n]* ;
INTEGER     := 0|[1-9][0-9]* ;
DECIMAL     := 0\.[0-9]+|[1-9][0-9]*\.[0-9]+ ;
ZID         := [a-zA-Z_][a-zA-Z0-9_]* ;


%%%
program 
    ::= dfnStmntList:d {: :}
    ;

dfnStmntList 
    ::= definition:d dfnStmntList:dl {: :}
     |  statement:stmts  dfnStmntList:dsl {: :}
     | {: :}
     ;

definition 
    ::= FUNCTION ZID:function_name '(' paramList:param_list ')' '{' stmntList:statement_list '}'
        {: :}
     ;

stmntList
    ::= statement:s stmntList:sl {: :}
     |  {: :}
     ;

statement 
    ::= assignment:a ';'                                    {: :}    
     |  PRINT '(' printExprList:printexpr_list ')' ';'      {: :}
     |  IF '(' boolExpr:b ')' '{' stmntList:st_list1 '}'    {: :}
     |  WHILE '(' boolExpr:b ')' '{' stmntList:st_list2 '}' {: :}
     |  FOR '(' assignment:i_a ';' boolExpr:b ';' assignment:e_a ')' '{' stmntList:st_list3 '}' 
                                                            {: :}
     |  RETURN expr:e ';'                                   {: :}
     |  RETURN ';'                                          {: :}
     |  expr:e ';'                                          {: :}      
     |  QUIT ';'                                            {: :}
     ;

printExprList 
    ::= printExpr:p ',' nePrintExprList:np {: :}
     |  printExpr:p                        {: :}
     |                                     {: :}
     ;

nePrintExprList
    ::= printExpr:p                        {: :}
     |  printExpr:p ',' nePrintExprList:np {: :}
     ;

printExpr 
    ::= STRING:string {: :}
     |  expr:e        {: :}
     ;

assignment 
    ::= ZID:id '=' expr:e {: :}
     ;

paramList 
    ::= ZID:id ',' neIDList:nid {: :}
     |  ZID:id                  {: :}
     |                          {: :}
     ;

neIDList
    ::= ZID:id ',' neIDList:nid {: :}
     |  ZID:id                  {: :}
     ;


boolExpr 
    ::= expr:lhs '==' expr:rhs                {: :}
     |  expr:lhs '!=' expr:rhs                {: :}
     |  disjunction:lhs '==' disjunction:rhs  {: :}
     |  disjunction:lhs '!=' disjunction:rhs  {: :}
     |  expr:lhs '<=' expr:rhs                {: :}
     |  expr:lhs '>=' expr:rhs                {: :}
     |  expr:lhs '<' expr:rhs                 {: :}
     |  expr:lhs '>' expr:rhs                 {: :}
     |  disjunction:d                         {: :}
     ;
disjunction
    ::= disjunction:d '||' conjunction:c {: :}
     |  conjunction:c                    {: :}
     ;
conjunction
    ::= conjunction:c '&&' boolFactor:f {: :}
     | boolFactor:f                     {: :}
     ;
boolFactor
    ::= '(' boolExpr:be_par ')' {: :}
     | '!' boolExpr:e           {: :}
     ;


expr 
    ::= expr:e '+'   prod:p {: :} 
      |  expr:e '-'  prod:p {: :} 
      |  prod:p             {: :}
      ;
prod 
    ::= prod:p '*'  fact:f    {: :}
      |  prod:p '\' fact:f    {: :} 
      |  prod:p '%'    fact:f {: :} 
      |  fact:f               {: :}
      ;
fact 
    ::= '(' expr:e_par ')'            {: :} 
      |  INTEGER:n                    {: :} 
      |  DECIMAL:d                    {: :}
      |  ZID:id_1 '(' exprList:el ')' {: :}
      |  ZID:id_2                     {: :}
      ;

exprList
    ::= expr:e ',' neExprList:el {: :}
     |  expr:e                   {: :}
     |                           {: :}
     ;

neExprList
    ::= expr:e ',' neExprList:el {: :}
     |  expr:e                   {: :}
     ;

