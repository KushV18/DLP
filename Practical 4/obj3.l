%{
#include <stdio.h>

int char_count = 0, word_count = 0, line_count = 0;
int identifier_count = 0, whitespace_count = 0, tabspace_count = 0, special_char_count = 0;
%}

%%
\n          { line_count++; char_count++; }
" "         { whitespace_count++; char_count++; }
"\t"        { tabspace_count++; char_count++; }
[a-zA-Z_][a-zA-Z0-9_]* { identifier_count++; char_count += yyleng; }
[a-zA-Z0-9\+\=]+ { word_count++; char_count += yyleng; }
.           { special_char_count++; char_count++; }
%%

int main() {
    printf("Enter text (press Ctrl+Z followed by Enter to end input on Windows):\n");
    yylex();

    if (char_count > 0 && line_count == 0) {
        line_count = 1;
    }

    if (line_count == 0) {
        line_count = 1;
    }

    printf("\n--- Results ---\n");
    printf("Characters : %d\n", char_count);
    printf("Words : %d\n", word_count);
    printf("Lines : %d\n", line_count);
    printf("Identifiers : %d\n", identifier_count);
    printf("Whitespaces : %d\n", whitespace_count);
    printf("Tabspaces : %d\n", tabspace_count);
    printf("Special characters : %d\n", special_char_count);
   
    printf("\nPress Enter to exit...");
    getchar();  /* Wait for user to press Enter */
    
    return 0;
}

int yywrap() {
    return 1;
}