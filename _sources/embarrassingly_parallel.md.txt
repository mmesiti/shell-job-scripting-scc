# Simple Parallelism patterns in the shell

When a workload is made up of very small independent tasks,
they can be collected in larger jobs and processed in parallel.

```{admonition} Tier 2 Clusters are mainly for large parallel jobs 

HPC clusters possess a fast interconnect
in order to be able to run jobs 
that are able to use many nodes.

For jobs that do not saturate a single node,
the fast interconnect is overkill,
but in order to use efficiently a cluster
a mix of job sizes and duration is necessary,
so that the gaps between big jobs 
can be filled in by smaller ones.

```

Multiple small jobs can be collected in a single, bigger one,
using basic shell functionality:

- send processes in the background with `&`
- `wait` for background processes to finish

```{warning} Multi-node jobs: the need for srun

The job script runs only on the first node 
in the job allocation, 
so using `&` would send processes in the background
but only on the first node.

So, one has to use `srun`
to make sure that also the other nodes 
in the allocation are used.

```


# Tools for embarrassingly Parallel Workloads


## Parbatch
Dispatches tasks to workers on each nodes using MPI.

Example of a SLURM script using parbatch (HoreKa):

```bash
#!/bin/bash

#SBATCH -n 2 -N 1
#SBATCH --mem=150
#SBATCH -t 00:03:00

module load system/parbatch

parbatch joblist.txt
```

`joblist.txt` is a list of "tasks", one per line, 
each represented by a semicolon-separated list of commands,
for example:

```
sleep 10; echo 'Hello'; sleep 5 
sleep 10; echo 'World'; sleep 5 
sleep 10; echo 'today'; sleep 5 
sleep 10; echo 'it is'; sleep 5 
sleep 10; echo 'time'; sleep 5 
sleep 10; echo 'for'; sleep 5 
sleep 10; echo 'something'; sleep 5 
sleep 10; echo 'new'; sleep 5
```

## Similar Projects 

- [GNU parallel](https://www.gnu.org/software/parallel/)
  allows slightly more complex workloads, e.g. cartesian products of tasks
- [METAQ](https://github.com/evanberkowitz/metaq) is a tool that works as a scheduler inside your job, with a simplified resource manager


