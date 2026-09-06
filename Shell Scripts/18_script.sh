#!/bin/bash

# ==========================================================
# PURPOSE: Demonstrate the difference between "$*" and "$@"
#          when modifying IFS, and demonstrate 'shift'.
# ==========================================================

# Provide sample default arguments if none were supplied
if [ "$#" -eq 0 ]; then
    echo "No arguments passed. Setting default arguments: apple banana cherry date"
    set -- apple banana cherry date
fi

echo "=================================================="
echo "1. Difference between \"\$*\" and \"\$@\" with IFS"
echo "=================================================="

# Save original IFS and set IFS to comma
OLD_IFS="$IFS"
IFS=","

echo "Displaying with \"\$@\" (each argument remains separate):"
for arg in "$@"; do
    echo "  -> $arg"
done

echo
echo "Displaying with \"\$*\" (all arguments joined by IFS delimiter):"
echo "  -> $*"

# Restore default IFS
IFS="$OLD_IFS"

echo
echo "=================================================="
echo "2. Iterating through arguments using 'shift'"
echo "=================================================="

step=1
while [ "$#" -gt 0 ]
do
    echo "Step $step:"
    echo "  Current \$1          : $1"
    echo "  Remaining arguments (\$@) : $@"
    echo "  Arguments left (\$#)     : $#"
    shift       # Drops $1 and shifts $2 -> $1, $3 -> $2 ...
    ((step++))
    echo
done

echo "All arguments processed!"

