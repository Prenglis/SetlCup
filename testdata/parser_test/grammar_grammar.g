grammar : rule 
         ;
 
 rule : VAR ':' body '|' body  ';' 
      ;
  
 body : item
      ; 
 
 item : VAR     
      | TOKEN   
      | LITERAL 
      ;