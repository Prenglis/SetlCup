Diese Grammatik beschreibt eine einfache arithmetische Grammatik.
%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;
SKIP          := {WHITESPACE} | \n ;

%%%
arith_expr 
  ::= expr_list:esl                {: result := ExprList(esl); :};

expr_list 
    ::= expr_part:part expr_list:l {: result := [part] + l; :} 
      |                            {: result := []; :}
      ;
expr_part 
    ::= expr:e ';'            {: result := e; :} ;
expr 
    ::= expr:e '+'  prod:p    {: result := Plus(e , p); :} 
      |  expr:e '-'  prod:p   {: result := Minus(e , p); :} 
      |  prod:p               {: result := p;     :}
      ;
prod 
    ::=  prod:p '*'  fact:f   {: result := Times(p , f); :}
      |  prod:p DIVIDE fact:f {: result := Div(p , f); :} 
      |  prod:p '%'    fact:f {: result := Mod(p , f); :} 
      |  fact:f               {: result := f;     :}
      ;
fact 
    ::=  '(' expr:e_part ')'   {: result :=  e_part ;   :} 
      |  INTEGER:n             {: result := Integer(eval(n)); :} 
      ;


