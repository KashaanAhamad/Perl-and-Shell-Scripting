#!/bin/bash

# ==========================================================
# PURPOSE: Search for embedded text strings within binary
#          executable files in a directory using 'strings'.
#
# USAGE:   ./25_script.sh [directory] [search_string]
# EXAMPLE: ./25_script.sh /usr/bin "free software"
# ==========================================================

# 1. Check if 'strings' command is available (binutils package)
if ! command -v strings &> /dev/null; then
    echo "Error: 'strings' command not found. Please install binutils."
    exit 1
fi

# 2. Configurable directory and search string (with defaults)
directory="${1:-/usr/bin}"
fstring="${2:-free software}"

# Validate target directory
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

echo "=========================================================="
echo "Searching for \"$fstring\" in binaries under $directory..."
echo "=========================================================="

# 3. Use find with process substitution for safe path handling
# -maxdepth 1 : Restrict search to top-level of the directory
# -type f     : Regular files only
match_count=0

while IFS= read -r file
do
    # Run strings -f (print filename), search for string, redirect stderr
    if strings -f "$file" 2>/dev/null | grep -i --color=auto "$fstring"; then
        ((match_count++))
    fi
done < <(find "$directory" -maxdepth 1 -type f 2>/dev/null | sort)

echo "=========================================================="
echo "Search completed. Found in $match_count file(s)."
echo "=========================================================="

# Return 0 if matches were found, 1 otherwise
[ "$match_count" -gt 0 ] && exit 0 || exit 1



# for file in $( find $directory -type f -name '*' | sort )
# do
# 	strings -f $file | grep "$fstring" # | sed -e "s%$directory%%"
# done