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
setlx setlcup.stlx -p <input_file>
```
Creates the Parser in the file  input_file_Grammar.stlx (in the directory of the input-file)
```
setlx setlcup.stlx -p <input_file> -d
```
Creates the Parser in the file input_file_Grammar.stlx (in the directory of the input-file) and outputs information about the creation process
```
setlx setlcup.stlx -p -h
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
load('examples\math_expression_grammar_astGrammar.stlx');
result := test_parser_from_file('examples\math_expression_input.txt', true);
```
##Tutorial
In the Folder Tutorial a tutorial explains the needed structure of files which can be used as input.
##Example
To parse a simple arithmetic expression grammar you can call:
```
setlx setlcup.stlx -p examples/math_simple_expression.g
setlx math_simple_expressionGrammar.stlx -p simple_statement.txt
```
This will return the output:
```
38
```
It is derivated from the input file:
```
4*5+3*6
```
