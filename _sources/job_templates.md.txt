# Jobscript Examples

A collection of job templates
showing how to use some particular feature.

All examples courtesy of Robert Barthel.

## Dealing with walltime limits on your own terms 

SLURM can be configured
so that it sends a signal to your script
some time before the *wall time* ends,
by using the `--signal` option for `sbatch`:

```bash
#!/bin/bash
## Pre-termination via Slurm 
## sending signal with defined offset 

#SBATCH -n 1 -t 00:01:00
#SBATCH --mem=100
#SBATCH --signal=B:15@10
#SBATCH -p ws

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

Notice: the signal handler will not be called 
when an external program is running.


## Using a local/private FileSystem

```bash
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

## Job chaining 
### Using recursive `sbatch`

```bash
#!/bin/bash
#SBATCH -N1 -n1 -t 00:00:05 –mem=250 -p ws
## Defaults
loop_max=10
cmd='sleep 2'

## Check if counter environment variable is set
if [ -z "${myloop_counter}" ] ; then
   echo "  ERROR: myloop_counter is undefined, stop chain job"; exit 1
fi
## only continue if below loop_max
if [ ${myloop_counter} -lt ${loop_max} ] ; then
   ## increase counter    
   let myloop_counter+=1
   ## print current Job number
   echo "  Chain job iteration = ${myloop_counter}"
   ## Execute your command
   echo "  -> executing ${cmd}"
   ${cmd}

   if [ $? -eq 0 ] ; then
      ## continue only if last command was successful
       sbatch --export=myloop_counter=${myloop_counter} ./02_chain_job_solv.sh
   else
      ## Terminate chain 
      echo "  ERROR: ${cmd} of chain job no. ${myloop_counter} terminated unexpectedly"
      exit 1
   fi
fi 
```


### Using Slurm dependencies

```bash
#!/bin/bash
max_nojob=${1:-5}
chain_link_job=${PWD}/02_chain_link_job_solv.sh
dep_type="${2:-afterok}"

myloop_counter=1
while [ ${myloop_counter} -le ${max_nojob} ] ; do
   if [ ${myloop_counter} -eq 1 ] ; then
      slurm_opt=""
   else
      slurm_opt="-d ${dep_type}:${jobID}"
   fi

   echo "Chain job iteration = ${myloop_counter}"
   echo "   sbatch --export=myloop_counter=${myloop_counter} ${slurm_opt} ${chain_link_job}"
   ## Store job ID for next iteration by storing output of msub command with empty lines
   jobID=$(sbatch --export=myloop_counter=${myloop_counter} ${slurm_opt} ${chain_link_job} 
           2>&1 | sed 's/[S,a-z]* //g')

   ## Check if ERROR occured
   if [[ "${jobID}" =~ "ERROR" ]] ; then
      echo "   -> submission failed!" ; exit 1
   else
      echo "   -> job number = ${jobID}"
   fi
   ## Increase counter
   let myloop_counter+=1
done
```
