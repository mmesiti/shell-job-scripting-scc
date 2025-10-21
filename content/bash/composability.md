# Composability

```{objectives}
1. Save the output of a program to a file 
2. Connect the output of a program to the input of another
3. Use variables to store values
4. Isolate parts of a script with subshells
```

```{admonition} To follow along
Please navigate to the `examples/composability` directory
```

## Streams and redirections
Every process has 3 *streams* associated to it:
- `stdin`: the input stream coming into the program, for example from your keyboard;
- `stdout`: the stream coming out of the program, i.e. most of the text that is printed out in a terminal;
- `stderr`: similar to `stdout`, but with messages that should be treated differently (e.g., error messages).


### Clarification: stdin vs command line arguments

Commands can receive "information" in two different ways:

- through command line arguments (e.g., the name of a file)
- through *stdin*, the standard input stream

Many commands will accept input from `stdin` 
and use that stream as a *file*,
when no filename is passed as a command line argument.

For example,
```
$ wc -l myfile
22
```
Will print the number of lines in the file `myfile`.
But the command
```
wc -l 
```
without an argument will wait for you 
to type in some text,
that is,
input data on its `stdin` stream:

```
$ wc -l 
line one
line two
line three  # PRESS CTRL-D here
3 # get the number of lines here
$
```

We can take the `stdout` of a process
and *redirect* it to a file.

For example, to get the list of all files in the `data` directory:

```bash
find ./data 
```
If we want to save the output into a new file, we use *redirection*.
For example:

```bash
find ./data > all_files_here
```

This does not work easily for all commands by default:
Only the `stdout` of a process is redirected to a file.
To see this try the script `stream_exapmle.sh`:
```bash
$ ./stream_example.sh
This message goes to STDOUT
This message goes to STDERR instead
```
If we try to redirect the its output to a file,
the message on STDERR are still printed out,
and not in the file:
```bash
$ ./stream_example.sh > test_output
This message goes to STDERR instead
$ cat test_output
This message goes to STDOUT
```
If you want to redirect both streams, 
you can use `&>`
```bash
$ ./stream_example.sh &> test_output
$ cat test_output
This message goes to STDOUT
This message goes to STDERR instead
```
## Pipes
If a program `stdout` can be
the `stdin` of another program,
we can connect them together 
with a `|` character,
called a *pipe*.

For example, we can check 
how many files are in the data directory 
with the command
```
$ find ./data | wc -l 
5
```

## Variables

There is a way to store 
**small** amounts of information in the shell 
without using a file: *environment* variables.

They can be set with the `=` sign (no spaces):
```bash
MYVAR=42
FILENAME=data/data1.dat
```

the value of a variable can be accessed 
by putting `$` in front of it.
It can be displayed with `echo`:
```bash
$ echo "$MYVAR"
42
 ```

There is a lot of environment variables already defined in the shell.
They typically influence the behaviour of the shell,
and of the programs you launch in the shell.

To see the variables that are visible 
by the programs you launch in the shell, 
you can use the `env` (or `printenv`) command.

There is a lot of output, 
so better *pipe* it into the `less` command:
```
env | less
```

## Yet another way to reuse the output of a command 

With *command substitution*, 
one can get the output of a command
to create command line arguments:

```bash
find . -name "$(basename "$FILENAME")"
```

Variables can also be produced:
```bash
FNAME="$(basename "$FILENAME")"
echo "$FNAME"
```

```{tip}
If you not not use spaces and special characters in your filenames,
using double quotes `"..."` is not always necessary,
and your life will be easier.
```






