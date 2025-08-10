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

## Function Counter

This is a simple LEX program that counts the number of C-style function definitions in a given file.

**Note:** The regular expression used to detect functions is simple and may not cover all possible C function declaration styles (e.g., K&R style). It assumes a function definition looks like `return_type function_name(arguments) {`.

### Compilation and Execution

1.  **Compile the LEX file:**
    ```bash
    flex count_functions.l
    ```
    This will generate a C source file named `lex.yy.c`.

2.  **Compile the C source file:**
    ```bash
    gcc lex.yy.c -o function_counter
    ```
    This will create an executable file named `function_counter`.

3.  **Run the program:**
    ```bash
    ./function_counter <filename>
    ```
    Replace `<filename>` with the path to the file you want to analyze.

### Example

1.  Create a sample file named `input_functions.txt` with the following content:
    ```c
    int main() {
        return 0;
    }

    void my_function(int a, char *b) {
        // do something
    }
    ```

2.  Run the program on `input_functions.txt`:
    ```bash
    ./function_counter input_functions.txt
    ```

3.  The program will output:
    ```
    Number of functions: 2
    ```
