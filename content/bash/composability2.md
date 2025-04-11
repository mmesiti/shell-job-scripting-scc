# More Bash features and their composability

```{objectives}
Recognize and read advanced shell features

```

```{admonition} To follow along
Please navigate to the `examples/composability` directory.
```


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
- `1>&2` redirects `stdout` to `stderr`
- `2>&1` does the opposite


### Process substitution: `<()` 

Create a temporary file 
containing the output (`stdout`)
of the list of commands
inside the brackets

### Compound commands
Grouping a list commands together with `{  }`.
  
The exit code of the compound command 
is the one of the last command executed.

## Bash functions

Functions can be created 
with the following syntax:
```bash
function f(){
  FIRST_ARG="$1"
  echo $FIST_ARG 
}
```
Function is actually
not necessary, so this would work:
```
f(){
  FIRST_ARG="$1"
  echo $FIST_ARG 
}
```

```{warning} Bash functions do not define a scope

Any operation made on variables visible by the functions
will affect the shell where the function is executing.

This is actually by design.
What about the `module` command?

Subshells instead *do* define a scope.

```

## Arrays

Arrays are a bash feature that allows to store a list of elements.

They are generated with the syntax
```bash
A=( first_element
    second_element
    ...
    )
```

The list of elements can be generated in various ways.


As an example,
we will now reate a variable named "outputfile" that is composed of 3 strings:

1. Environment variable $LOGNAME
2. Arbitrary string of 4 characters generated in subshell via: 
  mktemp -u XXXX 
3. First 2 characters of the current month (→ use „date“) using a bash array

A possible solution reads:
```bash
array=($(date))
month=${array[1]:0:2}

declare -r outputfile="${LOGNAME}_$(mktemp -u XXXX)_${month}.log"
echo ${outputfile}

# Try changing output file
outputfile="new"
```
