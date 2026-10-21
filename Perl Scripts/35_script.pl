#!/usr/bin/perl -w
#
# =============================================================================
# Script 35: Regular Expressions — Character Classes, Ranges, and Quantifiers
# =============================================================================
# TOPIC  : Validating even integers using progressive regex techniques
# CONCEPTS:
#   1. Quantifiers:
#      - Exact / bounded: '{min,max}', '{min,}' (e.g., '{0,1}', '{0,}')
#      - Shorthand '?'   : Equivalent to '{0,1}' (zero or one occurrence; optional)
#      - Shorthand '*'   : Equivalent to '{0,}'  (zero or more occurrences)
#      - Shorthand '+'   : Equivalent to '{1,}'  (one or more occurrences)
#   2. Character Classes:
#      - Alternation group '(a|b|c)' vs character class '[abc]'
#      - Character range '[0-9]' (matches any ASCII digit 0 through 9)
#      - Built-in shorthand '\d' (digits; equivalent to '[0-9]')
#   3. Anchoring:
#      - '^' (string start) and '$' (string end) ensure full-string validation
#   4. The Mathematical Logic:
#      - An integer is even if and only if its last digit is 0, 2, 4, 6, or 8.
# =============================================================================

# Read input from command-line arguments ($ARGV[0]).
# If no argument is provided, default to "-300" so the script runs without
# uninitialized variable warnings under -w.
my $string = defined $ARGV[0] ? $ARGV[0] : "-300";

print "=" x 70, "\n";
print "VALIDATING EVEN INTEGER: '$string'\n";
print "=" x 70, "\n\n";


# =============================================================================
# Stage 1: Verbose / Primitive Regex (Alternation + Explicit Quantifiers)
# =============================================================================
# Pattern breakdown:
#   ^                           : Start of string
#   (\+|\-){0,1}                : Optional sign ('+' or '-'), occurring 0 or 1 time
#   (0|1|2|3|4|5|6|7|8|9){0,}   : 0 or more leading digits (using '|' alternation)
#   (0|2|4|6|8)                 : Final digit must be an even digit
#   $                           : End of string
#
# While functionally correct, this style is verbose and slow because alternation
# groups '(a|b)' create capturing overhead and multiple backtracking branches.
print "--- Stage 1: Primitive Alternation & Explicit Quantifiers ---\n";
print "Pattern: m/^(\\+\\|\\-){0,1}(0|1|2|3|4|5|6|7|8|9){0,}(0|2|4|6|8)\$/\n";

my $retval = ($string =~ m/^(\+|\-){0,1}(0|1|2|3|4|5|6|7|8|9){0,}(0|2|4|6|8)$/);
printf("Result : '%s' is %s an even integer.\n\n", $string, $retval ? "indeed" : "not");


# =============================================================================
# Stage 2: Introducing Character Classes and Shorthand Quantifiers '?' and '*'
# =============================================================================
# Improvements:
#   1. '[+-]' replaces '(\+|\-)':
#      Inside square brackets '[...]', characters represent a set of alternatives.
#      A hyphen '-' placed at the beginning or end of a character class is
#      treated as a literal minus sign without needing an escape '\'.
#   2. '?' replaces '{0,1}':
#      Matches 0 or 1 occurrence of the preceding element (makes it optional).
#   3. '*' replaces '{0,}':
#      Matches 0 or more occurrences of the preceding element.
#   4. '[0123456789]' replaces '(0|1|2|3|4|5|6|7|8|9)':
#      A single character class check without grouping overhead.
#   5. '[02468]' replaces '(0|2|4|6|8)':
#      Character class for all even digits.
print "--- Stage 2: Character Classes & Shorthand Quantifiers (?, *) ---\n";
print "Pattern: m/^[+-]?[0123456789]*[02468]\$/\n";

$retval = ($string =~ m/^[+-]?[0123456789]*[02468]$/);
printf("Result : '%s' is %s an even integer.\n\n", $string, $retval ? "indeed" : "not");


# =============================================================================
# Stage 3: Character Ranges '[0-9]'
# =============================================================================
# Improvement:
#   Inside a character class, a hyphen '-' between two characters denotes an
#   inclusive range in ASCII/Unicode order.
#   '[0-9]' is shorthand for '[0123456789]'.
print "--- Stage 3: Character Ranges [0-9] ---\n";
print "Pattern: m/^[+-]?[0-9]*[02468]\$/\n";

$retval = ($string =~ m/^[+-]?[0-9]*[02468]$/);
printf("Result : '%s' is %s an even integer.\n\n", $string, $retval ? "indeed" : "not");


# =============================================================================
# Stage 4: Built-in Shorthand Class '\d' (Modern Idiomatic Perl)
# =============================================================================
# Improvement:
#   Perl provides predefined character classes:
#     '\d' -> Any digit [0-9]
#     '\D' -> Any non-digit [^0-9]
#     '\w' -> Any word character [a-zA-Z0-9_]
#     '\W' -> Any non-word character [^a-zA-Z0-9_]
#     '\s' -> Any whitespace [ \t\r\n\f]
#     '\S' -> Any non-whitespace [^ \t\r\n\f]
#
# Here '\d*' concisely represents zero or more digits.
print "--- Stage 4: Built-in Digit Shorthand \\d ---\n";
print "Pattern: m/^[+-]?\\d*[02468]\$/\n";

$retval = ($string =~ m/^[+-]?\d*[02468]$/);
printf("Result : '%s' is %s an even integer.\n\n", $string, $retval ? "indeed" : "not");


# =============================================================================
# Bonus Verification: Testing Sample Inputs Mentioned in the Original Comments
# =============================================================================
# Original comment listed sample inputs:
#   perl 35_script.pl -1     -> ODD
#                     -300   -> EVEN
#                     +345   -> ODD
# We can test multiple cases using our concise stage-4 regex:
print "=" x 70, "\n";
print "BATCH VALIDATION TEST SUITE\n";
print "=" x 70, "\n";

my @test_cases = ('-1', '-300', '+345', '0', '42', '-88', '101', 'abc', '+');

foreach my $test (@test_cases) {
    my $is_even = ($test =~ m/^[+-]?\d*[02468]$/);
    printf("Input: %-8s => %s\n", "'$test'", $is_even ? "EVEN INTEGER" : "NOT an even integer");
}
