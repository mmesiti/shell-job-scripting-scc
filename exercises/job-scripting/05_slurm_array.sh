#!/bin/bash
###################################################
## S O L U T I O N  of Tutorial Case 5a:         ##
## Complete script template for bwUniCluster 2.0 ##
## to run job arrays                             ##
## * Transcribe input index into real numbers    ##
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
##   ^#SBATCH --array=<indexes>             = defines array
##   ^#SBATCH --output=<string>             = defines output file name + pattern
##   
##
## Note:
##   - all '#SBATCH -?' are equivalent to 'sbatch -?'
##   - for more options, see 'man sbatch'
##   - '# SBATCH' is a comment, while '#SBATCH' is a sbatch option statement
##
##################################################
## HEADER: Define here your Compute resources   ##
##################################################
#SBATCH -J ws_array
#SBATCH -N1 -n2 
#SBATCH -t 00:01:00
#SBATCH --array=0-10:2
# SBATCH --output=array_%A-%2a.out

printenv | grep "SLURM_ARRAY"

## Generate real number
echo ${SLURM_ARRAY_TASK_ID} |awk '{printf "%.4f\n", exp($X)}'
sleep 2
