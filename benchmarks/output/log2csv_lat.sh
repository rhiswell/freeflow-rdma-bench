#!/bin/bash

[[ -z "$1" ]] && echo "Usage: ./$0 <file_to_read>" && exit 1

file_to_read=$1

cat $file_to_read | egrep '^[0-9]' > ${file_to_read}.csv
