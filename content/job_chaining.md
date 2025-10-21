# SLURM Workflows 
## Repeating jobs with job arrays

SLURM has a feature that can helps 
when the goal is to repeat the same job many times:
*job arrays*.

The `sbatch` option to use is `--array`. 
Example usage:

```bash
#!/usr/bin/env bash
#SBATCH --job-name='job-array-example'
#SBATCH --time=0-00:05:00
#SBATCH --tasks=1

#SBATCH --array=0-49
#SBATCH --output=slurm-%A_%a.out
#SBATCH --error=slurm-%A_%a.err

# make sure that directories "temporary" and "results" exist
mkdir -p results

# this constructs job-000, job-001, ..., from the SLURM_ARRAY_TASK_ID
name=$(printf "job-%03d" "${SLURM_ARRAY_TASK_ID}")

input_file="input/${name}.txt"
result_file="results/${name}.txt"

# step 1: convert to grayscale and threshold
./process "${input_file}" "${result_file}"
```
(Adapted from [here](https://training.pages.sigma2.no/tutorials/independent-jobs-in-parallel/job-array.html))


## Workflow managers

If your workflow are sufficiently complicated,
managing the complexity inside a bash script using SLURM dependencies might be limiting.

What happens if a step in your workfow fails? 
What happens if some of your input data changes? 
What steps do you need to run again?

Tools like [snakemake](https://snakemake.readthedocs.io/en/stable/) 
or [nextflow](https://www.nextflow.io/docs/latest/container.html)
(but there are many others)
might make your life easier
in case of complex worflows.
