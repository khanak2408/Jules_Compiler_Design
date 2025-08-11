%{
#include<stdio.h>
int vowels = 0;
int consonants = 0;
%}

%%
[aeiouAEIOU]   { vowels++; }
[a-zA-Z]       { consonants++; }
.|\n           ; /* Ignore all other characters */
%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        printf("Could not open file: %s\n", argv[1]);
        return 1;
    }
    yyin = file;
    yylex();
    printf("Vowels: %d\n", vowels);
    printf("Consonants: %d\n", consonants);
    fclose(file);
    return 0;
}

int yywrap(void) {
    return 1;
}
