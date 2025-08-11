%{
#include<stdio.h>
int lines=0, words=0, spaces=0;
%}

%%
\n      { lines++; }
[ \t]   { spaces++; }
[^\t\n ]+ { words++; }
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
    printf("Lines: %d\n", lines);
    printf("Words: %d\n", words);
    printf("Spaces: %d\n", spaces);
    fclose(file);
    return 0;
}

int yywrap(void) {
    return 1;
}
