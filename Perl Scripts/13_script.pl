#!/usr/bin/perl -w
#
# =============================================================================
# Script 13: Formatted Output with 'printf' (Counter-Based Loop)
# =============================================================================
# TOPIC  : Generating tables of formatted numbers using C-style loops
# CONCEPTS:
#   1. C-style 'for' loop without generating an in-memory list
#   2. 'printf' syntax: printf FORMAT_STRING, LIST_OF_VALUES
#   3. Format specifiers: %g (general number) vs %d (integer) vs %f (float)
#   4. Field width and right-alignment (%5g, %8g)
#   5. Comparison: Script 13 (counter-based) vs Script 14 (list-based with '..')
# =============================================================================

# --- Print Table Header ---
# Using printf ensures header columns line up precisely with data rows below.
printf "%5s %8s\n", "Num", "Square";
printf "%5s %8s\n", "-----", "--------";

# --- Counter-Based Loop (Without a List) ---
# Here we increment a counter from 2 to 32 without creating an intermediate
# array or list in memory.
for ($number = 2; $number <= 32; $number++) {
    
    # Calculate square
    $square = $number * $number;
    
    # --- Formatted Print (printf) ---
    # "%5g" : Reserves at least 5 character spaces, right-aligned.
    #         '%g' automatically chooses between standard and scientific notation.
    # "%8g" : Reserves at least 8 character spaces, right-aligned.
    # "\n"  : Appends a newline at the end of each table row.
    printf "%5g %8g\n", $number, $square;
}
