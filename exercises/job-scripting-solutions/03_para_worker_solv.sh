#!/bin/bash

## Purpose: a) Execute user command: 
##          b) Remove lock file

## DEFAULTS ##
lock_file=${1}
log_file=${2}
cmd="sleep 2"          ## user command for this tutorial

## Execute command (cmd) and protocol execution time and finishing time to log file
echo "Starting  time: $(date)" > ${log_file} 
${cmd} >> ${log_file} 2>&1

## Determine exit status of command
stat_cmd=$? 

## Remove lock file
if [ "${stat_cmd}" -eq 0 ] ; then
   echo "Job successfully finished" >> ${log_file}
   rm -f "${lock_file}"
else
   echo "Job finished with error" >> ${log_file} 
fi
echo "Finishing time: $(date)" >> ${log_file}

