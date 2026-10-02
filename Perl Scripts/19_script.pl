#!/usr/bin/perl -w
#
# =============================================================================
# Script 19: List Transformation — 'map', 'join', and String Case Functions
# =============================================================================
# TOPIC  : Functional list processing in Perl
# CONCEPTS:
#   1. 'map { BLOCK } LIST'  — Transform every element of a list
#   2. 'map EXPR, LIST'      — Expression syntax without curly braces
#   3. The topic variable '$_' (automatically aliases each element inside map)
#   4. String case functions: 'lc' (lowercase) and 'ucfirst' (uppercase first char)
#   5. 'join(SEPARATOR, LIST)' — Join a list into a single string
#   6. Completed example: Inverse operation with 'split'
# =============================================================================

# Initial list of names with inconsistent casing
@names = ('ALICE', 'tOm', 'jaSON', 'peter');

print "--- Original Array ---\n";
print join(', ', @names), "\n\n";


# =============================================================================
# 1. 'map' with Block Syntax: map { BLOCK } LIST
# =============================================================================
# HOW IT WORKS:
# - For each element in @names, Perl sets '$_' to that element.
# - 'lc($_)' lowers the entire string: "ALICE" -> "alice"
# - 'ucfirst(...)' capitalizes the first letter: "alice" -> "Alice"
# - The last evaluated expression in the block is returned into the result list.
# - 'join(",", ...)' glues the returned list into one comma-separated string.

$title_cased = join(', ', map { ucfirst(lc($_)) } @names);
print "--- Method 1: Block Syntax (map { ... } \@names) ---\n";
print $title_cased, "\n\n";


# =============================================================================
# 2. 'map' with Expression Syntax: map EXPR, LIST
# =============================================================================

# Using the alternative EXPRESSION syntax of map (no curly braces):
#   Syntax: map EXPR, LIST

$expr_result = join(', ', map ucfirst(lc($_)), @names);
print "--- Method 2: Expression Syntax (map EXPR, \@names) ---\n";
print $expr_result, "\n\n";


# =============================================================================
# 3. Completing the Script: The Inverse Operation — 'split'
# =============================================================================
# While 'join' takes a list and produces a string,
# 'split' takes a string and breaks it back into a list.
#
# SYNTAX: split(/PATTERN/, STRING)

print "--- Completing the Cycle with 'split' ---\n";
@recovered_names = split(/,\s*/, $title_cased);

# Print each recovered name on its own line
for $name (@recovered_names) {
    print "Recovered Name: $name\n";
}
