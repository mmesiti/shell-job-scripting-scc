#!/bin/bash
##################################################
## Generalisation of Tutorial Case 2:           ##
## Script for bwUniCluster/bwForClusters        ##
## * To run chain job script with MOAB/SLURM &  ##
##   interactively                              ##
##################################################
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

## usage : 
## a) interactively: export myloop_counter=0; ./02_gen_chain_job_solv.sh
## b) with MOAB    : msub -v myloop_counter=0 ./02_gen_chain_job_solv.sh
## b) with SLURM   : sbatch --export='myloop_counter=0' ./02_gen_chain_job_solv.sh

##################################################
## MOAB/SLURM - Define Comp. resources          ##
##################################################
#SBATCH -J ws_case2
#SBATCH -N1 -n1 --mem=250
#SBATCH -t 00:00:05
#SBATCH --mail-type=ALL
#SBATCH --export="myloop_counter=0"

#MSUB -l nodes=1:ppn=1
#MSUB -l walltime=00:00:05
#MSUB -l pmem=50mb
#MSUB -N ws_case2
#MSUB -v myloop_counter=0

## Defaults
loop_max=10
cmd='sleep 2'
qs_opt="-p ${SLURM_JOB_PARTITION}"

## Check if counter environment variable is set
if [ -z "${myloop_counter}" ] ; then 
   echo "  ERROR: environment variable myloop_counter is undefined, stop chain job"
   echo "         Setup via msub: msub -v myloop_counter=0"
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
      ## Continue only if last command was successful
      if [ ! -z ${MOAB_JOBNAME} ] ; then
         ## If MOAB_JOBNAME environment variable is defined 
         ## -> this script is under MOAB "control"
         msub ${qs_opt} -v myloop_counter=${myloop_counter} ${MOAB_SUBMITDIR}/02_gen_chain_job_solv.sh
      elif [ ! -z ${SLURM_JOB_NAME} ] ; then
         ## If SLURM_JOB_NAME environment variable is defined
         ## -> this script is under SLURM "control"
         sbatch ${qs_opt} --export=\"myloop_counter=${myloop_counter}\" ${SLURM_SUBMIT_DIR}/02_chain_job_solv.sh
      else
         export myloop_counter=${myloop_counter}
         ./${0}
      fi
   else
      ## Terminate chain 
      echo "  ERROR: ${cmd} of chain job no. ${myloop_counter} terminated unexpectedly"
      exit 1
   fi
fi
