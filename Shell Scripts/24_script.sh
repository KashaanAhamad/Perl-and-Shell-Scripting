#!/bin/bash

# ==========================================================
# PURPOSE: Demonstrate using a custom callback function in
#          a signal trap to alter program state dynamically.
#
# HOW IT WORKS:
# 1. Main loop increments X by 1 every second.
# 2. Each Ctrl+C adds 500 to X.
# 3. When X exceeds 2000, the script terminates.
# ==========================================================

# 1. Define the signal handler callback function
increment() {
    echo -e "\n[TRAP] Caught SIGINT (Ctrl+C)! Adding 500 to X..."
    (( X += 500 ))
    echo "Current X value after jump: $X"
    
    if (( X > 2000 )); then
        echo "=========================================="
        echo "X reached $X (> 2000). Quitting script..."
        echo "=========================================="
        exit 0
    fi
}

# 2. Register the callback function for SIGINT (Ctrl+C)
trap increment SIGINT

X=0

echo "=========================================================="
echo "Counter running (Press Ctrl+C to jump X by +500)"
echo "The script will automatically exit when X > 2000"
echo "=========================================================="

# 3. Main counting loop
while true
do
    echo "X = $X"
    (( X++ ))
    sleep 1
done

# trap 'increment' 2
# 'increment' is a callback function when you press CTRL-C
# increment()
# {
# 	echo "Caught SIGINT ..."
# 	X=`expr ${X} + 500`
# 	if [ "${X}" -gt "2000" ]
# 	then
# 		echo "Okay, I'll quit.."
# 		exit 1
# 	fi
# }

# X=0
# while :
# do
# 	echo "X=$X"
# 	X=`expr ${X} + 1`
# 	sleep 1
# done