#!/usr/bin/awk -f

# ==============================================================================
# PURPOSE: AWK script to generate an income report for records with salary > 30000.
#
# USAGE:
#   awk -f 32_script.awk <data_file>
#   OR (if executable): ./32_script.awk <data_file>
#
# EXPECTED INPUT FORMAT:
#   <id> <name> <salary> <age> <dept_code>
#   101 Alice  45000 28 10
#   102 Bob    25000 24 20
#   103 Charlie 52000 35 10
# ==============================================================================

BEGIN {
    count = 0
    total = 0
    printf "\n\t\t==============================\n"
    printf "\t\t   FRIENDS INCOME ABSTRACT    \n"
    printf "\t\t==============================\n\n"
    printf "%-4s %-20s %-12s %-6s %-6s\n", "No.", "Name", "Salary", "Age", "Dept"
    printf "------------------------------------------------------\n"
}

# Process only records where the 3rd field (Salary) > 30000
$3 > 30000 {
    count++
    total += $3
    printf "%3d. %-20s $%-11.2f %-6d %-6d\n", count, $2, $3, $4, $5
}

END {
    printf "------------------------------------------------------\n"
    if (count > 0) {
        printf "Total Qualifying Records : %d\n", count
        printf "Total Combined Income    : $%.2f\n", total
        printf "Average Income           : $%.2f\n\n", total / count
    } else {
        printf "No records found with salary > 30000.\n\n"
    }
}


#!/bin/bash

# BEGIN {
# printf "\t\t friends abstract \n\n"
# } $3 > 30000 {
# 	count++; total+=$3
# 	printf "%3d %-20s %-12s %d %d\n",count, $2, $3, $4, $5
# }
# END {
# printf "\n\t average income %6d\n", total/count
# }
