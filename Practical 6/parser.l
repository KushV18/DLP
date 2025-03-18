%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int valid = 1;  // Flag to track if string is valid
%}

%% 

"("      { return '('; }
")"      { return ')'; }
","      { return ','; }
"a"      { return 'a'; }
[ \t\n]+ ; // Ignore whitespace
.        { valid = 0; return yytext[0]; }

%% 

// Forward declarations for recursive descent parser functions
int parse_S();
int parse_L();
int parse_L_prime();

// Current token and functions to manage tokens
int current_token = 0;
int token_index = 0;
#define MAX_TOKENS 100
int tokens[MAX_TOKENS];

// Function to match and consume a token
int match(int expected) {
    if (token_index >= current_token) return 0;
    
    if (tokens[token_index] == expected) {
        token_index++;
        return 1;
    }
    return 0;
}

// S → ( L ) | a
int parse_S() {
    // Try a
    if (match('a')) {
        return 1;
    }
    
    // Try ( L )
    int saved_index = token_index;
    if (match('(')) {
        if (parse_L()) {
            if (match(')')) {
                return 1;
            }
        }
    }
    
    // Backtrack if the above failed
    token_index = saved_index;
    return 0;
}

// L → S L'
int parse_L() {
    int saved_index = token_index;
    if (parse_S()) {
        if (parse_L_prime()) {
            return 1;
        }
    }
    
    // Backtrack if the above failed
    token_index = saved_index;
    return 0;
}

// L' → , S L' | ε
int parse_L_prime() {
    int saved_index = token_index;
    
    // Try , S L'
    if (match(',')) {
        if (parse_S()) {
            if (parse_L_prime()) {
                return 1;
            }
        }
        // If failed, backtrack
        token_index = saved_index;
        return 0;
    }
    
    // ε production - always succeeds
    return 1;
}

// Function to process and validate a string
void process_input(const char* input_string) {
    // Reset the lexer with the new input string
    YY_BUFFER_STATE buffer = yy_scan_string(input_string);
    
    // Reset validation flag and token count
    valid = 1;
    current_token = 0;
    
    // Run lexer on the input
    int token;
    while ((token = yylex()) != 0 && current_token < MAX_TOKENS) {
        tokens[current_token++] = token;
    }
    
    // Delete buffer to avoid memory leak
    yy_delete_buffer(buffer);
    
    // Parse the tokens
    token_index = 0;
    if (valid && parse_S() && token_index == current_token) {
        printf("Valid string\n");
    } else {
        printf("Invalid string\n");
    }
}

int main(int argc, char **argv) {
    char input[1024];
    
    if (argc > 1) {
        // If command-line argument is provided, use it as input
        process_input(argv[1]);
    } else {
        // Interactive mode
        printf("Enter strings to validate (enter 'exit' to quit):\n");
        while (1) {
            printf("> ");
            if (fgets(input, sizeof(input), stdin) == NULL) {
                break;
            }
            
            // Remove trailing newline
            size_t len = strlen(input);
            if (len > 0 && input[len-1] == '\n') {
                input[len-1] = '\0';
            }
            
            // Check for exit command
            if (strcmp(input, "exit") == 0) {
                break;
            }
            
            // Process the input
            process_input(input);
        }
    }
    
    return 0;
}

int yywrap() {
    return 1;
}