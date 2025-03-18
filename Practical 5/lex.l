%{
#include <stdio.h>
#include <stdlib.h>
%}


DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z0-9_]*  // Allow underscores at the start of identifiers

%% 

"int" { printf("Keyword: int\n"); }
"char" { printf("Keyword: char\n"); }
"return" { printf("Keyword: return\n"); }
"if" { printf("Keyword: if\n"); }
"else" { printf("Keyword: else\n"); }
"while" { printf("Keyword: while\n"); }
"for" { printf("Keyword: for\n"); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Identifier: %s\n", yytext); }
"=" { printf("Operator: =\n"); }
"\\+" { printf("Operator: +\n"); }
"-" { printf("Operator: -\n"); }
"\\*" { printf("Operator: *\n"); }
"/" { printf("Operator: /\n"); }
[0-9]+ { printf("Constant: %s\n", yytext); }
"'"[^']"'" { printf("Character: '%s'\n", yytext); } // Changed to Character
\"[^\"]*\" { printf("String: \"%s\"\n", yytext); } // Added string handling
"(" { printf("Punctuation: (\n"); }
")" { printf("Punctuation: )\n"); }
"{" { printf("Punctuation: {\n"); }
"}" { printf("Punctuation: }\n"); }
"," { printf("Punctuation: ,\n"); }
";" { printf("Punctuation: ;\n"); }
[ \t\n]+ ; // Ignore whitespace
. { printf("Unknown token: %s\n", yytext); }

%% 

int main(int argc, char **argv) {
    printf("TOKENS\n");
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}