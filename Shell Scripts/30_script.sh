#!/bin/bash -x  #-v

# ==============================================================================
# PURPOSE: Calculate the sum, count, and average of a specified column in a file.
#
# USAGE:   ./30_script.sh <filename> <column_number>
# EXAMPLE: ./30_script.sh data.txt 2
# ==============================================================================

# 1. Argument validation
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <filename> <column_number>"
    echo "Example: $0 data.txt 2"
    exit 1
fi

filename="$1"
column_number="$2"

# 2. Check if file exists and is readable
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# 3. Check if column_number is a positive integer
if ! [[ "$column_number" =~ ^[0-9]+$ ]] || [ "$column_number" -le 0 ]; then
    echo "Error: Column number must be a positive integer."
    exit 1
fi

echo "Calculating statistics for Column #$column_number in '$filename'..."
echo "----------------------------------------------------------"

# 4. Standard AWK way: pass shell variables using -v col="$column_number"
awk -v col="$column_number" '
BEGIN {
    count = 0
    total = 0
}
{
    # Check if the column exists and contains a valid numeric value
    if ($col ~ /^-?[0-9]+(\.[0-9]+)?$/) {
        total += $col
        count++
    }
}
END {
    if (count > 0) {
        printf("Rows processed : %d\n", count)
        printf("Total Sum      : %.2f\n", total)
        printf("Average / Mean : %.2f\n", total / count)
    } else {
        print "No numeric data found in column " col
    }
}' "$filename"

echo "----------------------------------------------------------"
exit 0



# filename=$1
# column_number=$2

# awk ' { total += $'"${column_number}"' } END { print total } ' "$filename"

# awk '$"${ column_number }"' "$filename"