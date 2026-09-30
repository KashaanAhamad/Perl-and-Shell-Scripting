#!/usr/bin/perl -w
#
# =============================================================================
# Script 14: Formatted Output with 'printf' (List-Based with Range Operator)
# =============================================================================
# TOPIC  : Generating tables using idiomatic list iteration
# CONCEPTS:
#   1. The range operator '..' : (START .. END) generates an inclusive sequence
#   2. 'foreach' loop iterating directly over a list
#   3. Loop variable aliasing: $number directly aliases elements
#   4. Comparison: Script 13 (C-style counter) vs Script 14 (Perl list idiom)
# =============================================================================

# --- Print Table Header ---
# Matching format from Script 13 for consistent tabular display
printf "%5s %8s\n", "Num", "Square";
printf "%5s %8s\n", "-----", "--------";

# =============================================================================
# List-Based Loop with Range Operator (..)
# =============================================================================
# The range operator '..' produces an inclusive list:
#   (2..32) evaluates to (2, 3, 4, 5, ..., 31, 32)
#
# WHY THIS IS IDIOMATIC PERL:
# - Far more readable than C-style 'for ($i = 2; $i <= 32; $i++)'
# - Eliminates common off-by-one errors (< vs <=)
# - No explicit counter management required
#
# NOTE ON ALIASING:
# In Perl, the loop variable ($number) is an ALIAS to each list element.
# If modifying an array's elements in-place, changing $number would change
# the element in the array itself!

foreach $number (2..32) {
    
    # Calculate square of current number
    $square = $number * $number;
    
    # Format and print row (%5g right-aligned 5 chars, %8g right-aligned 8 chars)
    printf "%5g %8g\n", $number, $square;
}
