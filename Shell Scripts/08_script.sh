#!/bin/bash

# ==========================================================
# 1. C-style for loop: count from 1 to 10
# Syntax: for (( init; condition; step ))
# ==========================================================
# for ((a=1;a<=10;a=a+1))
echo "Counting from 1 to 10:"
for (( a = 1; a <= 10; a++ ))
do
    echo "$a"
done

echo

# ==========================================================
# 2. Nested C-style for loops: print a 5x5 number grid
# ==========================================================
echo "5x5 Pattern grid:"
for (( i = 1; i <= 5; i++ ))
do
    # Inner loop prints the current row number 5 times on the same line
    for (( j = 1; j <= 5; j++ ))
    do
        echo -n "$i"
    done
    # Print a newline to move to the next row
    echo
done

