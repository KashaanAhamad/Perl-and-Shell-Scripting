#!/usr/bin/perl -w
#
# =============================================================================
# Script 15: Array Basics, Output Field Separator ($,), and List Flattening
# =============================================================================
# TOPIC  : Core array behaviors, context evaluation, and list flattening
# CONCEPTS:
#   1. Array declaration with '@' sigil
#   2. Special variable '$,' (Output Field Separator for print)
#   3. The "4??" Mystery: Scalar Context ('.') vs List Context (',')
#   4. Element access using '$' sigil ($colour[0])
#   5. Empty arrays (@nullarray = ())
#   6. Automatic list flattening (Perl arrays are strictly 1-dimensional)
# =============================================================================

# --- 1. Array Declaration ---
@colour = ("red", "orange", "green", "blue");

# --- 2. The Special Variable '$,' (Output Field Separator) ---
# In Perl, '$,' defines the character printed between separate arguments passed to print().
# (Similar to OFS in awk, or $OUTPUT_FIELD_SEPARATOR in English module).
$, = " "; 


# =============================================================================
# 3. The "4??" Mystery: Concatenation (.) vs List Argument (,)
# =============================================================================
# ORIGINAL LINE: print @colour . "\n"; # 4??
#
# WHY DID THIS PRINT 4 INSTEAD OF THE COLORS?
# - The dot '.' is the string concatenation operator.
# - The concatenation operator forces SCALAR CONTEXT on both its operands!
# - When an array is evaluated in SCALAR CONTEXT, it returns its LENGTH (number of elements).
#   Here, @colour has 4 elements, so @colour evaluates to the scalar 4.
# - Therefore: @colour . "\n" becomes 4 . "\n" -> "4\n"!
#
# HOW TO PRINT THE ARRAY ELEMENTS WITH '$,':
# Pass the array and newline as separate list items using a comma ',':
#   print @colour, "\n";   # List context -> prints: red orange green blue\n

print "--- Evaluating array in SCALAR context (using dot .) ---\n";
print @colour . "\n";  # Scalar context -> prints element count: 4

print "--- Evaluating array in LIST context (using comma ,) ---\n";
print @colour, "\n";   # List context with $, = " " -> prints: red orange green blue


# =============================================================================
# 4. Individual Element Access
# =============================================================================
# Even though the array is @colour, accessing a single scalar item uses '$':
print "\nIndividual elements:\n";
print "Index 0: " . $colour[0] . "\n";
print "Index 1: " . $colour[1] . "\n";
print "Index 2: " . $colour[2] . "\n";
print "Index 3: " . $colour[3] . "\n";


# =============================================================================
# 5. Empty Arrays & List Flattening
# =============================================================================
# An empty list is represented by '()'
@nullarray = ();
print "\nNull array contents (prints nothing): [", @nullarray, "]\n";

# --- List Flattening ---
# In Perl, lists and arrays are ALWAYS 1-DIMENSIONAL (flat).
# Parentheses inside lists do NOT create nested sub-arrays!
# Any nested parentheses or sub-arrays are automatically flattened out:
@unix = ("FreeBSD", "Linux");
@os = ("MacOS", ("Windows NT", "Windows ME"), @unix);

# @os becomes a single flat list of 5 elements:
# ("MacOS", "Windows NT", "Windows ME", "FreeBSD", "Linux")
print "\nFlattened \@os array:\n";
print @os, "\n";
