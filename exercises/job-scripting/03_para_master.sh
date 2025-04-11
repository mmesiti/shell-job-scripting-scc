#!/bin/bash

## This is part of workshop: Advanced HPC and Data Management topics
## Autor: robert.barthel@kit.edu

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
slave_sh=para_worker.sh
lock_file=lock

## LOOP ##
i=1 
while ...loop_counter < max_loop...  ; do
   
   ## If lock does not exists -> execute slave job
   if ...lock does not exist... ; then
      ...generate...lock...
      ...set...filename...for...log
      ...execute worker job script...with...name...of...lock/log...files
      ...increase...loop_couter
   fi

   ## Do not finish current iteration until lock disappears 
   while ...No of lock files -ge 1... ; do
      sleep 2 
   done 

done
