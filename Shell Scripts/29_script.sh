#!/bin/bash

# ==============================================================================
# PURPOSE: Generate an ASCII table showing Decimal, Hex, Octal, and Character.
# ==============================================================================

echo "=========================================================="
echo "               ASCII CHARACTER TABLE (1 - 127)            "
echo "=========================================================="
printf "%-7s | %-6s | %-6s | %-12s\n" "Decimal" "Hex" "Octal" "Character"
echo "----------------------------------------------------------"

# Efficient: Run once in AWK using the BEGIN block
awk 'BEGIN {
    for (i = 1; i <= 127; i++) {
        # Identify special non-printable control characters
        if (i == 7)       desc = "BEL (Bell)"
        else if (i == 8)  desc = "BS  (Backspace)"
        else if (i == 9)  desc = "TAB (Tab)"
        else if (i == 10) desc = "LF  (Line Feed)"
        else if (i == 13) desc = "CR  (Carriage Return)"
        else if (i == 27) desc = "ESC (Escape)"
        else if (i == 32) desc = "SPC (Space)"
        else if (i == 127) desc = "DEL (Delete)"
        else if (i < 32)  desc = sprintf("Ctrl+%c", i + 64)
        else              desc = sprintf("%c", i)

        printf("%-7d | 0x%-4X | %03o    | %-12s\n", i, i, i, desc)
    }
}'

echo "=========================================================="
exit 0


# for ((a =1;a<=127;a=a+1))
# do
# 	echo $a | awk '{printf("%d, %x, %o, %3c\n",$1,$1,$1,$1)}'
# done
