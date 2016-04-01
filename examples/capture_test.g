Diese Grammatik beschreibt die Zuweisung eines Pfades und gibt diesen ohne Dateieindung zurueck.
%%%

PATH      := "([\\/]?(?:[^\\/]+[\\/])*)([a-zA-Z_0-9][a-zA-Z_0-9\-]*)(?:\..*)?" ;
ZID         := [a-zA-Z_][a-zA-Z0-9_]* ;
SKIP        := {WHITESPACE}|\n|//[^\n]* ;
%%%
program ::= ZID:id ':=' PATH:s {: nPrint(id); nPrint(s); :};