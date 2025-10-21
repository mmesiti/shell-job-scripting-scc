# SLURM Workflows 
## Job chaining using SLURM dependencies

Performing all the steps of a workflow 
from scratch in a single slurm job 
might waste resources if the steps differ 
in the amount of resource needed.

Jobs can be chained using slurm dependencies:

- Use sbatch `--dependency` option to launch the *dependent* jobs
- Use sbatch `--parsable` and command substitution 
  to obtain automatically the job ID for the "upstream" jobs 

## Job chaining by recursive `sbatch` invocations 

It is possible to use `sbatch` inside a job script,
to make so that it resubmits itself recursively once it has ended

```{warning}
To use this feature safely, 
one should make sure that all the failure modes are properly taken care of, and that the recursion ends in *every possible case*.

See [defensive programming practices](./defensive_programming.md).


```
