%{
#include<stdio.h>
%}

%%
"http://"[a-zA-Z0-9./-]+                                 { printf("Valid URL found: %s\n", yytext); }
"https://"[a-zA-Z0-9./-]+                                { printf("Valid URL found: %s\n", yytext); }
[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]        { printf("Valid mobile number found: %s\n", yytext); }
[a-zA-Z_][a-zA-Z_0-9]*                                  { printf("Valid identifier found: %s\n", yytext); }
[0-9][0-9]"/"[0-9][0-9]"/"[0-9][0-9][0-9][0-9]            { printf("Valid date found: %s\n", yytext); }
[0-9][0-9]":"[0-9][0-9]":"[0-9][0-9]                      { printf("Valid time found: %s\n", yytext); }

[ \t\n]+                                                ; /* Ignore whitespace */
.                                                       ; /* Ignore other characters */
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
    fclose(file);
    return 0;
}

int yywrap(void) {
    return 1;
}
