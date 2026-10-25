#!/usr/bin/perl -w
#
# =============================================================================
# Script 36: Regular Expressions — Capture Groups, Modifiers, s/// and tr///
# =============================================================================
# TOPIC  : Advanced string manipulation using regex capture and substitution
# CONCEPTS:
#   1. Capture Groups '(...)' and Special Variables '$1', '$2', '$3'...
#      - Numbered by the order of their opening parentheses from left to right.
#   2. The Global Modifier '/g' and 'pos($str)':
#      - In 'while' loops, '/g' searches progressively through all occurrences.
#      - 'pos($str)' returns the character offset where the last match ended.
#   3. The Case-Insensitive Modifier '/i':
#      - Matches characters regardless of uppercase or lowercase.
#   4. Substitution Operator 's/PATTERN/REPLACEMENT/MODIFIERS':
#      - In-place string substitution.
#      - The classic "not working" bug: 's/\t/' 'x4/g' inserts literal string "' 'x4"!
#      - Fix: use 4 literal spaces or the '/e' (eval) modifier: 's/\t/' ' x 4/ge'.
#   5. The '/s' Modifier in Substitution:
#      - Allows '.*' to match across newlines to strip only the trailing '\n'.
#   6. Transliteration Operator 'tr/SEARCH/REPLACE/' (or 'y///'):
#      - Fast character-by-character 1-to-1 translation (not pattern matching).
# =============================================================================

# =============================================================================
# Part 1: Single Capture Group ($1)
# =============================================================================
# Parentheses '()' create a capturing group. Perl automatically assigns matched
# substrings to numbered read-only variables: $1, $2, $3, etc.
my $string = 'Telephone: 1234-5678';

print "=" x 70, "\n";
print "PART 1: SINGLE CAPTURE GROUP\n";
print "=" x 70, "\n";
print "Target string: '$string'\n";

if ($string =~ m/^Telephone:\s*(\d{4}-\d{4})$/) {
    print "The telephone number extracted is '$1'.\n\n";
} else {
    print "No match found.\n\n";
}


# =============================================================================
# Part 2: Nested Capture Groups ($1, $2, $3)
# =============================================================================
# Rule for numbering nested groups:
#   Numbering is determined strictly by the order of OPENING parentheses '('
#   counting from left to right:
#     Group 1: (\((\d+)\)\s*(\d{4}-\d{4}))  -> Entire phone number with code
#     Group 2: (\d+)                         -> Country/Area code inside \( \)
#     Group 3: (\d{4}-\d{4})                 -> Local 8-digit number
$string = 'Telephone:  (853)   1234-5678';

print "=" x 70, "\n";
print "PART 2: NESTED CAPTURE GROUPS\n";
print "=" x 70, "\n";
print "Target string: '$string'\n";

if ($string =~ m/^Telephone:\s*(\((\d+)\)\s*(\d{4}-\d{4}))$/) {
    print "Group 1 (Full number)  : '$1'\n";
    print "Group 2 (Country code) : '$2'\n";
    print "Group 3 (Local number) : '$3'\n\n";
}


# =============================================================================
# Part 3: The '/g' (Global) Modifier and 'pos($string)'
# =============================================================================
# In scalar context with '/g', the regex engine remembers the match offset.
# 'pos($string)' returns the position immediately following the match.
# To find the START position of the match:
#   start = pos($string) - length($1)
#
# If we had used 'if', it would only match once.
# Using 'while' with '/g' iterates through ALL matches in the string:
$string = 'Telephone: 1234-5678';

print "=" x 70, "\n";
print "PART 3: GLOBAL SEARCH (/g) AND pos()\n";
print "=" x 70, "\n";
print "Target string: '$string'\n";

while ($string =~ m/(\d{4})/g) {
    my $match_len = length($1);
    my $end_pos   = pos($string);
    my $start_pos = $end_pos - $match_len;
    print "Found '$1' at offset $start_pos (ends at $end_pos).\n";
}
print "\n";


# =============================================================================
# Part 4: The '/i' (Case-Insensitive) Modifier
# =============================================================================
# Without '/i', matching is case-sensitive: 'abc' would not match 'ABc'.
# With '/i', uppercase and lowercase are treated as equivalent.
my $str = "ABcd";

print "=" x 70, "\n";
print "PART 4: CASE-INSENSITIVE MATCHING (/i)\n";
print "=" x 70, "\n";
print "Target string: '$str'\n";

if ($str =~ m/abc/i) {
    print "Match! ('abc' with /i matched 'ABc' in '$str')\n\n";
} else {
    print "No match!\n\n";
}


# =============================================================================
# Part 5: Substitution 's///' and the '/e' Evaluation Modifier
# =============================================================================
# Original comment noted:
#   $string =~ s/\t/' 'x4/g; #chnage all tabs to 4 spaces (nw)
#
# WHY IT WAS "NOT WORKING" (nw):
#   In s/PATTERN/REPLACEMENT/, the replacement side is normally treated as a
#   string literal (with variable interpolation).
#   Writing "' 'x4" literally inserted the 6 characters:  ' ' x 4  !
#
# To actually execute Perl code inside the replacement side, we must use the
# '/e' (evaluate) modifier, or simply replace with 4 spaces directly:
$string = "a\tb\t";

print "=" x 70, "\n";
print "PART 5: SUBSTITUTION s/// AND /e MODIFIER\n";
print "=" x 70, "\n";
print "Original string with tabs: \"a\\tb\\t\"\n";

# Approach A: Using 4 literal spaces
my $copy1 = $string;
$copy1 =~ s/\t/    /g;
print "Approach A (literal spaces) : \"$copy1\"\n";

# Approach B: Using /e modifier to evaluate ' ' x 4 as Perl code
my $copy2 = $string;
$copy2 =~ s/\t/' ' x 4/ge;
print "Approach B (using /e eval)   : \"$copy2\"\n\n";


# =============================================================================
# Part 6: Multi-line Stripping with 's///s'
# =============================================================================
# Pattern: s/^(.*)\n$/$1/s
#   - '^' matches start of string.
#   - '.*' greedily captures all characters up to the final newline.
#   - The '/s' modifier allows '.*' to match newline '\n' characters.
#   - '\n$' matches the final newline at the very end of the string.
#   - Replacement '$1' leaves all internal content intact while stripping only
#     the single trailing newline (similar to a multi-line chomp).
$string = "a\nb\nc\n";

print "=" x 70, "\n";
print "PART 6: STRIPPING TRAILING NEWLINE WITH s///s\n";
print "=" x 70, "\n";
print "Before substitution:\n---\n$string---\n";

$string =~ s/^(.*)\n$/$1/s;

print "Captured group \$1:\n---\n$1\n---\n";
print "After substitution:\n---\n$string\n---\n\n";


# =============================================================================
# Part 7: Transliteration 'tr///' (or 'y///')
# =============================================================================
# 'tr/SEARCH/REPLACE/' is NOT a regular expression engine!
# It does 1-to-1 character translation (mapping each character in SEARCH to the
# corresponding character at the same index in REPLACE).
# It is implemented in C as a fast character lookup table.
$string = 'SanDeep';

print "=" x 70, "\n";
print "PART 7: TRANSLITERATION tr///\n";
print "=" x 70, "\n";
print "Original string       : '$string'\n";

# Translate all lowercase a-z to uppercase A-Z
$string =~ tr/a-z/A-Z/;
print "After tr/a-z/A-Z/     : '$string'\n";

# Translate all uppercase A-Z to lowercase a-z
$string =~ tr/A-Z/a-z/;
print "After tr/A-Z/a-z/     : '$string'\n";
