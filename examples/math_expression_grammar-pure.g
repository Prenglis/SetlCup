

%%%

SEMICOLON := ; ;
TIMES := \* ;
MINUS   := - ;
DIVIDE   := \\ ;
INTEGER     := 0|[1-9][0-9]* ;
NEWLINE := \n ;
WHITESPACE := [ \t\v\n\r\s] ;
MOD := %;
PLUS  := \+ ;
LPAREN := \( ;
RPAREN := \) ;
SKIP := WHITESPACE | NEWLINE ;

%%%
arith_expr ::= expr_list:esl {: :};

expr_list ::= expr_part:part expr_list:l {: :} 
           |  {: :}
           ;
expr_part ::= expr:e SEMICOLON {: :}
           ;
expr ::= expr:e PLUS   prod:p {: :} 
      |  expr:e MINUS  prod:p {: :} 
      |  prod:p               {: :}
      ;
prod ::= prod:p TIMES  fact:f {: :}
      |  prod:p DIVIDE fact:f {: :} 
      |  prod:p MOD    fact:f {: :} 
      |  fact:f               {: :}
      ;
fact ::= LPAREN expr:e_part RPAREN {: :} 
      |  INTEGER:n             {: :} 
      ;




%%%

SEMICOLON := ; ;
TIMES := \* ;
MINUS   := - ;
DIVIDE   := \\ ;
INTEGER     := 0|[1-9][0-9]* ;
NEWLINE := \n ;
WHITESPACE := [ \t\v\n\r\s] ;
MOD := %;
PLUS  := \+ ;
LPAREN := \( ;
RPAREN := \) ;
SKIP := WHITESPACE | NEWLINE ;

%%%

expr_list ::= expr_list expr_part 
           |  expr_part
           ;
expr_part ::= expr:e SEMICOLON 
           ;
expr ::= expr:e PLUS   prod:p  
      |  expr:e MINUS  prod:p 
      |  prod:p              
      ;
prod ::= prod:p TIMES  fact:f 
      |  prod:p DIVIDE fact:f  
      |  prod:p MOD    fact:f 
      |  fact:f               
      ;
fact ::= LPAREN expr:e RPAREN  
      |  INTEGER:n             
      ;


