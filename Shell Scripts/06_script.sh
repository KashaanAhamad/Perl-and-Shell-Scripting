#!/bin/bash

# Problem If any filename contains a space, tab, or newline, the shell splits the name into 
# separate items, breaking the loop.

echo "List files/directories in ~ directory:"
for f in $(ls ~/*)
do 
	echo "$f"
done

# Alternate Approach
echo "List of files/directories in ~ directory:"

# Direct globbing is the safest and recommended way to loop over files in Bash
for f in ~/*
do 
    # Check if the file/directory actually exists (handles the case of empty directories)
    if [ -e "$f" ]; then
        # Double quote the variable to handle filenames with spaces correctly
        echo "$f"
    fi
done

# -e file | file/path exists
# -f file | is a regular file 
# -d file | is a directory    
# -r file | is readable       
# -w file | is writable       
# -x file | is executable    
