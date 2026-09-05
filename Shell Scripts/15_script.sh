#!/bin/bash

# ==========================================================
# PURPOSE: Search for a target file in a directory using a
#          loop, flag variable, and early 'break'.
# ==========================================================

filetomatch="/etc/passwd"
found=0

echo "Searching for '$filetomatch' in /etc/..."

for f in /etc/*
do
    # Fixed: Added '$' to reference variable and quoted both operands
    if [ "$f" = "$filetomatch" ]; then
        echo "Match: $filetomatch was found!"
        found=1
        break   # Exit the loop early to save unnecessary iterations
    fi
done

# If flag was not set to 1, the file was not found
if [ "$found" -ne 1 ]; then
    echo "Result: $filetomatch was NOT found in /etc directory."
fi

# ==========================================================
# Note on production alternative:
# In real-world scripts, you can test directly without a loop:
# [ -f "$filetomatch" ] && echo "Found" || echo "Not found"
# ==========================================================
