#!/usr/bin/perl -w
#
# =============================================================================
# Script 34: Regular Expressions — Pattern Matching, Anchors, and Modifiers
# =============================================================================
# TOPIC  : Perl's regex engine fundamentals
# CONCEPTS:
#   1. Pattern binding operator: '=~'
#   2. Match operator: 'm/PATTERN/' (the 'm' is optional when using //)
#   3. Alternation: '(a|b|c)'
#   4. Dot wildcard ('.') — matches any single character except newline
#   5. The '/s' modifier ("Single-line" mode) — allows '.' to match newline '\n'
#   6. Anchors: '^' (start) and '$' (end)
#   7. The '/m' modifier ("Multi-line" mode) — causes '^' and '$' to match at line breaks
# =============================================================================

# =============================================================================
# Test 1: Substring Matching with '=~ m/PATTERN/'
# =============================================================================
# '=~' tests if the string on the left matches the regex on the right.
# Returns true (1) on match, false ("") on failure.
$var = "Capable";

print "--- Test 1: Simple Substring Match ---\n";
print "String: '$var' | Pattern: 'able'\n";
if ($var =~ m/able/) {
    print "Result: MATCH! ('Capable' contains 'able')\n\n";
} else {
    print "Result: NO MATCH!\n\n";
}


# =============================================================================
# Test 2: Alternation and Grouping '(a|b|c)'
# =============================================================================
# The pipe '|' represents logical OR.
# 'a(a|b|c)a' matches: "aaa", "aba", or "aca".
$pat = "aba";

print "--- Test 2: Alternation (a|b|c) ---\n";
print "String: '$pat' | Pattern: 'a(a|b|c)a'\n";
if ($pat =~ m/a(a|b|c)a/) {
    print "Result: MATCH! ('aba' matches the middle choice 'b')\n\n";
} else {
    print "Result: NO MATCH!\n\n";
}


# =============================================================================
# Test 3: The Dot Wildcard ('.')
# =============================================================================
# By default, '.' matches ANY single character EXCEPT the newline character '\n'.
# In "acacb\nc", the substring "acb" has 'a', 'c', 'b' -> matches 'a.b'.
$str = "acacb\nc";

print "--- Test 3: Dot Wildcard without /s ---\n";
print "String: 'acacb\\nc' | Pattern: 'a.b'\n";
if ($str =~ m/a.b/) {
    print "Result: MATCH! (The '.' matched 'c' in the substring 'acb')\n\n";
} else {
    print "Result: NO MATCH!\n\n";
}


# =============================================================================
# Test 4: The '/s' Modifier (Single-Line Mode)
# =============================================================================
# Here the string has a newline between 'a' and 'b': "a\nb...".
# By default, 'a.b' would FAIL because '.' cannot match '\n'.
# The '/s' modifier tells Perl to treat the string as a SINGLE line:
# It permits '.' to match '\n' as well!
$str = "a\nb\nc";

print "--- Test 4: Dot Wildcard with /s (Dot matches newline) ---\n";
print "String: 'a\\nb\\nc' | Pattern: 'a.b/s'\n";
if ($str =~ m/a.b/s) {
    print "Result: MATCH! (With /s, '.' successfully matched the embedded '\\n')\n\n";
} else {
    print "Result: NO MATCH!\n\n";
}


# =============================================================================
# Test 5: Anchors '^' and '$' without '/m' (Whole String Match)
# =============================================================================
# '^' asserts the start of the ENTIRE string.
# '$' asserts the end of the ENTIRE string.
#
# Because $str is "a\nb\nc", matching '^a$' fails because the whole string
# contains more than just "a" (it has "\nb\nc" after it).
$str = "a\nb\nc";

print "--- Test 5: Anchors ^ and \$ without /m (Whole String Match) ---\n";
print "String: 'a\\nb\\nc' | Pattern: '^a\$'\n";
if ($str =~ m/^a$/) {
    print "Result: MATCH!\n\n";
} else {
    print "Result: NO MATCH! (String has trailing '\\nb\\nc', so it doesn't end after 'a')\n\n";
}


# =============================================================================
# Test 6: Anchors '^' and '$' with '/m' (Multi-Line Mode)
# =============================================================================
# The '/m' modifier alters '^' and '$':
#   - '^' matches at the start of the string AND after any embedded '\n' (start of any line).
#   - '$' matches at the end of the string AND before any embedded '\n' (end of any line).
#
# Line 1 of "a\nb\nc" is just "a", so '^a$' successfully matches line 1!
$str = "a\nb\nc";

print "--- Test 6: Anchors ^ and \$ with /m (Line-by-Line Match) ---\n";
print "String: 'a\\nb\\nc' | Pattern: '^a\$/m'\n";
if ($str =~ m/^a$/m) {
    print "Result: MATCH! (With /m, '^' and '\$' match individual lines; line 1 is 'a')\n";
} else {
    print "Result: NO MATCH!\n";
}
