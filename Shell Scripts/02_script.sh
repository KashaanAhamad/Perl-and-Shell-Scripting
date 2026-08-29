#!/bin/bash

# A simple for loop iterating over a range of numbers
# Using brace expansion {1..5} is the standard Bash way to define ranges
# for i in 1 2 3 4 5 =>This also works
for i in {1..5}
do 
    echo "list item $i"
done

# A for loop iterating over a space-separated list of strings
for car in maruti honda toyota ford
do
    echo "car make(list) $car"
done




