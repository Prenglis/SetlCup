

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

expr_list ::= expr_list:l expr_part:part {: result := l + [part]; :} 
           |  expr_part:epart {: result := [epart]; :}
           ;
expr_part ::= expr:e SEMICOLON {: result := e; :}
           ;
expr ::= expr:e PLUS   prod:p {: result := Plus(e , p); :} 
      |  expr:e MINUS  prod:p {: result := Minus(e , p); :} 
      |  prod:p               {: result := p;     :}
      ;
prod ::= prod:p TIMES  fact:f {: result := Times(p , f); :}
      |  prod:p DIVIDE fact:f {: result := Div(p , f); :} 
      |  prod:p MOD    fact:f {: result := Mod(p , f); :} 
      |  fact:f               {: result := f;     :}
      ;
fact ::= LPAREN expr:e_part RPAREN {: result :=  e_part ;   :} 
      |  INTEGER:n             {: result := Integer(eval(n)); :} 
      ;


