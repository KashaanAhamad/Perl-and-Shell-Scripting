#!/bin/bash

# Loop 1: Print the square of numbers 1 to 10
# Uses built-in arithmetic expansion $(( ... ))
for i in {1..10}
do
    echo "$i * $i = $((i * i))"
done

# Loop 2: Classify numbers 1 to 100 as even or odd
# Uses shell-builtin arithmetic evaluation (( ... )) for better performance
for i in {1..100}
do 
	# This can also be written as (( i % 2 == 0 )) for better Performance
	if  [ `expr $i % 2` -eq 0 ] 
	then
		echo "$i even"
	else 
		echo "$i odd"
	fi
done








