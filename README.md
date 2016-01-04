# SetlCup
##Idea
A LR-Parser-Generator for the programming language SetlX oriented on JavaCup
##Requirements
 - Java 1.7+ (Version 51+)
 - Setlx 2.4+
 
## How to call
Setlcup can be called in three ways:
```
setlx setlcup.stlx -p <input_grammar> <file_to_parse>
```
Returns the AST of the file_to_parse
```
setlx setlcup.stlx -p <input_grammar> <file_to_parse> -d
```
Returns the AST of the file_to_parse and outputs information about the parsing process
```
setlx setlcup.stlx -h
```
Shows information about how to call SetlCup correctly
##Tutorial
In the Folder Tutorial a tutorial explains the needed structure of files which can be used as input.
##Example
To parse a simple arithmetic expression grammar you can call:
```
setlx setlcup.stlx -p examples\math_expression_grammar_ast.g examples\math_expression_input.txt -d
```
This will return the following AST:
```
ExprList([
Minus(Plus(Integer(1), Times(Integer(2), Integer(3))), Integer(4)), 
Plus(Plus(Plus(Integer(1), Integer(2)), Integer(3)), Integer(4)), 
Plus(Integer(1), Mod(Times(Times(Integer(2), Integer(3)), Integer(5)), Integer(6)))
])
```
It is derivated from the input file:
```
1 + 2 * 3 - 4;
1 + 2 + 3 + 4;
1 + ( 2 * 3 ) * 5 % 6;
```
