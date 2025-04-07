#!/bin/bash
X="$1"
OUTPUT="out_$X.dat"
echo -n "Simulating for value $X, saving output in $OUTPUT..."
sleep 1
touch "$OUTPUT"
echo "Done"

