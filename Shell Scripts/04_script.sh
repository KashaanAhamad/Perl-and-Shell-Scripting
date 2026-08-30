#!/bin/bash

# Print even numbers from 1 to 100 on a single line
echo "Even numbers:"
for i in {1..100}
do 
	# if [ `expr $i % 2` -eq 0 ] alternative
    if (( i % 2 == 0 )); then 
        echo -n "$i "
    fi
done
# Print a newline at the end
echo
echo

# Print odd numbers from 1 to 100 on a single line
echo "Odd numbers:"
for i in {1..100}
do 
	# if [ `expr $i %2` -ne 0 ] alternative
    if (( i % 2 != 0 )); then
        echo -n "$i "
    fi
done
# -n prints the value in same line
# Print a newline at the end
echo
