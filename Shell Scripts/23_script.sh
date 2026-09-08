#!/bin/bash

# ==========================================================
# PURPOSE: Trap multiple signals (Ctrl+C, Ctrl+\, Ctrl+Z)
#          and run an interactive Even/Odd counter game.
# ==========================================================

# Declare integer variables
declare -i times=0
declare -i n=0

# Trap SIGINT (Ctrl+C), SIGQUIT (Ctrl+\), and SIGTSTP (Ctrl+Z)
trap 'echo -e "\n[!] Signals (Ctrl+C, Ctrl+\, Ctrl+Z) are disabled. Enter -999 to exit."' SIGINT SIGQUIT SIGTSTP

echo "=========================================================="
echo "Interactive Even/Odd Game (Exit with -999)"
echo "Signals (Ctrl+C, Ctrl+\, Ctrl+Z) are trapped."
echo "=========================================================="

while true
do
    read -r -p "Enter number (-999 to exit): " user_input

    # Check for empty input
    if [ -z "$user_input" ]; then
        echo "Please enter a valid number."
        continue
    fi

    # Exit sentinel check (fixed -999 comparison)
    if [ "$user_input" = "-999" ]; then
        echo "Bye!"
        break
    fi

    # Validate integer format
    if ! [[ "$user_input" =~ ^-?[0-9]+$ ]]; then
        echo "Error: '$user_input' is not a valid integer."
        continue
    fi

    n="$user_input"
    
    # Check even or odd
    if (( n % 2 == 0 )); then
        echo "-> $n is an EVEN number"
    else
        echo "-> $n is an ODD number"
    fi

    ((times++))    # Increment rounds played
    echo
done

# Reset traps before exiting
trap - SIGINT SIGQUIT SIGTSTP

echo "=========================================================="
echo "Game over! You played $times times."
echo "=========================================================="
exit 0
