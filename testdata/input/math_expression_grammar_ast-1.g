

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
arith_expr ::= expr_list:esl {: result := ExprList(esl[-1]); esl := esl[..-2];:};

expr_list ::= expr_part:part expr_list:l {: result := [part[-1]] + l[-1]; part := part[..-2]; l := l[..-2]; :} 
           |  {: result := []; :}
           ;
expr_part ::= expr:e SEMICOLON {: result := e[-1]; e := e[..-2]; :}
           ;
expr ::= expr:e PLUS   prod:p {: result := Plus(e[-1] , p[-1]); e := e[..-2]; p := p[..-2];:} 
      |  expr:e MINUS  prod:p {: result := Minus(e[-1] , p[-1]); e := e[..-2]; p := p[..-2];:} 
      |  prod:p               {: result := p[-1];  p := p[..-2];:}
      ;
prod ::= prod:p TIMES  fact:f {: result := Times(p[-1] , f[-1]); p := p[..-2]; f := f[..-2];:}
      |  prod:p DIVIDE fact:f {: result := Div(p[-1] , f[-1]); p := p[..-2]; f := f[..-2];:} 
      |  prod:p MOD    fact:f {: result := Mod(p[-1] , f[-1]); p := p[..-2]; f := f[..-2];:} 
      |  fact:f               {: result := f[-1];   f := f[..-2];:}
      ;
fact ::= LPAREN expr:e_part RPAREN {: result :=  e_part[-1] ; e_part := e_part[..-2];   :} 
      |  INTEGER:n             {: result := Integer(eval(n[-1]));  n := n[..-2];:} 
      ;


