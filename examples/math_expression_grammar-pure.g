//Diese Grammatik beschreibt eine einfache arithmetische Grammatik.
%%%

INTEGER       := 0|[1-9][0-9]* ;
WHITESPACE    := [ \t\v\r\s] ;
SKIP          := {WHITESPACE} | \n ;

%%%
arith_expr 
  ::= expr_list                ;

expr_list 
    ::= expr_part expr_list  
      |                            
      ;
expr_part 
    ::= expr ';'             ;
expr 
    ::= expr '+'  prod     
      |  expr '-'  prod    
      |  prod               
      ;
prod 
    ::=  prod '*'  fact   
      |  prod DIVIDE fact  
      |  prod '%'    fact  
      |  fact               
      ;
fact 
    ::=  '(' expr ')'    
      |  INTEGER              
      ;


