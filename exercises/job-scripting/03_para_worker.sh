#!/bin/bash

## Purpose: a) Execute user command: 
##          b) Remove lock file

## DEFAULTS ##
lock_file=...get from positional parameter...
log_file=...get from positional parameter...
cmd="sleep 2"          ## user command for this tutorial

## Execute command (cmd) and protocol execution time and finishing time to log file
...date...to...log
...command...with...stdout...stderr...to...log

## Determine exit status of command
...status...of...command...to...log

## Remove lock file
...conditional...remove...depending...on...command...status

## Finishing
...date...to...log

