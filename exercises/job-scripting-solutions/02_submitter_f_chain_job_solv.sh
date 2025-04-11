#!/bin/bash
##################################################
## simple slurm submitter script to setup       ## 
## a chain of jobs for bwUniCluster 2.0         ##
##################################################
## ver.  : 2022-10-19, Robert Barthel, KIT, SCC

## Define maximum number of jobs via positional parameter 1, default is 5
max_nojob=${1:-5}
 
## Define your jobscript (e.g. "~/chain_job.sh")
chain_link_job=${PWD}/02_chain_link_job_solv.sh

## Define sbatch options
qs_opt="-p single"

## Define type of dependency via positional parameter 2, default is 'afterok'
dep_type="${2:-afterok}"
## -> List of all dependencies:
## https://slurm.schedmd.com/sbatch.html

myloop_counter=1
## Submit loop
while [ ${myloop_counter} -le ${max_nojob} ]; do
   ##
   ## Differ slurm_opt depending on chain link number
   if [ ${myloop_counter} -eq 1 ] ; then
      slurm_opt=""
   else
      slurm_opt="-d ${dep_type}:${jobID}"
   fi
   ##
   ## print current Job number
   echo "Chain job iteration = ${myloop_counter}"
   echo "   sbatch ${qs_opt} --export=myloop_counter=${myloop_counter} ${slurm_opt} ${chain_link_job}"
   ## Store job ID for next iteration by storing output of sbatch command with empty lines
   jobID=$(sbatch ${qs_opt} --export=ALL,myloop_counter=${myloop_counter} ${slurm_opt} ${chain_link_job} 2>&1 | sed 's/[S,a-z]* //g')
   ##
   ## Check if ERROR occured
   if [[ "${jobID}" =~ "ERROR" ]] ; then
      echo "   -> submission failed!" ; exit 1
   else
      echo "   -> job number = ${jobID}"
   fi
   ##
   ## Increase counter
   let myloop_counter+=1
done


