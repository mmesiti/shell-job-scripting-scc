#!/bin/bash

##################################################
## HEADER: Define here your Compute resources   ##
##################################################
#SBATCH -J test
#SBATCH -N1 -n1 --mem=50
#SBATCH -t 00:05:00
#SBATCH --mail-type=all
#SBATCH --export="my_own_variable=arguments"



##################################################
## BODY: if clause: interactive/SLURM           ##
##################################################

if [ ! -z ${SLURM_JOB_NAME} ] ; then
   printenv | grep -E "(SLURM|my_own_variable)"
else
   printenv | grep -E "^[A-Z]" | grep -v "LS_COLORS"
fi
