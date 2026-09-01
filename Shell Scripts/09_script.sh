#!/bin/bash

# ==========================================================
# 1. Standard while loop (counts from 1 to 5)
# ==========================================================
echo "=== Standard while loop ==="
n=1
while [ "$n" -le 5 ]
do
    echo "$n (while)"
    ((n++))   # Increment n (alternative to n=$((n+1)))
done

# ==========================================================
# 2. Controlled loop demonstration (Infinite loop syntax)
# Syntax options for infinite loops:
#   while :
#   while true
#   while [ 1 ]
# ==========================================================
echo -e "\n=== Loop with break condition ==="
count=1
while :
do 
    echo "Loop iteration: $count (press Ctrl+C to stop if infinite)"
    if [ "$count" -ge 3 ]; then
        echo "Breaking out of loop..."
        break
    fi
    ((count++))
    sleep 1
done

# ==========================================================
# 3. Process Management & Background Jobs Reference
# ==========================================================
# kill -l                  # List all available signal names/numbers
# sleep 100 &              # Run command in background (returns PID)
# ps -ef | grep sleep      # Search for running processes matching 'sleep'
# kill -9 <PID>            # Force kill a process using its PID (SIGKILL)
# kill -15 <PID>           # Gracefully terminate a process (SIGTERM)

# ==========================================================
# 4. Note on IFS (Internal Field Separator)
# ==========================================================
# IFS defines the field delimiters (default: space, tab, newline)
# Example: IFS=":" can be used to parse /etc/passwd fields
