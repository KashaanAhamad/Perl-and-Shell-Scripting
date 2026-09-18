#!/bin/bash

# ==============================================================================
# PURPOSE: Calculate Factorial (N!) using:
#   1. Recursive Function Calls
#   2. Fast Iterative Loop
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Recursive Factorial Function
# ------------------------------------------------------------------------------
factorial_recursive() {
    local n="$1"

    # Base case: 0! = 1 and 1! = 1 (Fixed 0! bug)
    if (( n <= 1 )); then
        echo 1
        return 0
    fi

    # Recursive step: n! = n * (n-1)!
    local prev
    prev=$(factorial_recursive "$(( n - 1 ))")
    echo "$(( n * prev ))"
}

# ------------------------------------------------------------------------------
# 2. Fast Iterative Factorial (0 subshell forks)
# ------------------------------------------------------------------------------
factorial_iterative() {
    local n="$1"
    local result=1

    for (( i = 2; i <= n; i++ ))
    do
        (( result *= i ))
    done

    echo "$result"
}

# ==============================================================================
# SCRIPT ENTRYPOINT & VALIDATION
# ==============================================================================

# 1. Check argument count
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <non-negative integer>"
    echo "Example: $0 5  (Output: 120)"
    exit 1
fi

num="$1"

# 2. Validate non-negative integer format
if ! [[ "$num" =~ ^[0-9]+$ ]]; then
    echo "Error: '$num' is not a valid non-negative integer."
    exit 1
fi

# 3. Check for 64-bit integer overflow warning (> 20)
if (( num > 20 )); then
    echo "Note: $num! exceeds standard 64-bit integer capacity (max is 20!)."
    echo -n "Using 'bc' for large precision: "
    # Calculate using seq and bc
    seq -s "*" 1 "$num" | bc
    exit 0
fi

echo "=========================================================="
echo "Calculating Factorial for N = $num"
echo "=========================================================="

echo -n "Recursive Method : $num! = "
factorial_recursive "$num"

echo -n "Iterative Method : $num! = "
factorial_iterative "$num"

echo "=========================================================="
exit 0
