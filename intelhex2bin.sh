#!/usr/bin/env bash

# Check if a file name is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 inputfile.hex outputfile.bin"
    exit 1
fi

inputfile=$1
outputfile=$2

srec_cat $inputfile  -intel -o $outputfile -binary
