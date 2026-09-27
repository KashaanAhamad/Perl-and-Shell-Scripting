#!/usr/bin/perl -w
#
# =============================================================================
# Script 09: Arrays & Iteration — 'foreach' vs 'for'
# =============================================================================
# TOPIC  : Array definition, list traversal, and indexing
# CONCEPTS:
#   1. Array declaration with '@' sigil: @a = (...)
#   2. 'foreach' loop and loop iterator variable ($b)
#   3. 'reverse' in LIST context (reverses element order)
#   4. Sigil change: '@a' (whole array) vs '$a[$i]' (scalar element)
#   5. 'for' and 'foreach' are exact synonyms in Perl
#   6. Array bounds: hardcoded vs dynamic last index ($#a)
# =============================================================================

# --- 1. Array Declaration ---
# '@' denotes an array variable.
# '(1, 2, 3, 4, 5)' is a list literal used to initialize the array.
@a = (1, 2, 3, 4, 5);


# =============================================================================
# 2. 'foreach' Loop with 'reverse'
# =============================================================================
# In LIST context, reverse(@a) returns the elements in reverse order: (5, 4, 3, 2, 1).
# (Like Script 02: in SCALAR context, reverse reverses character by character!)
#
# $b acts as the loop iterator, aliasing each element in turn.
print "Iterating through array in reverse order:\n";
foreach $b (reverse @a) {
    print "$b "; 
}
print "\n\n";     


# =============================================================================
# 3. C-Style 'for' Loop with Array Indexing
# =============================================================================
# NOTE ON SIGIL CHANGE:
# While the array as a whole is named '@a', an individual element is a SCALAR,
# so the sigil changes from '@' to '$': $a[$i].
#
# In Perl, 'for' and 'foreach' are 100% interchangeable keywords!
# You can write 'for $x (@a)' or 'foreach ($i = 0; $i <= 4; $i++)'.

print "Accessing array elements by index (0 to 4):\n";

# Idiomatic tip: Instead of hardcoding 4, $#a gives the last index of array @a.
# Here, $#a == 4.
for ($i = 0; $i <= $#a; $i++) {
    print "Index $i: $a[$i]\n";
}

