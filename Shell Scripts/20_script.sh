#!/bin/bash

# ==========================================================
# PURPOSE: Sum all digits of a given integer.
# EXAMPLE: Input: 1234  ==> Output: 1 + 2 + 3 + 4 = 10
# ==========================================================

# 1. Argument check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <integer>"
    echo "Example: $0 1234 (prints: 1+2+3+4 = 10)"
    exit 1
fi

input="$1"

# 2. Validate that input is an integer (allows optional leading minus sign)
if ! [[ "$input" =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$input' is not a valid integer."
    exit 1
fi

# Strip leading minus sign if present
n="${input#-}"
original_n="$n"
sum=0

# 3. Sum digits using built-in Bash arithmetic
while (( n > 0 ))
do
    sd=$(( n % 10 ))      # Extract the last digit
    (( sum += sd ))       # Add digit to sum
    (( n /= 10 ))         # Remove the last digit
done

echo "Sum of digits for $input is: $sum"



#if [ $# -ne 1 ]
#then
#	echo "Usage: $0 number"
#	echo "sum all digit of a given number"
#	echo "eg. 123, print 1+2+3=6"
#	exit 1
#fi
#n=$1
#sum=0
#sd=0
#while [ $n -gt 0 ]
#do
#	sd=`expr $n % 10`
#	sum=`expr $sum + $sd`
#	n=`expr $n / 10`
#done
#echo "sum of digits for number is $sum"