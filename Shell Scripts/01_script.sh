#!/bin/bash

# -r = raw input ( '\' is interpereted as typed character)
# Prompt the user for an integer value
read -r -p "Enter a number: " value

# Check if the input is a valid integer
if ! [[ "$value" =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$value' is not a valid integer."
    exit 1
fi

# Instead of using -a operator, used && operator
# Verify if the number is within the range [1, 100]
if [[ "$value" -ge 1 && "$value" -le 100 ]]; then
    echo "Yes, the number $value is between 1 to 100"
else
    echo "No, the number $value is outside the range 1 to 100"
fi
