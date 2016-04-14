Diese Grammatik beschreibt eine einfache arithmetische Grammatik.
%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;


SKIP          := {WHITESPACE} | \n ;

%%%
expr 
    ::= expr:e '+'  expr:e     {: result := Plus(e , p);      :} 
      | expr:e '*'  expr:e     {: result := Times(p , f);     :}
      |  INTEGER:n             {: result := Integer(eval(n)); :} 
      ;


