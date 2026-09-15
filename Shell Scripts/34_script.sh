#!/bin/bash

# ==========================================================
# PURPOSE: Count occurrences of each word in a text file
# ==========================================================

# 1. Argument check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    echo "Example: $0 mytext.txt"
    exit 1
fi

filename="$1"

# 2. Validate file exists
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

echo "Word Frequency Count for '$filename':"
echo "----------------------------------"

# 3. Process file using tr, grep, sort, and uniq
#    - tr -s ' ' '\n': squeezes multiple spaces and replaces with newlines
#    - tr -d '[:punct:]': deletes all punctuation
#    - tr '[:upper:]' '[:lower:]': converts to lowercase for case-insensitive counting
#    - grep -v '^$': removes empty lines
#    - sort: sorts the words alphabetically
#    - uniq -c: counts unique adjacent lines
#    - sort -nr: sorts numerically in reverse (highest count first)
tr -s ' ' '\n' < "$filename" | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | grep -v '^$' | sort | uniq -c | sort -nr
