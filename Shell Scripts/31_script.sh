#!/bin/bash

# ==============================================================================
# PURPOSE: Extract and enumerate all usernames from /etc/passwd.
# ==============================================================================

PASSWORD_FILE="${1:-/etc/passwd}"

if [ ! -f "$PASSWORD_FILE" ]; then
    echo "Error: Password file '$PASSWORD_FILE' not found."
    exit 1
fi

echo "=========================================================="
echo "APPROACH 1: Corrected Bash Loop with AWK -F:"
echo "=========================================================="
n=1
# Fixed: Used -F: (in AWK, the field separator is FS, not IFS)
for name in $(awk -F: '{print $1}' "$PASSWORD_FILE")
do 
    echo "User #$n = $name"
    ((n++))
done

echo
echo "=========================================================="
echo "APPROACH 2: Pure AWK (One-Liner using built-in NR counter)"
echo "=========================================================="
# NR automatically provides the line/record number
awk -F: '{ printf("User #%d = %s\n", NR, $1) }' "$PASSWORD_FILE"

echo
echo "=========================================================="
echo "APPROACH 3: Pure Bash while read (Zero external processes)"
echo "=========================================================="
count=1
while IFS=: read -r username _
do
    [ -n "$username" ] && echo "User #$count = $username"
    ((count++))
done < "$PASSWORD_FILE"

exit 0


# PASSWORD_FILE=/etc/passwd
# n=1
# for name in $(awk 'BEGIN{IFS=":"} {print $1}' < "$PASSWORD_FILE" )
# do 
# 	echo "User #$n= $name"
#        let "n += 1"
# done
