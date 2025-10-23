# Job Scripting and best practices

```{objectives}
1. Write understandable bash scripts for automation
2. Submit job

```

## What is a Bash script?

- A Bash *script* is a plain text file 
  containing a list of commands,
  of the kind that could be launched interactively 
  in a Bash *shell*. 

- It is a (simple form of a) program.

- Typically, a bash script will act as a *driver*:
  - call other programs
  - "orchestrate" their operations together
  - provide them with data
  - organize the data movements.

- The other programs will typically be written
  in languages that are more suitable to scientific computing,
  (but they can also be other bash scripts).
 

### Where do scripts come from?

Often we get scripts in the form of examples
from our colleagues 
or from the documentation of the software we want to use.
If you are unsure about anything, 
try first typing your commands interactively.

You can also run the example script you got 
after modifying it by calling it with

```bash
bash ./example-script.sh
```

```{warning}
If significant resources are needed to for your experiments 
do not use the login node of the cluster.

Do you have doubts about the resource requirements?
Then do not use the login node of the cluster, either.

Create an interactive session on a *compute node* using e.g. *salloc*.
```

You can also experiment by typing 
(or copy/pasting)
the commands directly in the shell.
Then you can create a script
collecting the commands you typed
selecting the ones you really want to run
by, for example, adjusting the output of the `history` command.

### Structure of a Bash script: best practices

- At the very beginning, we have a "hash-bang" directive:
  ```bash
  #!/bin/bash 
  ```
  it tells the interpreter to be used to execute the script.  
  Needed for SLURM.
- We can declare our variables and process input parameters,
  for example:
  ```bash
  FILE_TO_PROCESS="$1"
  OUTPUT="${FILE_TO_PROCESS%.txt}.out"
  ```
- We prepare the input data for processing,
  e.g. we move the data where it is needed
- We perform the main task of the script
- We "clean up", e.g. we move the output 
  where we need it.
 
 
  
### Adapt it to for use with sbatch 
  
To submit a Bash script with `sbatch`,
i.e. be able to do
```bash
sbatch <sbatch-options> ./my-script.sh
```

we need, typically to add some `sbatch` options
immediately after the "hash-bang", 
as bash *comments* starting with `#SBATCH`,
for example:
```
#SBATCH --ntasks=1
```
These are technically code comments,
but are not (only) for humans.
They will be ignored by Bash,
but read by the `sbatch` command.

```{exercise} Discussion: do we need #SBATCH directives? 
We could in principle not have *any* 
`#SBATCH` directive in our script.

What would be the problems, then?
```{solution}
   We would face the following issues:
   - then we would have to pass 
     *all* `sbatch` options on the command line when 
   - this would reduce the reproducibility
   - very often the commands inside a slurm script 
     needs some specific sbatch options to work correctly,
     and because of this coupling between these 
     is better to have them together in the same place.
```
