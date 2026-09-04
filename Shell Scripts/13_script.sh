#!/bin/bash

# ==========================================================
# PURPOSE: Demonstrate the 'until' loop in Bash
#
# 'until' loop executes while the condition is FALSE.
# It stops as soon as the condition becomes TRUE.
# (Opposite behavior of the 'while' loop)
# ==========================================================

echo "=== Counting 1 to 6 using an 'until' loop ==="

i=1
until [ "$i" -gt 6 ]
do
    echo "Iteration: $i"
    ((i++))    # Increment i (alternative: i=$((i + 1)))
done

