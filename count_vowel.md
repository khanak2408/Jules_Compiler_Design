# Documentation for count_vowel.l

This document provides a detailed explanation for the LEX program `count_vowel.l`, which is designed to count the total number of vowels and consonants from a given input file.

## Program Logic

The program is structured into the three standard sections of a LEX file: the definition section, the rules section, and the user code section. The program processes an input file character by character and applies the rules to identify and count vowels and consonants.

### 1. Definition Section

```c
%{
#include<stdio.h>
int vowels = 0;
int consonants = 0;
%}
```

- In this section, we include the standard C input/output library, `stdio.h`.
- We declare two global integer variables, `vowels` and `consonants`, and initialize them to zero. These variables will store the counts of vowels and consonants found in the input file.

### 2. Rules Section

```lex
%%
[aeiouAEIOU]   { vowels++; }
[a-zA-Z]       { consonants++; }
.|\n           ; /* Ignore all other characters */
%%
```

This section contains the core logic of the program. It defines patterns that the lexer will match against the input text and the corresponding actions to take.

- `[aeiouAEIOU]   { vowels++; }`: This rule defines a pattern that matches any uppercase or lowercase vowel. When a vowel is found, the `vowels` counter is incremented.

- `[a-zA-Z]       { consonants++; }`: This rule matches any uppercase or lowercase letter of the alphabet. Since this rule appears after the vowel rule, it will only be triggered for letters that are not vowels. This is because `lex` follows a "first match" principle. When a consonant is found, the `consonants` counter is incremented.

- `.|\n           ;`: This rule matches any character (`.`) or a newline character (`\n`) that was not matched by the previous rules. The action is an empty statement (`;`), which means these characters (like numbers, punctuation, spaces, etc.) are effectively ignored.

### 3. User Code Section

```c
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
```

- The `main` function serves as the entry point for the program. It requires a single command-line argument: the path to the input file.
- It opens the specified file and assigns it to `yyin`, which is the standard input stream for the lexer.
- The `yylex()` function is then called to start the lexical analysis process.
- Once `yylex()` has processed the entire file, the program prints the final counts of `vowels` and `consonants`.
- The `yywrap()` function is a standard lex function that is called at the end of the input. Returning `1` signifies that there are no more files to process.

## How to Compile and Run

1.  **Compile the LEX program**:
    ```bash
    lex count_vowel.l
    ```
    This command generates a C source file named `lex.yy.c`.

2.  **Compile the generated C code**:
    ```bash
    gcc lex.yy.c -o count_vowel
    ```
    This command compiles the C code and creates an executable file named `count_vowel`.

3.  **Run the program**:
    ```bash
    ./count_vowel <your_input_file.c>
    ```
    Replace `<your_input_file.c>` with the path to the C file (or any text file) you want to analyze. The program will then output the total number of vowels and consonants found in the file.
