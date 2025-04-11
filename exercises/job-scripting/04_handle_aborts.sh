#!/bin/bash

## This is part of workshop: Advanced HPC and Data Management topics
## Autor: robert.barthel@kit.edu

## Pre-termination via Slurm
## sending signal with defined offset 

#SBATCH -n1 -t 00:01:00 --mem=250
#SBATCH --signal=B:15@10

## cleanup function
cleanup (){
   ... message ...
   ... exit_+_code ...
} 

trap ...function_name  signal_to_trap... 

... message ...
... set counter ...
while true ; do
   ...sleep_1_sec...
   ...message counter...
   ...increase counter...
done
