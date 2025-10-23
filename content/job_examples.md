# Examples of job scripts

```{objectives}
- Deal with job termination on your own term (inspirational) 
- Chain jobs using recursive `sbatch` invocations (inspirational)
- Use SLURM dependencies to launch graphs of interdependent slurm jobs (inspirational)
```

Here we present a collection of jobscript examples, 
showing how to use some particular feature of SLURM 
that can be useful.

In the following episodes we will describe more concretely
how these work,
clarifying the syntax 
and the relevant features of the bash shell.

All examples originally written Robert Barthel from KIT/SCC/SCS.

(signal-and-traps)=
## Dealing with walltime limits on your own terms 

SLURM can be configured
so that it sends a signal to your script
some time before the *wall time* ends,
by using the `--signal` option for `sbatch`.
In this case, the signal is sent 
120 seconds before the wall time ends:

```bash
#!/bin/bash
## Pre-termination via Slurm 
## sending signal with defined offset 

#SBATCH --ntasks=1
#SBATCH --time=0-00:05:00
#SBATCH --mem=100
#SBATCH --signal=B:15@120

cleanup(){
  echo "Cleanup before walltime reached"
  exit 0
}

trap cleanup 15

echo "Repeating \"sleep 1\" loop until SIGTERM"
i=1
while true ; do
  sleep 1; echo $i; let i+=1
done
```

```{warning}
As discussed [here](#signals-and-traps-caveat),
the signal handler will not be called 
until the shell recovers execution, e.g.: 
- until an external program 
  (even `sleep`)
  that is running in the foreground
  stops executing
- until a `wait` stops executing
``` 


## Job chaining using recursive `sbatch`

It is possible to use `sbatch` inside a job script,
to make so that it resubmits itself recursively once it has ended.

```{warning}
To use this feature safely, 
one should make sure that all the failure modes are properly taken care of, and that the recursion ends in *every possible case*.

See [defensive programming practices](./defensive_programming.md).

```

Example:

```bash
#!/bin/bash
#SBATCH -N1 -n1 -t 00:00:05 –mem=250 -p ws
## Defaults
loop_max=10
cmd='sleep 2'

## Check if counter environment variable is set
if [ -z "${counter}" ] ; then
   echo "  ERROR: counter is undefined, stop chain job"; exit 1
fi
## only continue if below loop_max
if [ ${counter} -lt ${loop_max} ] ; then
   ## increase counter    
   let counter+=1
   ## print current Job number
   echo "  Chain job iteration = ${counter}"
   ## Execute your command
   echo "  -> executing ${cmd}"
   ${cmd}

   if [ $? -eq 0 ] ; then
      ## continue only if last command was successful
       sbatch --export=counter=${counter} ./02_chain_job_solv.sh
   else
      ## Terminate chain 
      echo "  ERROR: ${cmd} of chain job no. ${counter} terminated unexpectedly"
      exit 1
   fi
fi 
```


## Setting dependencies between jobs using Slurm

Performing all the steps of a workflow 
from scratch in a single slurm job 
might waste resources if the steps differ 
in the amount of resource needed.

In that case, one might want 
to submit different jobs for each step,
but a dependency graph needs to be defined.

- Use the sbatch `--dependency` option to launch the *dependent* jobs
- Use the sbatch `--parsable` and command substitution 
  to obtain automatically the job ID for the "upstream" jobs 

Here is an example of job chaining using slurm dependencies:

```bash
#!/bin/bash
max_nojob=${1:-5}
chain_link_job=${PWD}/chain_link.sh

counter=1
while [ ${counter} -le ${max_nojob} ] ; do
   if [ ${counter} -eq 1 ] ; then
      slurm_opt=""
   else
      slurm_opt="--dependency afterok:${jobID}"
   fi

   echo "Chain job iteration = ${counter}"
   command=(sbatch --export=counter=${counter} ${slurm_opt} ${chain_link_job})
   ## Store job ID for next iteration by storing output of msub command with empty lines
   jobID=$( "${command[@]}" 2>&1 | sed 's/[S,a-z]* //g')

   ## Check if ERROR occured
   if [[ "${jobID}" =~ "ERROR" ]] ; then
      echo "   -> submission failed!" ; exit 1
   else
      echo "   -> job number = ${jobID}"
   fi
   ## Increase counter
   let counter+=1
done
```

## An excerpt of a job using a local/private FileSystem

We will describe the syntax used in this example 
in the following episodes.

```bash
###################
## DECLARATIONS  ##
###################
# 1.a) Define your binary
submitdir=${SLURM_SUBMIT_DIR:-${PWD}}
EXE="01_gen_files.x"

## 1.b) Define output file
##    = Name of executable wo extension + JOBID or PID 
output="$(basename ${EXE/.*})_${SLURM_JOB_ID:-$$}.log"

## 1.c) Define full path input files 
Input="01_gen_files.inp"

## 1.d) Define input files to be copied
copy_list="${EXE} ${input}"

## 1.e) Define files to be copied back after run, i.e. output file
save_list="${output} files_*.out"

## 1.f) Load modules INTEL+MKL
for mod in compiler/intel numlib/mkl ; do
   module load "${mod}"
done

###################
## BODY          ##
###################
## 2) Define your run directory and and generate via mkdir
##    Nodes=1 -> TMPDIR option: run_DIR <=> tmpdir + username + JobID or PID
##    Nodes>1 -> BEEOND option: run_DIR <=> path to BEEOND directories
if [ ! -z ${SLURM_JOB_NAME} ] ; then
   if [ ${SLURM_NNODES:-1} -gt 1 ] ; then
      run_DIR=/mnt/odfs/${SLURM_JOB_ID}/stripe_16/
   else
      run_DIR=${TMPDIR}
   fi
else
   run_DIR="${TMPDIR}/${USER}.${SLURM_JOB_ID:-$$}"
   mkdir -pv "${run_DIR}"
fi

## 3.a) Check existence of run directory
if [ ! -d "${run_DIR}" ] ; then
   echo "ERROR: Run DIR = ${run_DIR} does not exist"; exit 1
fi

## 3.b) Change to Submit Dir or PWD / Copy files from submit_DIR to run_DIR
cd "${submitdir}"
for X in ${copy_list} ; do
   cp -pv "${X}" "${run_DIR}"
   if [ $? -ne 0 ] ; then echo "ERROR: Copy of ${X} failed"; exit 1; fi
done

## 4) Change to runDIR and start binary
cd "${run_DIR}"
if [ $? -ne 0 ] ; then echo "ERROR: Entering ${run_DIR} failed"; exit 1; fi
./$EXE ${input} > $output 2>&1


###################
## FOOTER        ##
###################
## 5.a) Check run status
if [ $? -ne 0 ] ; then
   echo "WARNING: ${EXE} did not run properly!"
fi

## 5.b) Transfer output files to submit directory
cd "${run_DIR}"
for X in ${save_list} ; do
   cp -pv "${X}" "${submitdir}"
   if [ $? -ne 0 ] ; then echo "WARNING: Copy of ${X} failed"; fi
done

## 5.c) Cleanup run directory
rm -f ${run_DIR}/*; rmdir ${run_DIR}; exit 0

```

````{discussion} How could this example be made more readable?

This example has been heavily commented,
so that it is still possible to understand it 
even for someone that is not used to the bash syntax.

Are there ways to improve the readability
or make the flow of the script more immediately understandable?
 
````{solution}
Some comments:
- Originally, this script was the solution to an exercise.
- As in many other programming languages, 
  in Bash it is possible to define [functions](#functions)
  to encapsulate logic
  and functions can be named in a descriptive way
- Some [bash options](#defensive-programming) can make the flow of the program more predictable
- Using [subshells](#subshells) to encapsulate side effects of some commands 
  (e.g., `cd`)
  could be beneficial

Do you have any other suggestions?

````

````
