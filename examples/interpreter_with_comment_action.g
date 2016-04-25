//Diese Grammatik beschreibt den Aufbau eines Parsers fuer eine simple Programmiersprache.
parseElement := closure(element, rw values){
  match(element){
    case Program(d):
      parseElement(d, values);
    case [h|t]:
      parseElement(h, values);
      parseElement(t, values);
    case Assignment(id, e_1):
      values["$id$"] := parseElement(e_1,values);
    case PrintExpr(e_2):
      print(parseElement(e_2, values));
    case Sum(e,p):
      return parseElement(e, values) + parseElement(p, values);
    case Difference(e,p):
      return parseElement(e, values) - parseElement(p, values);
    case Product(p,f):
      return parseElement(p, values) * parseElement(f, values);
    case Quotient(p,f):
      return parseElement(p, values) / parseElement(f, values);
    case Integer(n):
      return n;
    case Variable(id_1):
      return values[id_1];
  }
};
%%%

WHITESPACE  := [ \t\v\r\s] ;
INTEGER     := 0|[1-9][0-9]* ;
ZID         := [a-zA-Z_][a-zA-Z0-9_]* ;
SKIP        := {WHITESPACE}|\n|//[^\n]* ;
%%%
  file
    ::= program:p                          {: parseElement(p, {});           :}
    ;
  program 
    ::= stmntList:d                        {: result := Program(d);          :}
    ;
  stmntList
    ::= statement:s stmntList:sl           {: result := [s] + sl ;           :}
     |                                     {: result := [];                  :}
     ;
  statement 
   ::= ZID:id '=' expr:e_1 ';'             {: result := Assignment(id, e_1); :}    
     |  'print' '(' expr:e_2 ')' ';'      
                                           {: result := PrintExpr(e_2);      :}
     ;

expr 
    ::= expr:e '+'   prod:p                {: result := Sum(e,p);            :} 
      |  expr:e '-'  prod:p                {: result := Difference(e,p);     :} 
      |  prod:p                            {: result := p;                   :}
      ;
prod 
    ::= prod:p '*'  fact:f                 {: result := Product(p,f);        :}
      |  prod:p '/' fact:f                 {: result := Quotient(p,f);       :} 
      |  fact:f                            {: result := f;                   :}
      ;
fact 
    ::= '(' expr:e_par ')'                 {: result := e_par;               :} 
      |  INTEGER:n                         {: result := Integer(eval(n));    :} 
      |  ZID:id_1                          {: result := Variable(id_1);      :}
      ;
