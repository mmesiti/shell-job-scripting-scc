#!/bin/bash
##################################################
## Simple file generator for demonstrating      ##
## batch jobs using $TMPDIR                     ##
##################################################
## ver.  : 2017-04-06, Robert Barthel, KIT, SCC

## Defaults
WDIR=$(pwd)
ref_inp="01_gen_files.inp"
ref_exe="01_gen_files.x"
max_files=""

## Read input
input=${1}

## Check input file, we force here that input file
## to be in the same folder as this script executable
## and has to be a particular name.
input=$(basename ${input} 2>/dev/null)
if [ "${input}" != "${ref_inp}" ] || [ ! -e "${ref_inp}" ] ; then
   printf "  ERROR: Missing ${ref_inp} at ${WDIR}\n"
   exit 1
fi

## Read from input file the number of files to be
## generated.
max_files=$(sed '/^$/d;/^#/d' ${ref_inp} 2>/dev/null | awk '{print $1}')
digits=$(echo $max_files | awk '{print int(log($1)/log(10))+1}')
if [ -n "${max_files}" ] ; then
   i=1
   while [ $i -le ${max_files} ] ; do
      outputname=files_$(printf '%0'${digits}'d' $i).out
      printf "  Generate ${outputname} ... "
      printf   "Generated ${WDIR}/${outputname} at: " > ${outputname}
      date >> ${outputname}
      if [ $? -eq 0 ] ; then
         printf "done\n"
      else
         printf "failed\n"
      fi
      let i+=1
   done
else
   printf "  ERROR: While reading no. of files to be generated\n"
fi
## vi:syntax=sh
