#!/bin/bash
###################################################
## S O L U T I O N  of Tutorial Case 1:          ##
## Complete script template for bwUniCluster 2.0 ##
## to run jobs on tmpdir                         ##
## * Write code for sections a,c,d,e,f,h         ##    
## * Generalise code avoiding repetition         ##
## * Redirect output of binary                   ##
###################################################
## ver.  : 2022-10-19, Robert Barthel, KIT, SCC
##
## Syntax:
##   ^                         = begin of line
##   <int>,<string>            = integer, string placeholder
##   ^##                       = comment
##
## How define Slurm resources in file:
##   ^#SBATCH --ntasks=<int> --nodes=<int>  = defines nodes and (MPI) tasks per node
##   ^#SBATCH --time=d-hh:mm:ss             = defines walltime in day-hh:mm:ss
##   ^#SBATCH --job-name=<string>           = defines jobname
##   ^#SBATCH --mail-type=<type>            = defines nofication condition
##
## Note:
##   - all '#SBATCH -?' are equivalent to 'sbatch -?'
##   - for more options, see 'man sbatch'
##   - '# SBATCH' is a comment, while '#SBATCH' is a msub option statement

##################################################
## HEADER: Define here your Compute resources   ##
##################################################
#SBATCH -J ws_case1
#SBATCH -N1 -n1 -c1 --mem=250
#SBATCH -t 00:05:00
#SBATCH --mail-type=ALL
# SBATCH --constraint=BEEOND ## Does only work with more than 1 nodes

##################################################
## Declarations: setup environment etc.         ##
##################################################
## Generalised code parts
## 1.a) Define your binary
submit_DIR=${SLURM_SUBMIT_DIR:-${PWD}}
EXE="01_gen_files.x"

## 1.b) Define output file 
##    = Name of executable wo extension + JOBID or PID 
output="$(basename ${EXE/.*})_${SLURM_JOB_ID:-$$}.log"

## 1.c) Define input files 
input="01_gen_files.inp"

## 1.d) Define input files to be copied
copy_list="${EXE} ${input}"

## 1.e) Define files to be copied back after run, i.e. output file
save_list="${output} files_*.out"

## 1.f) Load modules INTEL+MKL if not loaded
for mod in compiler/intel numlib/mkl ; do
   module load "${mod}"
done

##################################################
## BODY:                                        ##
##################################################
## 2) Define your private/local filesystem,
##    Nodes=1 -> TMPDIR option: run_DIR <=> tmpdir + username + JobID or PID
##    Nodes>1 -> BEEOND option: run_DIR <=> path to BEEOND directories
if [ ! -z ${SLURM_JOB_NAME} ] ; then
   run_DIR=/mnt/odfs/${SLURM_JOB_ID}/stripe_default
   if [ ! -d ${run_DIR} ] ; then
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

## 3.b) Copy program and input from submit directory
##    to run directory 
cd "${submit_DIR}"
for X in ${copy_list} ; do
   cp -pv "${X}" "${run_DIR}"
   if [ $? -ne 0 ] ; then echo "ERROR: Copy of ${X} failed"; exit 1; fi
done

## e) Change to run directory and start "binary" together with input file
cd "${run_DIR}"
if [ $? -ne 0 ] ; then echo "ERROR: Entering ${run_DIR} failed"; exit 1; fi
./$EXE ${input} > $output 2>&1

##################################################
## FOOTER: check job, cleanup your job etc.     ##
##################################################
## f) Check run status
if [ $? -ne 0 ] ; then
   echo "WARNING: ${EXE} did not run properly!"
fi 

## g) Transfer output files to submit directory
cd "${run_DIR}"
for X in ${save_list} ; do
   cp -pv "${X}" "${submit_DIR}"
   if [ $? -ne 0 ] ; then echo "WARNING: Copy of ${X} failed"; fi
done

## h) Cleanup run directory
echo "Cleanup run directory ${run_DIR}"
rm -f ${run_DIR:-/tmp}/*
#rmdir ${run_DIR}  ## done automatically at job end
exit 0
