# Composability - advanced 

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

