#!/bin/bash
###################################################
## Tutorial Case 2 - ToDo/TASK:                  ##
## Complete script template for bwUniCluster 2.0 ##
## * To run chain job script with Slurm          ##
###################################################
## ver.  : 2022-10-19, Robert Barthel, KIT, SCC
##
## interactive usage :
##         export myloop_counter=0; ./02_chain_job.sh

##################################################
## Tutorial ToDo: Define Comp. resources        ##
##################################################
#SBATCH ...

## Defaults
loop_max=10
cmd='sleep 2'

## Check if counter environment variable is set
if [ -z "${myloop_counter}" ] ; then 
   echo "  ERROR: environment variable myloop_counter is undefined, stop chain job"
   echo "         Setup manually: export myloop_counter=0"
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
      ## Interative: Continue only if last command was successful
      export myloop_counter=${myloop_counter}
      ./${0}
      ## Tutorial ToDo: SLURM - setup sbatch command + exporting myloop_counter via sbatch --export 
   else
      ## Terminate chain 
      echo "  ERROR: ${cmd} of chain job no. ${myloop_counter} terminated unexpectedly"
      exit 1
   fi
fi
