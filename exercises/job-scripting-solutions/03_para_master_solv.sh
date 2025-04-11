#!/bin/bash

## Purpose: Write Loop that executes 10 times para_worker.sh but: 
##
##          a) the execution waits until file lock does NOT exist 
## 
##          b) the execution generates the file lock 
##
##          c) the successful termination of para_worker.sh removes
##             the lock file

## DEFAULTS ##
no_loop=10
worker=03_para_worker_solv.sh
lock_file=lock

## LOOP ##
i=1 
while (( $i <= ${no_loop} ))  ; do
   
   ## If lock does not exists -> execute worker job
   if [ ! -e "${lock_file}" ] ; then
      ## generate lock
      touch "${lock_file}"
      ## generate logfile name
      log_file=${worker%.sh}_${i}.log
      ## 
      ## execute job + options
      echo "Starting Job $i of ${worker}"
      ./${worker} "${lock_file}" "${log_file}"
      ## 
      ## increase counter
      let i+=1 
   fi

   ## Do not finish current iteration until lock disappears 
   while [ $(ls ${lock_file} 2>/dev/null | wc -l) -ge 1 ] ; do
      sleep 2 
   done 

done
