#!/bin/bash
##################################################
## Tutorial - ToDo/TASK:                        ##
## JOB ARRAYs                                   ##
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

##################################################
## HEADER: Define here your Compute resources   ##
##################################################
#SBATCH -J FakeArray
#SBATCH -N1 -n1 --mem=250
#SBATCH -t 00:05:00
#SBATCH --export="All,IARR=0-10:2"

##################################################
## Declarations: setup environment etc.         ##
##################################################
## Define subjob script
subjob="./05_array_task.sh"
## Decipher index setup: min-max=inc
IARR=${IARR:-1-5:1}
if [[ ${IARR/://} == ${IARR} ]] ; then inc=1 ; else inc=${IARR/*:} ; fi
IARR=${IARR/:*}
if [[ ${IARR/-//} == ${IARR} ]] ; then max=1 ; else max=${IARR/*-} ; fi
min=${IARR/-*}
## Number of digits of max
ndm="${#max}"

#module load ...something_for_pseudoparallelization...

##################################################
## BODY:                                        ##
##################################################
## Generate index list with given increment
echo "Generate index list from ${min} to ${max} with increment ${inc}"
## Loop
while [[ $min -le $max ]] ; do
   printf "  Execute ${subjob} %0${ndm}d\n" "${min}"
   ## Generate list of jobs of the array and store them to a file
   #...print.. ${subjob} $(printf "%0${ndm}d" "${min}") ...to_filelist...
   let min+=${inc}
done 

#...execute pseudo parallelizer... 
