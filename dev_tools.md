# Dev tools:

1. Console can inspect the current value of variables loaded in memory.
2. Debugger helped you locate where the data exists in the JavaScript code.
3. The Inspector (Elements) panel only shows the HTML that the browser has built.
4. Find the external javascript code in the Debugger tab.
5. Developers sometimes accidentally expose debugging files (.map), which reveal the application's original source code.




| DevTools Panel           | What it shows                           |
| ------------------------ | --------------------------------------- |
| **Inspector (Elements)** | HTML and the current DOM                |
| **Debugger / Sources**   | JavaScript source code                  |
| **Console**              | Execute JavaScript manually             |
| **Network**              | HTTP requests and responses             |
| **Storage**              | Cookies, Local Storage, Session Storage |




String.fromCharCode()
.toString()







# Obfuscated JavaScript Code

A malware analyst finds a JavaScript file.

The code is full of eval(), encrypted strings, and meaningless variables. Reading the source code doesn't reveal what the program really does.

Instead of trying to understand the obfuscated code, the analyst runs the program and records everything that actually executes.

Then, the analyst keeps only the instructions that affect the program's final behavior (such as calls to native functions) and removes everything that was only used for hiding the code.

Finally, the remaining instructions are converted back into clean, readable JavaScript.

Result: The real program is revealed while the obfuscation disappears.


| Obfuscation Technique              | Purpose                                                                 |
| ---------------------------------- | ----------------------------------------------------------------------- |
| **`eval()`**                       | Execute code stored as a string at runtime.                             |
| **Nested `eval()`**                | Multiple layers of dynamically generated code.                          |
| **Runtime string construction**    | Build code piece by piece before execution.                             |
| **Encrypted/encoded strings**      | Hide JavaScript code until runtime.                                     |
| **`String.fromCharCode()`**        | Convert numeric values into characters to reconstruct hidden code.      |
| **Dynamic code generation**        | Generate new JavaScript while the program is running.                   |
| **Multiple layers of obfuscation** | Combine several techniques together to make analysis difficult.         |
| **Dead/irrelevant code**           | Add code that never affects the program's behavior to confuse analysts. |
| **Meaningless variable names**     | Make the source harder to read.                                         |



#Search for decoding functions:
eval
String.fromCharCode
atob
btoa
unescape
decodeURIComponent
TextDecoder
--------------------------------------------------------------------------------------


#  common character/data representations
- Escape Notation
An escape notation is a special syntax used in a programming language to represent characters that are difficult to type, have special meaning, or are represented by their numeric value.

- Encoding
Encoding is the process of converting data from one representation or format to another for storage, transmission, or processing.

- Character Encoding
Character encoding is a standard that defines how text characters are represented as bytes so computers can store, process, and exchange text correctly.



| Term                   | What it does                                                           | Example                          |
| ---------------------- | ---------------------------------------------------------------------- | -------------------------------- |
| **Escape notation**    | A programming language's way of **writing a character** in source code | `"\x41"`, `"\u0041"`, `"\n"`     |
| **Encoding**           | Converts data into another format for storage or transmission          | Base64: `"Hello"` → `"SGVsbG8="` |
| **Character encoding** | Defines how characters are represented as bytes                        | UTF-8, UTF-16, ASCII             |




| Representation                            | Example                         | Category                 |
| ----------------------------------------- | ------------------------------- | ------------------------ |
| `"\x48\x65\x6C\x6C\x6F"`                  | Hex Escape Sequences            | Escape notation          |
| `"\u0048\u0065\u006C\u006C\u006F"`        | Unicode Escape Sequences        | Escape notation          |
| `String.fromCharCode(72,101,108,108,111)` | ASCII / Decimal Character Codes | Numeric representation   |
| `0x48, 0x65, 0x6C`                        | Hexadecimal Numbers             | Numeric representation   |
| `%48%65%6C%6C%6F`                         | URL Encoding                    | **Encoding**             |
| `SGVsbG8=`                                | Base64                          | **Encoding**             |
| `01001000...`                             | Binary                          | Numeric representation   |
| **UTF-8**                                 | `48 65 6C 6C 6F` (bytes)        | **Character encoding** ✅ |













-------------------------------------------------------------------------
# AST (Abstract Syntax Tree)
AST (Abstract Syntax Tree) is a tree representation of source code that captures its structure and meaning, without unnecessary syntax like whitespace or punctuation.
























ssh -p 443 -R0:127.0.0.1:8080 qr@a.pinggy.io

https://canyouseeme.org/




