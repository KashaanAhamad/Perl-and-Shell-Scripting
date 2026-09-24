#!/usr/bin/perl -w
#
# =============================================================================
# Script 05: Operators in Perl (Modulo, String Comparison, Bitwise, Compound)
# =============================================================================
# TOPIC  : Diverse Perl operators and their specific behaviors
# CONCEPTS:
#   1. Modulo (%) with negative numbers (sign of divisor)
#   2. String comparison (lt, gt, eq...) vs numeric (<, >, ==...)
#   3. Ternary conditional operator (? :)
#   4. Bitwise shifts (>> and <<)
#   5. Compound assignment operators (.= and x=)
# =============================================================================

# =============================================================================
# 1. Modulo Operator (%) with Negative Numbers
# =============================================================================
# IMPORTANT PERL DIFFERENCE:
# In Perl, the result of ($a % $b) adopts the sign of the DIVISOR ($b),
# following mathematical floor division (like Python, unlike C/C++ which follows the dividend).
#
# Rule: $a % $b = $a - $b * floor($a / $b)

# -63 % 5: Divisor is positive (5) -> result is positive:
# -63 = (-13 * 5) + 2  --> Result: 2 (In C, this would be -3)
print "-63 % 5  = ", -63 % 5, "\n";   # Output: 2

# 63 % 5: Both positive -> standard remainder:
# 63 = (12 * 5) + 3    --> Result: 3
print " 63 % 5  = ", 63 % 5, "\n";    # Output: 3

# -63 % -5: Divisor is negative (-5) -> result is negative:
# -63 = (12 * -5) + (-3) --> Result: -3
print "-63 % -5 = ", -63 % -5, "\n";  # Output: -3

# 63 % -5: Divisor is negative (-5) -> result is negative:
# 63 = (-13 * -5) + (-2) --> Result: -2
print " 63 % -5 = ", 63 % -5, "\n";   # Output: -2


# =============================================================================
# 2. String Comparison (lt) vs Numeric (<) & Ternary Operator (? :)
# =============================================================================
# Perl separates comparisons into two distinct families:
#   Numeric: ==, !=, <,  >,  <=, >=, <=>
#   String : eq, ne, lt, gt, le, ge, cmp
#
# "lt" compares strings lexicographically by their ASCII/Unicode values.
# In ASCII:
#   Uppercase 'U' has code 85
#   Lowercase 'a' has code 97
# Since 85 < 97, "Urgent" comes BEFORE "agent" in ASCII order!
# Therefore: "Urgent" lt "agent" evaluates to TRUE (1).
#
# Ternary Operator: (CONDITION) ? (VALUE_IF_TRUE) : (VALUE_IF_FALSE)
print '"Urgent" lt "agent" ? ', ("Urgent" lt "agent" ? "true" : "false"), "\n";


# =============================================================================
# 3. Bitwise Shift Operators (>> and <<)
# =============================================================================
# 60 in 8-bit binary: 00111100

# Right Shift (>> 2): shifts bits 2 positions to the right.
# Equivalent to integer division by 2^2 (i.e., 60 / 4 = 15).
# Binary: 00111100 >> 2 = 00001111 (15 in decimal)
print "60 >> 2 = ", 60 >> 2, "\n"; # Output: 15

# Left Shift (<< 2): shifts bits 2 positions to the left.
# Equivalent to multiplying by 2^2 (i.e., 60 * 4 = 240).
# Binary: 00111100 << 2 = 11110000 (240 in decimal)
print "60 << 2 = ", 60 << 2, "\n"; # Output: 240


# =============================================================================
# 4. Compound Assignment Operators (.= and x=)
# =============================================================================
$x = "abc";
$y = "xyz";
$z = 3;

# --- Concatenation Assignment (.=) ---
# $x .= $y is shorthand for: $x = $x . $y
# Appends "xyz" to the end of $x ("abc" -> "abcxyz")
# It modifies $x in-place and evaluates to the new value.
print '$x .= $y produces: ', ($x .= $y), "\n"; # Output: abcxyz

# --- Repetition Assignment (x=) ---
# $y x= $z is shorthand for: $y = $y x $z
# Repeats the current string in $y ("xyz") 3 times ("xyzxyzxyz")
# Modifies $y in-place and evaluates to the new value.
print '$y x= $z produces: ', ($y x= $z), "\n"; # Output: xyzxyzxyz
