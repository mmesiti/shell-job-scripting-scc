#!/bin/bash
###################################################
## Tutorial Case 1 - ToDo/TASK:                  ##
## Complete script template for bwUniCluster 2.0 ##
## to run jobs on local filesystem               ##
## * Write code for sections 1 - 5               ##    
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
##   - '# SBATCH' is a comment, while '#SBATCH' is a sbatch option statement

##################################################
## HEADER: Define here your Compute resources   ##
##################################################
#SBATCH -J ws_case1
#SBATCH -N1 -n1 -c1 --mem=250
#SBATCH -t 00:05:00
#SBATCH --mail-type=ALL
# SBATCH --constraint=BEEOND ## Does only work with more than 1 nodes


##################################################
## 1. Declarations: setup environment etc.      ##
##################################################
## Generalised code parts
## 1.a) Exercise ToDo: Define full path of your binary
EXE=

## 1.b) Exercise ToDo: Define output file 
##    = Name of executable wo extension + JOBID or PID 
output=

## 1.c) Exercise ToDo: Define input file(s) 
input=

## 1.d) Exercise ToDo: Define input files to be copied
copy_list=

## 1.e) Exercise ToDo: Define files to be copied back after run, i.e. output file
save_list=

## 1.f) Exercise ToDo: load modules INTEL+MKL

##################################################
## BODY:                                        ##
##################################################

## 2) Define your private local filesystem, 
##    Nodes=1 -> TMPDIR option: run_DIR <=> tmpdir + username + JobID or PID
##    Nodes>1 -> BEEOND option: run_DIR <=> path to BEEOND directories
run_DIR="${TMPDIR}/${USER}.${SLURM_JOB_ID:-$$}"
#run_DIR=${TMPDIR}
#run_DIR=/mnt/odfs/$SLURM_JOB_ID/stripe_default/
mkdir -pv ${run_DIR}
 
## 3.b) Check existence of run directory

## 3.a) Copy program and input from submit directory
##    to run directory 
cd "${SLURM_SUBMIT_DIR:-${PWD}}"
cp -pv gen_files.x   "${TMPDIR}/${USER}.${SLURM_JOB_ID:-$$}"
##    Tutorial ToDo: Check if copy succeeded
cp -pv gen_files.inp "${TMPDIR}/${USER}.${SLURM_JOB_ID:-$$}"

## 4) Change to run directory and start "binary" together with input file
cd "${TMPDIR}/${USER}.${SLURM_JOB_ID:-$$}"
##    Tutorial ToDo: Check if change to directory succeeded
./01_gen_files.x 01_gen_files.inp

##################################################
## FOOTER: check job, cleanup your job etc.     ##
##################################################
## 5.a) Tutorial ToDo: Check run status

## 5.b) Transfer output files to submit directory
cp -pv files_*.out "${SLURM_SUBMIT_DIR}"

## 5.c) Tutorial ToDo: Cleanup run_DIR

exit 0
