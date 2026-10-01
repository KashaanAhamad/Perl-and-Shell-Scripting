#!/usr/bin/perl -w
#
# =============================================================================
# Script 16: Array Manipulation — 'push', 'unshift', and Size in Scalar Context
# =============================================================================
# TOPIC  : Adding elements to arrays at both ends (tail and head)
# CONCEPTS:
#   1. 'push ARRAY, LIST'    — Appends elements to the END (tail) of an array
#   2. 'unshift ARRAY, LIST' — Prepends elements to the FRONT (head) of an array
#   3. Return value of push and unshift: the NEW number of elements in the array
#   4. BUG FIX: Line 10 printed literal string "alpha1" instead of array @alpha1
#   5. Evaluating an array in scalar context ($num = @array) to get its length
#   6. Output Field Separator ($,) with list print
# =============================================================================

# --- Initial Arrays ---
@alpha1 = ("a", "b", "c");
@alpha2 = ("d", "e", "f");
@alpha3 = ("g", "h", "i");

# Set Output Field Separator so array elements print separated by spaces
$, = " ";


# =============================================================================
# 1. 'push' — Appending to the End of an Array
# =============================================================================
# SYNTAX: push(@target_array, @elements_to_add);
# - Appends elements from @alpha2 onto the end of @alpha1.
# - RETURN VALUE: push() returns the NEW total count of elements.
#
# @alpha1 before: ("a", "b", "c")
# @alpha1 after : ("a", "b", "c", "d", "e", "f")

$numEle = push(@alpha1, @alpha2);

print "--- push() demonstration ---\n";
print "New element count returned by push(): $numEle\n";

# BUG FIX: The original code had: print "alpha1"; (printed literal string)
# Fixed to print the actual array contents:
print "Contents of \@alpha1 after push:\n";
print @alpha1, "\n\n";


# =============================================================================
# 2. 'unshift' — Prepending to the Front of an Array
# =============================================================================
# SYNTAX: unshift(@target_array, @elements_to_add);
# - Inserts elements from @alpha2 at the BEGINNING (index 0) of @alpha3.
# - Shifts all existing elements to the right.
# - RETURN VALUE: unshift() also returns the NEW total count of elements.
#
# @alpha3 before: ("g", "h", "i")
# @alpha3 after : ("d", "e", "f", "g", "h", "i")

$newCount = unshift(@alpha3, @alpha2);

print "--- unshift() demonstration ---\n";
print "Contents of \@alpha3 after unshift:\n";
print @alpha3, "\n\n";


# =============================================================================
# 3. Array Size via Scalar Context ($num = @array)
# =============================================================================
# When an array variable is assigned to a scalar variable, Perl evaluates
# the array in SCALAR CONTEXT, which returns the number of elements.
$num = @alpha3;

print "--- Getting array size via scalar context ---\n";
print "Number of elements in \@alpha3: $num\n";
