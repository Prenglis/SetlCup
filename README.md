# SetlCup
##Idea
A LR-Parser-Generator for the programming language SetlX oriented on JavaCup
##Requirements
 - Java 1.7+ (Version 51+)
 - Setlx 2.4+
 
## How to call
Setlcup can be called in multiple ways:
### Command Line
```
setlx setlcup.stlx -p <input_grammar>
```
Creates the Parser in the file _Grammar.stlx
```
setlx setlcup.stlx -p <input_grammar> -d
```
Creates the Parser in the file _Grammar.stlx and outputs information about the creation process
```
setlx setlcup.stlx -h
```
Shows information about how to call SetlCup correctly
#### Testing
```
setlx test_setlcup.stlx
```
This programm test the parsergeneration with the given examples.
### In Setlx
You need to load the program "setlcup_load.stlx"
```
load("setlcup_load.stlx");
```
Afterwards Setlcup can be used via the method call
```
generate_parser(input_grammar, silent_mode);
```
e.g.
```
load("setlcup_load.stlx");
generate_parser('examples\math_expression_grammar_ast.g', true);
load("math_expression_grammar_astGrammar.stlx");
result := test_parser('examples\math_expression_input.txt', true);
```
##Tutorial
In the Folder Tutorial a tutorial explains the needed structure of files which can be used as input.
##Example
To parse a simple arithmetic expression grammar you can call:
```
setlx setlcup.stlx -p examples\math_expression_grammar_ast.g
setlx math_expression_grammar_astGrammar.stlx -p examples\math_expression_input.txt -d > test_output.stlx
```
This will return the debugging Log aswell as the following AST in the file 'test_output.stlx':
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
