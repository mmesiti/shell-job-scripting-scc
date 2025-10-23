# More Bash features and their composability

```{objectives}
- Recognize and read advanced shell features
- Isolate parts of a script with subshells
- Modularize and organize a script with functions

```

```{admonition} To follow along
Please navigate to the `examples/composability` directory.
```

This episode builds upon the 
[composability episode from the Intermediate part](#composability),
discussing more sofisticated 
(and more niche)
bash features.

## More streams and redirections

### Use a file as `stdin` for  a process: `<`


The `<` redirection operator takes a file
and put its contents in the `stdin` of a process,
as if we were typing it ourselves:
```bash
$ wc -l < myfile
17
```

###  `stderr` into `stdout` or vice versa

- `&>` can be used to redirect both streams
- `2>&1` redirects `stderr` to `stdout`
- `1>&2` does the opposite

Note: `2>&1`  (or )
goes *after* any redirection to files with `>`,
but *before*:

```bash
$ ./stream_example.sh > stdout_and_stderr 2>&1
$ ./stream_example.sh 2>&1 | wc -l
2
```

### Process substitution: `<()` 

Create a temporary file 
containing the output (`stdout`)
of the list of commands
inside the brackets.

`````{exercise} Check the difference in content between two directories

In the current directory (`examples/composability`) 
there are two files named `file1` and `file2`.
How can you compare 
only the first 3 lines of both files
with the `diff` command?
````{solution}
```bash
$ diff <(head -n 3 file1) <(head -n 3 file2)
3c3
< the lazy dog.
---
> the white dog.
```
````


````` 

### Compound commands
Grouping a list commands together with `{  }`.
  
The exit code of the compound command 
is the one of the last command executed.

(subshells)=
## Subshells and `export`

In order to define variables that are only visible to a subset of a program,
we can use a subshell. We can create one with `( ...list of commands...)`:

```bash
$ ( 
C=12
echo $C
    )
12
```
The C variable is defined in a subshell and is not visible outside:
```bash
$ echo $C 

```

In a script, it is convenient to use a subshell
if you need to change directory with `cd`.
At the end of a subshell, 
the execution will return automatically 
to the previous directory.

For interactive work,
we can also create a subshell by invoking `bash`,
and we can exit them with `CTRL-D` or the `exit` command.

Note: variables defined in the parent shell
will not be visible in child shells
unless we export them.


`````{exercise} Variabes in a subshell
Try this:
  ````bash
    $ A=42
    $ (
       echo $A
    )
  ````

What is the output? 
Is it expected, even if A is not exported?

Try this instead:
  ````bash
    $ A=42
    $ bash -c 'echo $A'
  ````

And what is different when `A` is instead exported?

  ````{solution}

   1.In the first case the value assigned to `A` is seen,
     but just because in the expression

     ```bash
     $ (
        echo $A
     )
     ```
     
     the value `42` is substituted to `$A` 
     *before* the expression is evaluated,
     meaning that the expression that is evaluated is actually 

     ```bash
     $ (
        echo 42
     )
     ```
  2. In the second case, we use single quotes (`'`) 
     to make sure that the expression `$A` is *not* evaluated to 42
     before the `bash` command is executed.
     Therefore, since in the new shell `A` is not defined, 
     we get an empty line. By `export`ing `A` instead, we get `42`:
     ```bash
     $ export A=42
     $ bash -c 'echo $A'
     42
     ```
  ````
`````
(functions)=
## Bash functions

Functions can be created 
with the following syntax:
```bash
function myfunction(){
  FIRST_ARG="$1"
  echo $FIRST_ARG 
}
```
(the `function` keyword is actually optional in this case).

They can then be used by calling them 
and passing them arguments
as normal bash commands:

```bash
myfunction 1 2 3
```

```{admonition} Bash functions do not define a scope

Any operation made on variables visible by the functions
will affect the whole shell 
where the function is executing.

This is actually by design.

What about the `module` command?

Subshells instead **do** define a scope.

```

## Arrays

Arrays are a bash feature that allows to store a list of elements.

They are generated with the syntax
```bash
$ A=(first_element
   second_element
   ...
   )
```

The list of elements can be generated in various ways.

An element of the array (e.g., the second) 
can be accessed with the syntax

```bash
$ echo "${A[1]}"
second
```

and the whole array can be accessed, 
for example in a `for` loop, in this way:

```bash
$ for element in "${A[@]}"
> do
>     echo "$element"
> done
```

```{note}
Note the similarity
and differences
between the syntax for arrays
and the syntax for subshells...
```


`````{exercise} Arrays and command substitution
Create a variable named "outputfile" 
(which might represent the name of a file used for output in a script)
that is composed of 3 strings:

1. Environment variable $LOGNAME
2. Arbitrary string of 4 characters generated in subshell via: 
   `mktemp -u XXXX`
3. First 2 characters of the current month (→ use the `date` command) 
   using a bash array

````{solution}
A possible solution reads:
```bash
array=($(date))
month=${array[1]:0:2}

declare -r outputfile="${LOGNAME}_$(mktemp -u XXXX)_${month}.log"
echo ${outputfile}
```
If we try changing output file we do get an error:
```bash
outputfile="new"
```
````

`````
## Dealing with repetition: pipe into `xargs` instead of `for`

If the loop body is a one-liner,
an alternative is particulary convenient.

Typically we use *first* the command to generate the list 
we want to iterate on.  
For example:
```bash
find data -name '*.dat'
```
We can use a *pipe* and the `xargs` command to

```bash
find data -name '*.dat' | xargs -I{} ./process.sh {}
```

