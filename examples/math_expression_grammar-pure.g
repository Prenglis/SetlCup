

%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;
SKIP          := {WHITESPACE} | \n ;

%%%
arith_expr 
  ::= expr_list:esl                {: :};

expr_list 
    ::= expr_part:part expr_list:l {: :} 
      |                            {: :}
      ;
expr_part 
    ::= expr:e ';'            {: :} ;
expr 
    ::= expr:e '+'  prod:p    {: :} 
      |  expr:e '-'  prod:p   {: :} 
      |  prod:p               {: :}
      ;
prod 
    ::=  prod:p '*'  fact:f   {: :}
      |  prod:p DIVIDE fact:f {: :} 
      |  prod:p '%'    fact:f {: :} 
      |  fact:f               {: :}
      ;
fact 
    ::=  '(' expr:e_part ')'   {: :} 
      |  INTEGER:n             {: :} 
      ;


