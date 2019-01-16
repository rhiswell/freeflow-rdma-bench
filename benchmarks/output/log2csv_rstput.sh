#!/bin/bash

[[ -z "$1" ]] && echo "Usage: ./$0 <file_to_read>" && exit 1

file_to_read=$1

cat $file_to_read | grep -A7 sender | grep bits_per_second | awk '{ print $2 }' | awk -F',' '{ printf "%d,%.2f\n", 2**NR, $1/1e9 }' > ${file_to_read}.csv
