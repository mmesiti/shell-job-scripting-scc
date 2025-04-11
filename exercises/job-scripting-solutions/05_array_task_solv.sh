#!/bin/bash
##################################################
## Tutorial - ToDo/TASK:                        ##
## Complete subjob script for bwUniCluster      ##
## to retrieve index value                      ##
## and echo index value to indexed output file  ##
##################################################

## Get index value via positional parameter
value="${1:?missing_value}"

## Define name of output file
outputfile="array_${SLURM_JOB_ID:-$$}-${value}.out" 

## Write value to file
echo ${value} > ${outputfile}
