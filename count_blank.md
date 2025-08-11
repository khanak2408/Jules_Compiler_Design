# Documentation for count_spaces.l

This document provides an explanation for the LEX program `count_spaces.l`, which counts the number of lines, words, and blank spaces in a given text file.

## Logic Explanation

The program is divided into three main sections as is standard for a LEX file: the definition section, the rules section, and the user code section.

### 1. Definition Section

```c
%{
#include<stdio.h>
int lines=0, words=0, spaces=0;
%}
```

- In this section, we include the standard input/output library `stdio.h`.
- We declare three global integer variables:
    - `lines`: to store the count of newline characters.
    - `words`: to store the count of words.
    - `spaces`: to store the count of blank spaces and tabs.

### 2. Rules Section

```lex
%%
\n      { lines++; }
[ \t]   { spaces++; }
[^\t\n ]+ { words++; }
%%
```

- This section defines the patterns that the lexer will match and the corresponding actions to take.
- `\n`: This pattern matches a newline character. The action increments the `lines` counter.
- `[ \t]`: This pattern matches a single space or tab character. The action increments the `spaces` counter for each one found.
- `[^\t\n ]+`: This pattern matches any sequence of one or more characters that are not a tab, a newline, or a space. This is how we define a "word". The action increments the `words` counter.

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
    printf("Lines: %d\n", lines);
    printf("Words: %d\n", words);
    printf("Spaces: %d\n", spaces);
    fclose(file);
    return 0;
}

int yywrap(void) {
    return 1;
}
```

- The `main` function is the entry point of the program. It takes a filename as a command-line argument.
- It opens the file and assigns it to `yyin`, which is the input stream for the lexer.
- `yylex()` is the main lexer function that runs the analysis.
- After `yylex()` completes, the program prints the final counts of `lines`, `words`, and `spaces`.
- The `yywrap()` function is required by the lexer. It is called at the end of the file. Returning `1` indicates that there are no more files to process.

## How to Compile and Run

1.  **Compile the lexer**:
    ```bash
    lex count_spaces.l
    ```
    This will generate a `lex.yy.c` file.

2.  **Compile the C code**:
    ```bash
    gcc lex.yy.c -o count_spaces
    ```
    This will create an executable file named `count_spaces`.

3.  **Run the program**:
    ```bash
    ./count_spaces <your_input_file.txt>
    ```
    Replace `<your_input_file.txt>` with the path to the file you want to analyze.
