%{
#include <stdio.h>
#include <string.h>
int has_upper = 0, has_lower = 0, has_digit = 0, has_symbol = 0;
%}

%%

[A-Z]      { has_upper = 1; }
[a-z]      { has_lower = 1; }
[0-9]      { has_digit = 1; }
[*;#$@]    { has_symbol = 1; }

%%

int main() {
    char password[100];
    printf("Enter password: ");
    scanf("%s", password);
    int length = strlen(password);
    
    // Reset flags to handle multiple password checks in the same session
    has_upper = 0;
    has_lower = 0;
    has_digit = 0;
    has_symbol = 0;
    
    if (length < 9 || length > 15) {
        printf("Invalid password (length must be 9-15 characters)\n");
    } else {
        yy_scan_string(password);
        yylex();
        if (has_upper && has_lower && has_digit && has_symbol) {
            printf("Valid password\n");
        } else {
            printf("Invalid password (missing required character types)\n");
        }
    }
    
    // Pause the console before exiting
    printf("\nPress Enter to exit...");
    getchar(); // Clear the newline from scanf
    getchar(); // Wait for user to press Enter
    
    return 0;
}

int yywrap() {
    return 1;
}