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
grammar ::= expr_list
          ;
          
expr_list ::= expr_list expr_part 
           |  expr_part
           ;
expr_part ::= expr SEMI 
           ;
expr ::= expr PLUS   prod 
      |  expr MINUS  prod 
      |  prod              
      ;
prod ::= prod TIMES  fact
      |  prod DIVIDE fact
      |  prod MOD    fact
      |  fact               
      ;
fact ::= LPAREN expr RPAREN  
      |  NUMBER             
      ;


