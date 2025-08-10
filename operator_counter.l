%{
#include <stdio.h>

int operator_count = 0;
%}

%%
"+" |
"-" |
"*" |
"/" |
"=" |
"==" |
"!=" |
"<" |
">" |
"<=" |
">=" |
"&&" |
"||" |
"!" { operator_count++; }

.   ;
\n  ;
%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }
    yyin = file;
    yylex();
    printf("Number of operators: %d\\n", operator_count);
    fclose(file);
    return 0;
}
