#!/bin/bash
##################################################
## simple script containing job to submitted as ##
## a chain of jobs for bwUniCluster 2.0         ##
##################################################
## ver.  : 2022-10-19, Robert Barthel, KIT, SCC

#SBATCH -J ws_case2
#SBATCH -p single
#SBATCH -N1 -n1 --mem=250
#SBATCH -t 00:00:05

## Define your command
cmd='sleep 30'

## Execute your command
echo "  -> executing ${cmd}"
${cmd}

## Do you check if correctly terminated
if [ $? -ne 0 ] ; then
   ## Terminate chain
   echo "  ERROR: ${cmd} of chain job no. ${myloop_counter:-1} terminated unexpectedly"
   exit 1
fi
