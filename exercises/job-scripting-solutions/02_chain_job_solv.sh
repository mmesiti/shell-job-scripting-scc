#!/bin/bash
###################################################
## S O L U T I O N  of Tutorial Case 2:          ##
## Complete script template for bwUniCluster 2.0 ##
## * To run chain job script with Slurm          ##
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
#SBATCH -J ws_case2
#SBATCH -N1 -n1 --mem=250
#SBATCH -t 00:05:00
#SBATCH --mail-type=ALL
#SBATCH --export="myloop_counter=0"

## Defaults
loop_max=4
cmd='sleep 2'
sbatch_opt="-p ${SLURM_JOB_PARTITION}"

## Check if counter environment variable is set
if [ -z "${myloop_counter}" ] ; then 
   echo "  ERROR: environment variable myloop_counter is undefined, stop chain job"
   echo "         Setup via sbatch: sbatch --export="myloop_counter=0""
   exit 1
fi

## Only continue if below loop_max
if [ ${myloop_counter} -lt ${loop_max} ] ; then

   ## Increase counter    
   let myloop_counter+=1
  
   ## Print current Job number
   echo "  Chain job iteration = ${myloop_counter}"
   
   ## Execute your command
   echo "  -> executing ${cmd}"
   ${cmd}
   
   if [ $? -eq 0 ] ; then
      ## Sbatch: Continue only if last command was successful
      echo "sbatch --export=\"myloop_counter=${myloop_counter}\" ${SLURM_SUBMIT_DIR:-$PWD}/02_chain_job_solv.sh"
      sbatch ${sbatch_opt} --export=\"myloop_counter=${myloop_counter}\" ${SLURM_SUBMIT_DIR}/02_chain_job_solv.sh
   else
      ## Terminate chain 
      echo "  ERROR: ${cmd} of chain job no. ${myloop_counter} terminated unexpectedly"
      exit 1
   fi
fi
