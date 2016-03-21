Diese Grammatik beschreibt einen simplen  arithmetischen Ausdruck.
%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;
SKIP          := {WHITESPACE} | \n ;

%%%
expr 
    ::= expr:e '+'  prod:p     {: print(e+p); :}
      |  prod:p               {: result := p; :}
      ;
prod 
    ::=  prod:p '*'  fact:f   {: result := p*f; :}
      |  fact:f              {: result := f; :}               
      ;
fact 
    ::=  '(' expr:e ')'    {: result := e; :}
      |  INTEGER:n         {: result := eval(n); :}     
      ;


