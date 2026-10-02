#!/usr/bin/perl -w
#
# =============================================================================
# Script 18: In-Place Array Modification — 'splice' and 'map'
# =============================================================================
# TOPIC  : The 'splice' function: Perl's all-in-one array surgical tool
# CONCEPTS:
#   1. 'splice' syntax: splice(ARRAY, OFFSET, LENGTH, REPLACEMENT_LIST)
#   2. In-place modification of arbitrary sub-sections of an array
#   3. 'map' function: transforming elements (map(uc, ...))
#   4. Capturing the returned (removed) elements
#   5. How splice generalizes push, pop, shift, and unshift
# =============================================================================

# --- 1. Initialize Alphabet Array ---
# Indices: 0='a', 1='b', 2='c', 3='d', 4='e', 5='f', 6='g', 7='h', 8='i', ...
@alpha = ('a'..'z');

# Set Output Field Separator to space
$, = ' ';

print "--- Initial Array (\@alpha) ---\n";
print @alpha, "\n\n";


# =============================================================================
# 2. The 'splice' Function
# =============================================================================
# SYNTAX: splice(@array, OFFSET, LENGTH, REPLACEMENT_LIST);
#
# Parameters:
#   - @array           : Target array modified in-place
#   - OFFSET (4)       : Starting index (index 4 corresponds to 'e')
#   - LENGTH (5)       : How many elements to remove starting at OFFSET ('e'..'i')
#   - REPLACEMENT_LIST : New elements to insert at OFFSET
#
# Return Value:
#   - In list context, splice returns the elements that were REMOVED.
#
# --- The 'map' Transformation ---
# map(uc, @alpha[4..8]) extracts the slice ('e','f','g','h','i')
# and applies uc() (uppercase) to each element: ('E','F','G','H','I').

@removed = splice @alpha, 4, 5, map(uc, @alpha[4..8]);

print "--- Removed Elements (returned by splice) ---\n";
print @removed, "\n\n";

print "--- Modified Array after splice (uppercase E-I inserted) ---\n";
print @alpha, "\n\n";


# =============================================================================
# 3. 'splice' as the Universal Array Tool (Educational Reference)
# =============================================================================
# Any array operation can be written with splice:
#   - pop(@a)        <==>  splice(@a, -1)
#   - push(@a, $x)   <==>  splice(@a, @a, 0, $x)
#   - shift(@a)      <==>  splice(@a, 0, 1)
#   - unshift(@a,$x) <==>  splice(@a, 0, 0, $x)
