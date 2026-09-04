#!/bin/bash

# ==========================================================
# PURPOSE: Interactive Even/Odd checker with sentinel exit
# Continuously prompts for integers until -999 is entered.
# ==========================================================

while :
do
    # Read user input safely with -r
    read -r -p "Enter a number (-999 to exit): " n

    # Check for empty input
    if [ -z "$n" ]; then
        echo "Please enter a value."
        continue
    fi

    # Check for exit sentinel value
    if [ "$n" = "-999" ]; then
        echo "Bye!"
        break
    fi

    # Validate that input is a valid integer (positive or negative)
    if ! [[ "$n" =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$n' is not a valid integer."
        continue
    fi

    # Check even or odd using arithmetic evaluation
    if (( n % 2 == 0 )); then
        echo "Result: $n is even"
    else
        echo "Result: $n is odd"
    fi
    echo
done


#while :
#do
#	read -p "enter number (-999 to exit): " n
#	[ $n -eq -999 ] && { echo "Bye!"; break;}
#	even=$(( $n % 2))
#	[ $even -eq 0 ] && echo "$n is even" || echo "$n is odd"
#done