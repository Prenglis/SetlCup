Diese Grammatik beschreibt den Aufbau eines Parsers für eine einfache Programmiersprache.
%%%

STRING      := \"([^\\"]|\\.)*\" ;
ZID         := [a-zA-Z_][a-zA-Z0-9_]* ;
SKIP        := {WHITESPACE}|\n|//[^\n]* ;
%%%
program := ZID:id ':=' STRING:s {: nPrint(id); nPrint(':='); nPrint(s); :}
