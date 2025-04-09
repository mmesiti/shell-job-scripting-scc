# Composability

```{objectives}
1. Save the output of a program to a file 
2. Connect the output of a program to the input of another
3. Use variables to store values
4. Isolate parts of a script with subshells
```
## Streams and redirections
Every process has 3 *streams* associated to it:
- `stdin`: the input stream coming into the program, for example from your keyboard;
- `stdout`: the stream coming out of the program, i.e. most of the text that is printed out in a terminal;
- `stderr`: similar to `stdout`, but with messages that should be treated differently (e.g., error messages).


```{admonition} stdin vs command arguments
Many commands will accept input from `stdin` 
and use it as a *file*.

For example,
```bash
wc -l myfile
```
Will print the number of lines in the file `myfile`.
But the command
```bash
wc -l 
    ```
without an argument will wait for you to type in text,
that is for input data on its `stdin` stream.

```

We can take the `stdout` of a process
and *redirect* it to a file, for example

```bash
find . > all_files_here
```


  - `>`, `>>` 
  - `2>&1`, `&>`

## pipes and filters



## Variables
- command substitution: `$()`

## Subshells and `export`


