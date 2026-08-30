#!/bin/bash

# Loop through a list of commands: date, pwd, df
for cmd in date pwd df
do
    echo "========================================="
    echo "The output of the '$cmd' command is:"
    echo "========================================="
    
    # Check if the command is available on the system
	# /dev/null ==> You can think of it as a black hole for data. Anything written to it is discarded.
	# command -v ==> It is used to check if a command is available on the system.
	# &> ==> Run command -v "$command" and throw away both its normal output and error output or redirect it to same place.
	# The $? variable stores the exit status of the last executed command.
	# If the command is found, $? will be 0.
	# If the command is not found, $? will be non-zero.

    if command -v "$cmd" &> /dev/null; then
        # Execute the command directly so its output formatting (newlines/spaces) is preserved
        "$cmd"
    else
        echo "Error: Command '$cmd' not found."
    fi
    echo
done
