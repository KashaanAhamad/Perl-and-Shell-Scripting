#!/bin/bash

# ==========================================================
# PURPOSE: Demonstrate the 'continue' keyword and solve a
#          system of congruences:
#          Find numbers < 1000 such that:
#          - number % 5 == 3
#          - number % 7 == 4
#          - number % 9 == 5
# ==========================================================

maximum=1000

echo "Searching for numbers < $maximum meeting all conditions:"

for (( nr = 1; nr < maximum; nr++ ))
do
	# Can also use let(Less efficient)
	# let "t1 = nr % 5"
	# if [ "$t1" -ne 3 ]
	# then
	# 	continue
	# fi

    # Condition 1: Must leave remainder 3 when divided by 5
    if (( nr % 5 != 3 )); then
        continue    # Skip to next iteration
    fi

    # Condition 2: Must leave remainder 4 when divided by 7
    if (( nr % 7 != 4 )); then
        continue    # Skip to next iteration
    fi

    # Condition 3: Must leave remainder 5 when divided by 9
    if (( nr % 9 != 5 )); then
        continue    # Skip to next iteration
    fi

    # If all checks passed, print the matching number
    echo "Matching Number found = $nr"
    # Uncomment 'break' below if you only want to find the first match (58)
    # break
done

echo "Loop completed. Final index value = $nr"
exit 0

