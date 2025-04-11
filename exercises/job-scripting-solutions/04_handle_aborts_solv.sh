#!/bin/bash

## This is part of workshop: Advanced HPC and Data Management topics
## Autor: robert.barthel@kit.edu

## Pre-termination via Slurm
## sending signal with defined offset

#SBATCH -n1 -t 00:01:00 --mem=250
#SBATCH --signal=B:15@10

cleanup(){
  echo "Cleanup before walltime reached"
  exit 0
}

trap cleanup 15

echo "Repeating \"sleep 1\" loop until SIGTERM"
i=1
while true ; do
  sleep 1
  echo $i; let i+=1 
done
