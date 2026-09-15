#!/bin/bash

# ==============================================================================
# PURPOSE: Print Even and Odd numbers within a range [start, end] with multiple
#          output formatting modes.
#
# USAGE:
#   ./33_script.sh <start> <end> [mode]
#
# MODES:
#   (none) : Default line-by-line classification
#   1      : Formatted in rows of 10 numbers per line
#   2      : All even numbers on one line, all odd numbers on the second line
#
# EXAMPLES:
#   ./33_script.sh 1 50
#   ./33_script.sh 1 50 1
#   ./33_script.sh 1 50 2
# ==============================================================================

# 1. Validate argument count
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <start_num> <end_num> [mode (1 or 2)]"
    echo "Example: $0 1 100 1"
    exit 1
fi

start_num="$1"
end_num="$2"
mode="$3"

# 2. Validate range bounds
if (( start_num > end_num )); then
    echo "Error: First number ($start_num) must be less than or equal to second number ($end_num)."
    exit 1
fi

# 3. Handle Formatting Modes
if [ -n "$mode" ]; then
    case "$mode" in
        1)
            # --------------------------------------------------
            # Mode 1: 10 numbers per line
            # --------------------------------------------------
            echo "=== Even Numbers (10 per line) ==="
            counteven=0
            for (( i = start_num; i <= end_num; i++ ))
            do
                if (( i % 2 == 0 )); then
                    printf "%4d " "$i"
                    ((counteven++))
                    if (( counteven % 10 == 0 )); then
                        echo
                    fi
                fi
            done
            echo -e "\n"

            echo "=== Odd Numbers (10 per line) ==="
            countodd=0
            for (( i = start_num; i <= end_num; i++ ))
            do
                if (( i % 2 != 0 )); then
                    printf "%4d " "$i"
                    ((countodd++))
                    if (( countodd % 10 == 0 )); then
                        echo
                    fi
                fi
            done
            echo
            ;;

        2)
            # --------------------------------------------------
            # Mode 2: Single continuous line for each
            # --------------------------------------------------
            echo "=== Even Numbers ==="
            for (( i = start_num; i <= end_num; i++ ))
            do
                if (( i % 2 == 0 )); then
                    echo -n "$i "
                fi
            done
            echo -e "\n"

            echo "=== Odd Numbers ==="
            for (( i = start_num; i <= end_num; i++ ))
            do
                if (( i % 2 != 0 )); then
                    echo -n "$i "
                fi
            done
            echo
            ;;

        *)
            echo "Unknown mode '$mode'. Valid modes are: 1 (10-per-line) or 2 (single line)."
            exit 1
            ;;
    esac
else
    # --------------------------------------------------
    # Default Mode: Line-by-line description
    # --------------------------------------------------
    echo "=== Classifying numbers from $start_num to $end_num ==="
    for (( i = start_num; i <= end_num; i++ ))
    do
        if (( i % 2 == 0 )); then
            echo "$i is an EVEN number"
        else
            echo "$i is an ODD number"
        fi
    done
fi

exit 0
