//Diese Grammatik beschreibt einen simplen  arithmetischen Ausdruck.
%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;
SKIP          := {WHITESPACE} | \n ;

%%%
term 
    ::= expr:e                {: print(e);             :}
      ;
expr 
    ::= expr:e '+'  prod:p     {: result := e+p;        :}
      |  prod:p                {: result := p;          :}
      ;
prod 
    ::=  prod:p '*'  fact:f    {: result := p*f;        :}
      | fact:f                 {: result := f;          :}
      ;
fact 
    ::=  INTEGER:n             {: result := eval(n);    :}     
      ;


