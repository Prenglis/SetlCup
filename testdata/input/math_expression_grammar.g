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
NEWLINE := \n ;
WHITESPACE := [ \t\v\n\r\s] ;
MOD := \%;
PLUS  := \+ ;
LPAREN := \( ;
RPAREN := \) ;

%%%

expr_list ::= expr_list expr_part 
           |  expr_part
           ;
expr_part ::= expr:e SEMICOLON {: print("result = $e$"); :}
           ;
expr ::= expr:e PLUS   prod:p {: result := e + p; :} 
      |  expr:e MINUS  prod:p {: result := e - p; :} 
      |  prod:p               {: result := p;     :}
      ;
prod ::= prod:p TIMES  fact:f {: result := p * f; :}
      |  prod:p DIVIDE fact:f {: result := p / f; :} 
      |  prod:p MOD    fact:f {: result := p % f; :} 
      |  fact:f               {: result := f;     :}
      ;
fact ::= LPAREN expr:e RPAREN {: result := e;   :} 
      |  INTEGER:n             {: result := n;   :} 
      ;


