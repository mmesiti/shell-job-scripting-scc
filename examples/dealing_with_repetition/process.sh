#!/bin/bash

if [ -f "$1" ]; then
    echo -n "Processing $1..."
    sleep 1
    echo " done."
else
    echo "Error: $1 is not a standard file."
fi
