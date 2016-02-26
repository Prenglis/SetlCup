Diese Grammatik beschreibt den Aufbau eines Parsers für eine einfache Programmiersprache.
%%%

  STRING      := \"(?:\\.|[^\"])*\" ;
  WHITESPACE  := [ \t\v\r\s] ;
  INTEGER     := 0|[1-9][0-9]* ;
  DECIMAL     := 0\.[0-9]+|[1-9][0-9]*\.[0-9]+ ;
  ZID         := [a-zA-Z_][a-zA-Z0-9_]* ;

  SKIP        := {WHITESPACE}|\n|//[^\n]* ;
%%%
  program 
    ::= dfnStmntList 
    ;

  dfnStmntList 
   ::= definition dfnStmntList       
     |  statement  dfnStmntList 
     |                                    
     ;

  definition
   ::= 'function' ZID '(' paramList ')' '{' stmntList '}'      
     ; 
  stmntList
    ::= statement stmntList 
     |  
     ;
  statement 
   ::= assignment ';'       
     |  'print' '(' printExprList ')' ';'     
     |  'if' '(' boolExpr ')' '{' stmntList '}'    
     |  'while' '(' boolExpr ')' '{' stmntList '}' 
     |  'for' '(' assignment ';' boolExpr ';' assignment ')' '{' stmntList '}' 
     |  'return' expr ';' 
     |  'return' ';'        
     |  expr ';'              
     |  'quit' ';'          
     ;

printExprList 
    ::= printExpr ',' nePrintExprList 
     |  printExpr                        
     |                                     
     ;

nePrintExprList
    ::= printExpr                        
     |  printExpr ',' nePrintExprList 
     ;

printExpr 
    ::= STRING 
     |  expr        
     ;

assignment 
    ::= ZID '=' expr 
     ;

paramList 
    ::= ZID ',' neIDList 
     |  ZID                  
     |                          
     ;

neIDList
    ::= ZID ',' neIDList 
     |  ZID                  
     ;


boolExpr 
    ::= expr '==' expr                
     |  expr '!=' expr                
     |  disjunction '==' disjunction  
     |  disjunction '!=' disjunction  
     |  expr '<=' expr                
     |  expr '>=' expr                
     |  expr '<' expr                 
     |  expr '>' expr                 
     |  disjunction                         
     ;
disjunction
    ::= disjunction '||' conjunction 
     |  conjunction                    
     ;
conjunction
    ::= conjunction '&&' boolFactor 
     | boolFactor                     
     ;
boolFactor
    ::= '(' boolExpr ')' 
     | '!' boolExpr           
     ;


expr 
    ::= expr '+'   prod  
      |  expr '-'  prod  
      |  prod             
      ;
prod 
    ::= prod '*'  fact    
      |  prod '\' fact     
      |  prod '%'    fact  
      |  fact               
      ;
fact 
    ::= '(' expr ')'             
      |  INTEGER                     
      |  DECIMAL                    
      |  ZID '(' exprList ')' 
      |  ZID                     
      ;

exprList
    ::= expr ',' neExprList 
     |  expr                   
     |                           
     ;

neExprList
    ::= expr ',' neExprList 
     |  expr                   
     ;

