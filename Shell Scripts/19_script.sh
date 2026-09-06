#!/bin/bash

# ==========================================================
# PURPOSE: Extract a specific range of lines from a file
#          using 'tail' and 'head'.
#
# USAGE:   ./19_script.sh <start_line> <count> <filename>
# EXAMPLE: ./19_script.sh 4 6 file.txt (prints 6 lines from line 4)
# ==========================================================

# 1. Validate argument count
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <start_line> <line_count> <filename>"
    echo "Example: $0 4 6 file.txt"
    exit 1
fi

start_line="$1"
line_count="$2"
target_file="$3"

# 2. Validate that start_line and line_count are positive integers
if ! [[ "$start_line" =~ ^[0-9]+$ ]] || [ "$start_line" -le 0 ]; then
    echo "Error: start_line must be a positive integer."
    exit 1
fi

if ! [[ "$line_count" =~ ^[0-9]+$ ]] || [ "$line_count" -le 0 ]; then
    echo "Error: line_count must be a positive integer."
    exit 1
fi

# 3. Check if target file exists and is readable
if [ ! -f "$target_file" ]; then
    echo "Error: File '$target_file' does not exist."
    exit 2
fi

if [ ! -r "$target_file" ]; then
    echo "Error: Cannot read file '$target_file' (Permission denied)."
    exit 3
fi

# 4. Extract lines using modern tail/head syntax
# tail -n +X : Start reading from line X to the end
# head -n Y  : Take the first Y lines from the stream
tail -n +"$start_line" "$target_file" | head -n "$line_count"

# ==========================================================
# Alternative one-liner using sed:
# end_line=$((start_line + line_count - 1))
# sed -n "${start_line},${end_line}p" "$target_file"
# ==========================================================

# lines excercise question using tail and head
# if [ $# -eq 3 ]
# then
#	if [ -e $3 ]
#	then
#		tail +$1 $3 | head -n$2
#	else
#		echo "error opening file $3"
#		exit 2
#	fi
# else
#	echo "missing arguments"
# fi