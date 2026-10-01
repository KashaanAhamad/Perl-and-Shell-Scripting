#!/usr/bin/perl -w
#
# =============================================================================
# Script 17: Array Slices, 'pop', and 'shift'
# =============================================================================
# TOPIC  : Extracting sub-arrays (slices) and removing elements from both ends
# CONCEPTS:
#   1. Character range operator: ('a'..'z')
#   2. Array Slice syntax: @array[INDEX_LIST]
#   3. Sigil rule for slices: uses '@' because it produces a LIST of values
#   4. 'pop ARRAY'   — Removes and returns the LAST element (tail)
#   5. 'shift ARRAY' — Removes and returns the FIRST element (head, index 0)
# =============================================================================

# --- 1. Character Range ---
# The range operator '..' works on letters as well as numbers!
# ('a'..'z') generates all 26 lowercase English letters.
@alpha = ('a'..'z');

print "--- Full array (\@alpha) ---\n";
print @alpha, "\n\n"; # Unseparated string: abcdefghijklmnopqrstuvwxyz


# =============================================================================
# 2. Array Slices
# =============================================================================
# SYNTAX: @slice = @alpha[INDEX_1, INDEX_2, START..END];
#
# NOTICE THE SIGIL:
# - $alpha[4]      -> '$' sigil because it accesses ONE scalar element.
# - @alpha[4, 10..15] -> '@' sigil because it accesses MULTIPLE elements (a slice/list).
#
# Indices selected:
#   Index 4      -> 'e' (0='a', 1='b', 2='c', 3='d', 4='e')
#   Indices 10..15 -> 'k', 'l', 'm', 'n', 'o', 'p'
# Resulting @slice: ('e', 'k', 'l', 'm', 'n', 'o', 'p')

@slice = @alpha[4, 10..15];

# Set Output Field Separator to space for clear array printing
$, = " ";

print "--- Array Slice: \@alpha[4, 10..15] ---\n";
print @slice, "\n\n"; # Output: e k l m n o p


# =============================================================================
# 3. 'pop' — Removing the Last Element (Tail)
# =============================================================================
# - pop(@array) removes the element at the highest index and returns it.
# - Array shrinks by 1.
# - If array is empty, pop returns undef.

$retval = pop(@slice); # Removes 'p'

print "--- pop(\@slice) demonstration ---\n";
print "Popped element returned : $retval\n";
print "Remaining \@slice elements: ", @slice, "\n\n";


# =============================================================================
# 4. 'shift' — Removing the First Element (Head)
# =============================================================================
# - shift(@array) removes the element at index 0 and returns it.
# - All remaining elements slide down one index (index 1 becomes index 0, etc.).
# - If array is empty, shift returns undef.
# - (Perl idiom: inside a subroutine, 'shift' with no arguments shifts from '@_')

$retval = shift(@slice); # Removes 'e'

print "--- shift(\@slice) demonstration ---\n";
print "Shifted element returned: $retval\n";
print "Remaining \@slice elements: ", @slice, "\n";
