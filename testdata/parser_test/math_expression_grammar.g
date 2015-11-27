// CUP specification for a simple expression evaluator (with actions)
import java_cup.runtime.*;
class  ExprParser;

/* Terminals (tokens returned by the scanner). */
terminal            SEMI, PLUS, MINUS, TIMES, DIVIDE, MOD;
terminal            LPAREN, RPAREN;
terminal Integer    NUMBER;

/* Non-terminals */
nonterminal         expr_list, expr_part;
nonterminal Integer expr, prod, fact;

start with expr_list;
/* The grammar */

%%%

SEMICOLON := \; ;
TIMES := \* ;
MINUS   := \- ;
DIVIDE   := \\ ;
INTEGER     := 0|[1-9][0-9]* ;
WHITESPACE := [ \t\v\n\r] ;
PLUS  := \+ ;
EXCEPTION := [^] ;

%%%

expr_list ::= expr_list expr_part 
           |  expr_part
           ;
expr_part ::= expr:e {: System.out.println("result = " + e); :} SEMI 
           ;
expr ::= expr:e PLUS   prod:p {: RESULT = e + p; :} 
      |  expr:e MINUS  prod:p {: RESULT = e - p; :} 
      |  prod:p               {: RESULT = p;     :}
      ;
prod ::= prod:p TIMES  fact:f {: RESULT = p * f; :}
      |  prod:p DIVIDE fact:f {: RESULT = p / f; :} 
      |  prod:p MOD    fact:f {: RESULT = p % f; :} 
      |  fact:f               {: RESULT = f;     :}
      ;
fact ::= LPAREN expr:e RPAREN {: RESULT = e;   :} 
      |  NUMBER:n             {: RESULT = n;   :} 
      ;


