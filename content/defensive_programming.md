# Defensive programming and debugging



```{objectives}
- How can I make my shell scripts more robust?
- Check your code automatically for typical issues 
- What does bash `set -xeu` mean?
```

## Debug and error checking

- The Bash shell has a number of options 
  that help with making your script more robust.
- Options can be activated with `set -<option>` 
  and deactivated with `set +<option>`.
- More single-characters options 
  can be combined together in a single string,
  e.g. `set -eu`.
- Additional options can be set with `set -o <options>`.
  You can check the available options
  by typing `help set`
  in the shell.

### Fail on error: `set -e`

With other programming languages,
when an error is encountered 
(and it is not managed)
the program typically stops.

With Bash, by default, this is not the case:
the shell will happily continue 
executing your commands even if one fails.

With `set -e`, you can make the shell stop
if there is an error.


`````{exercise} Important Discussion: Unintended consequences

Using `set -e` might have unintented consequences:
1. What if you set it in an interactive session, and there is an error?
   
2. In a script: 
   what if we need to absolutely do an operation before exiting? 
   For example, cleaning up a directory from intermediate results?  
   How to circumvent this issue and still get the benefit of `set -e`?

````{solution}
   1. If an error happens, 
      our shell will be terminated,
      and our connection to the cluster might be terminated.
      Either do not use `set -e` in an interactive shell,
      or use it in a subshell.
   2. We can put all the risky commands in a list in a subshell:

      ```
      # setup commands
      ...
      ( # subshell
        set -e
        # my risky commands 
        ...
      )
      # cleanup 
      ...
      ```
      In that case, only the subshell will be terminated,
      and the cleanup commands will run anyway.
````
`````

### Error when using an undefined variable: `set -u` 

With this option,
every time an undefined variable is referenced,
an error is raised:
```bash
$ set -u
$ echo $my_unexisting_variable
bash: my_unexisting_variable: unbound variable
```

If we want to use a default value when the variable is not set,
we can use a special case of *parameter expansion*:
```bash
$ set -u
$ echo ${my_unexisting_variable:-"nothing"}
nothing
```
And in this case no error is thrown.

In conjunction with `set -e` ,
this would also cause the script to abort
if an unset variable is used.

### Debugging: `set -x`

The `-x` option is handy to debug a script. 
For example, it makes the shell print out 
all commands and their arguments
just before they are executed 
(i.e., after all *expansions* have happened).


## Automatic check for common bad practices and antipatterns

A tool that can do this for you is [shellcheck](https://www.shellcheck.net/).

You can either use it on the website,
or download it as a program that will take 
your scripts as arguments
and check them one by one.

