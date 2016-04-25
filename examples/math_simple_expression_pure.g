//Diese Grammatik beschreibt einen simplen  arithmetischen Ausdruck.
%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;
SKIP          := {WHITESPACE} | \n ;

%%%
expr 
    ::= expr '+'  prod     
      |  prod               
      ;
prod 
    ::=  prod '*'  fact   
      |  fact               
      ;
fact 
    ::=  '(' expr ')'    
      |  INTEGER              
      ;


