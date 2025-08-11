# Documentation for exp_7.l

This document provides a detailed explanation for the LEX program `exp_7.l`. This program is designed to read an input text file and identify several common patterns: valid mobile numbers, URLs, C-style identifiers, dates, and times.

## Program Logic and Flow

The program operates by reading an input file character by character and applying a set of rules defined using regular expressions. When a sequence of characters matches one of these patterns, the program prints a message to the console identifying the matched pattern and the matched text.

The core logic resides in the "rules" section of the `exp_7.l` file. The rules are ordered, but for these specific patterns, the "longest match" principle of `lex` is key. `lex` will always try to match the longest possible string of characters to a rule. This ensures that, for example, a full URL is matched by the URL rule, rather than its components being matched by the identifier rule.

## Regular Expression Patterns Explained

Here is a breakdown of the regular expressions used to identify each pattern:

### 1. Valid Mobile Number
- **Regex:** `[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]`
- **Explanation:**
    - `[1-9]`: Matches a single digit from 1 to 9. This ensures the mobile number does not start with 0.
    - `[0-9]...`: Matches exactly nine more digits from 0 to 9.
- **Assumptions:** This rule assumes a standard 10-digit mobile number format. It was written in this expanded form to maintain compatibility with standard `lex`.

### 2. Valid URL
- **Regex:** Two rules are used: `"http://"[a-zA-Z0-9./-]+` and `"https://"[a-zA-Z0-9./-]+`
- **Explanation:**
    - `"http://"` or `"https://"`: Matches the literal protocol strings. Using quotes avoids issues with special characters in `lex`.
    - `[a-zA-Z0-9./-]+`: Matches one or more characters that are letters (uppercase or lowercase), digits, a period, a forward slash, or a hyphen.
- **Limitations:** This is a simplified regex for URLs and will not match all possible valid URLs (e.g., those with query parameters, ports, or special characters).

### 3. Valid Identifier
- **Regex:** `[a-zA-Z_][a-zA-Z_0-9]*`
- **Explanation:**
    - `[a-zA-Z_]`: Matches a single character that is a letter (uppercase or lowercase) or an underscore. This defines the valid starting characters for an identifier.
    - `[a-zA-Z_0-9]*`: Matches zero or more characters that are letters, underscores, or digits.
- **Assumptions:** This rule follows the standard C-style definition for variable names and identifiers.

### 4. Valid Date (dd/mm/yyyy)
- **Regex:** `[0-9][0-9]"/"[0-9][0-9]"/"[0-9][0-9][0-9][0-9]`
- **Explanation:**
    - `[0-9][0-9]`: Matches a two-digit number for the day and month.
    - `[0-9][0-9][0-9][0-9]`: Matches a four-digit number for the year.
    - `"/"`: Matches the literal forward slash separator.
- **Limitations:** This is a very simplified regex to ensure compatibility with standard `lex`. It only checks for the `dd/mm/yyyy` format with digits. It does **not** validate the range of the day (1-31), month (1-12), or any other logical constraints (e.g., "31/02/2023" would be considered valid by this rule).

### 5. Valid Time (hh:mm:ss)
- **Regex:** `[0-9][0-9]":"[0-9][0-9]":"[0-9][0-9]`
- **Explanation:**
    - `[0-9][0-9]`: Matches a two-digit number for the hour, minute, and second.
    - `":"`: Matches the literal colon separator.
- **Limitations:** This is a simplified regex that only checks for the `hh:mm:ss` format. It does **not** validate the range of the hours (0-23), minutes (0-59), or seconds (0-59). For example, "99:99:99" would be considered valid by this rule.

## How to Compile and Run

1.  **Compile the LEX program**:
    ```bash
    lex exp_7.l
    ```
    This command generates a C source file named `lex.yy.c`.

2.  **Compile the generated C code**:
    ```bash
    gcc lex.yy.c -o exp_7
    ```
    This command compiles the C code and creates an executable file named `exp_7`.

3.  **Run the program**:
    Create a text file (e.g., `input.txt`) with a mix of text and patterns you want to identify. Then, run the program with this file as an argument:
    ```bash
    ./exp_7 input.txt
    ```
    The program will print a confirmation for each valid pattern it finds in the file.
