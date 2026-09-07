#!/bin/bash

# ==========================================================
# PURPOSE: Reverse a string character-by-character using
#          Bash parameter expansion substring slicing:
#          ${string:offset:length}
# ==========================================================

# 1. Argument validation
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <string_to_reverse>"
    echo "Example: $0 kashaan123"
    exit 1
fi

input="$1"
reverse=""
len=${#input}    # Length of the string

# 2. Loop backwards from the last character index (len - 1) down to 0
# Fixed: Replaced the single quote with a semicolon in the loop header
for (( i = len - 1; i >= 0; i-- ))
do
    # Extract 1 character at index i and append to reverse string
    reverse="${reverse}${input:$i:1}"
done

echo "Original string : $input"
echo "Reversed string : $reverse"

# ==========================================================
# NOTE: In Linux, you can also quickly reverse a string with:
# echo "$input" | rev
# ==========================================================
