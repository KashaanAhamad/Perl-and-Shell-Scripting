#!/bin/bash

# Define the file list using a Bash array (safer than a space-separated string)
# files="/etc/passwd /etc/group /etc/shadow /temp/myfile" # Not a good way to define a file list
files=("/etc/passwd" "/etc/group" "/etc/shadow" "/temp/myfile")

echo "Checking file statuses:"
for f in "${files[@]}"
do 
    # Check if the file is a regular file. Quoting "$f" is essential.
    if [ -f "$f" ]; then
        echo "$f: file found"
    else
        echo "$f: file missing"
    fi
done

echo -e "\nListing file details:"
for f in "${files[@]}"
do
    if [ -e "$f" ]; then
        # Run ls -l, redirecting standard error to /dev/null if permission is denied
        ls -l "$f" 2>/dev/null || echo "Permission denied to view: $f"
    else
        echo "File does not exist: $f"
    fi
done

# files="/etc/passwd /etc/group /etc/shadow /temp/myfile"
# for f in $files
# do
#    [ -f $f ] && echo "$f file found" || echo "$f file missing"
# done

# ls -l /etc/passwd
# ls -s /etc/group
# ls -l /etc/shadow
# ls -l /temp/myfile
