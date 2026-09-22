#!/usr/bin/perl
#
# =============================================================================
# Script 02: String Operators, Type Coercion & substr
# =============================================================================
# TOPIC  : String manipulation — concatenation, repetition, built-in functions
# CONCEPTS: . (concatenation), x (repetition), operator precedence,
#           automatic string↔number coercion, length(), reverse(), substr()
# =============================================================================

# --- Concatenation operator (.) ---
# The dot (.) joins two strings together.
# Here a single-quoted string is concatenated with a double-quoted "\n".
print 'hello world' . "\n";

# --- Repetition operator (x) ---
# "string" x N  repeats the string N times.
# 5 x 4 → Perl converts 5 to string "5", repeats it 4 times → "5555"
print 5 x 4 . "\n";

# "fred" x 3 → "fredfredfred"
print "fred" x 3 . "\n";

# --- Operator precedence matters! ---
# * (multiplication) has HIGHER precedence than . (concatenation)
# So this is parsed as: "z" . (5 * 7) . "\n"
#   → "z" . 35 . "\n"  → "z35\n"
# If you wanted "z5" * 7, you'd need parentheses: ("z" . 5) * 7
print "z" . 5 * 7 . "\n"; # Output: z35

# Simple arithmetic: 12 * 3 = 36, then concatenated with "\n"
print 12 * 3 . "\n"; # Output: 36

# --- Automatic string-to-number coercion ---
# When Perl needs a number but gets a string, it extracts the LEADING numeric part.
# "15fred34" → Perl sees the leading "15", ignores "fred34"
# So "15fred34" * 3 = 15 * 3 = 45
# NOTE: with -w flag, this would produce a warning:
#   "Argument '15fred34' isn't numeric in multiplication"
print "15fred34" * 3 . "\n"; # Output: 45

# --- length() ---
# Returns the number of characters in a string.
# length("abcd") → 4
print length("abcd") . "\n";

# --- reverse() ---
# In scalar context, reverses the characters of a string.
# reverse("abcd") → "dcba"
$rev = reverse("abcd");
print $rev . "\n";

# --- substr() — extracting and inserting substrings ---
# substr(STRING, OFFSET)        → extract from OFFSET to end
# substr(STRING, OFFSET, LENGTH) → extract LENGTH chars starting at OFFSET
# substr(STRING, OFFSET, LENGTH, REPLACEMENT) → replace & return old portion
#
# String:  T  h  i  s     i  s     t  e  s  t
# Index:   0  1  2  3  4  5  6  7  8  9  10 11

$string = "This is test";

# Extract from position 5 to the end → "is test"
print substr($string, 5) . "\n"; # Output: is test

# Extract 2 characters starting at position 5 → "is"
#      This line only extracts 2 chars, so the output is just "is"
print substr($string, 5, 2) . "\n"; # Output: is

# --- Inserting text with substr (two methods shown) ---
# METHOD 1: 4-argument form
# substr(STRING, OFFSET, LENGTH, REPLACEMENT)
# At position 8, remove 0 chars, insert "not a " → inserts without deleting
substr($string, 8, 0, "not a ");

# METHOD 2: lvalue form (assigning to substr)
# substr(STRING, OFFSET, LENGTH) = REPLACEMENT
# This is an ALTERNATIVE way to do the same insertion — same effect as Method 1.
# WARNING: Since Method 1 already modified $string above, running Method 2
#          as well would cause a DOUBLE insertion! Comment out one of them.
# substr($string, 8, 0) = "not a ";

# After insertion: "This is not a test"
print $string . "\n"; # Output: This is not a test
