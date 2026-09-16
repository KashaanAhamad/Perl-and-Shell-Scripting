#!/bin/bash

# ==============================================================================
# PURPOSE: Fundamental Bash Concepts:
#   1. Process IDs ($$) & Output Redirection
#   2. Function Definitions & Function Parameters ($1)
#   3. Date Arithmetic & System Utility Functions
# ==============================================================================

# ==============================================================================
# 1. PROCESS ID ($$) AND LOGGING
# ==============================================================================
# The '$$' special parameter holds the Process ID (PID) of the current shell.
# Appending (>>) records the execution PID to a log file.
# ==============================================================================
echo "=== 1. Process ID Demonstration ==="
echo "Current Script PID: $$"
echo "Logging PID $$ to output..."
echo "$$" >> output
echo

# ==============================================================================
# 2. FUNCTION DEFINITIONS & ARGUMENT PASSING
# ==============================================================================
# In Bash, functions can be defined with or without the 'function' keyword.
# Inside a function, $1, $2, etc. refer to the arguments PASSED TO THAT FUNCTION,
# not the script's command-line arguments.
# ==============================================================================
echo "=== 2. Functions and Arguments ==="

# Simple function without arguments
hello_world() {
    echo "Hello World!"
}

# Function accepting a parameter ($1)
greet_user() {
    local name="${1:-Friend}"   # Default to 'Friend' if no argument passed
    echo "Hello $name, let us be friends!"
}

# Calling functions:
hello_world
greet_user "Kashaan"
greet_user                      # Uses fallback default 'Friend'
echo

# ==============================================================================
# 3. DATE UTILITY FUNCTIONS
# ==============================================================================
# Demonstrates running GNU date arithmetic inside a wrapper function.
# ==============================================================================
echo "=== 3. Date Arithmetic Function ==="

# Function to display yesterday's date
get_yesterday() {
    date --date='1 day ago' "+%A, %d %B %Y (%Y-%m-%d)"
}

echo -n "Yesterday's Date: "
get_yesterday

echo
echo "All demonstrations finished successfully."
exit 0
