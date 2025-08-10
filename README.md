# Operator Counter

This is a simple LEX program that counts the number of operators in a given file.

## Operators Counted

The program counts the following operators:

- `+`
- `-`
- `*`
- `/`
- `=`
- `==`
- `!=`
- `<`
- `>`
- `<=`
- `>=`
- `&&`
- `||`
- `!`

## Compilation and Execution

To use this program, you need to have `flex` and a C compiler (like `gcc`) installed.

1.  **Compile the LEX file:**
    ```bash
    flex operator_counter.l
    ```
    This will generate a C source file named `lex.yy.c`.

2.  **Compile the C source file:**
    ```bash
    gcc lex.yy.c -o operator_counter
    ```
    This will create an executable file named `operator_counter`.

3.  **Run the program:**
    ```bash
    ./operator_counter <filename>
    ```
    Replace `<filename>` with the path to the file you want to analyze.

## Example

1.  Create a sample file named `input.txt` with the following content:
    ```
    a = b + c;
    if (a > b && c != 0) {
        x = y * z;
    }
    ```

2.  Run the program on `input.txt`:
    ```bash
    ./operator_counter input.txt
    ```

3.  The program will output:
    ```
    Number of operators: 7
    ```
