#!/bin/bash

## This is part of workshop: Advanced HPC and Data Management topics
## Autor: robert.barthel@kit.edu

#SBATCH -n? -N1 
#SBATCH --mem=250
#SBATCH -t 00:03:00

module load system/parbatch

parbatch ./03_joblist.txt 
