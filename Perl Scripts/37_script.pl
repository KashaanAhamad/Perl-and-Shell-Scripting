#!/usr/bin/perl -w
#
# =============================================================================
# Script 37: Regular Expressions — Anchors, Escaping, Quantifiers, and Backreferences
# =============================================================================
# TOPIC  : Practical regex pattern matching and common regex idioms
# CONCEPTS:
#   1. Anchored matching: '^' (start) and '$' (end)
#   2. Escaping special regex metacharacters: '\\' (backslash) and '\*' (asterisk)
#   3. Variable interpolation in patterns: 'm/($whatever){N}/'
#   4. Matching newlines without /s: '(.|\n)' alternation
#   5. Backreferences: '\1', '\2', etc., referencing previously captured groups
#
# =============================================================================

# =============================================================================
# Part 1: Anchored Repetition Pattern: '^a+b*$'
# =============================================================================
# Pattern explanation:
#   ^    : Must start at beginning of string
#   a+   : One or more 'a' characters (at least one 'a' required)
#   b*   : Zero or more 'b' characters (optional)
#   $    : Must end at the end of the string
#
# Valid matches  : "a", "aa", "ab", "abbb", "aaaaabb"
# Invalid matches: "", "b", "ba", "aaba", "a c b"

print "=" x 70, "\n";
print "PART 1: AT LEAST ONE 'a' FOLLOWED BY ANY NUMBER OF 'b' (^a+b*\$)\n";
print "=" x 70, "\n";

# Provide fallback for STDIN if not piped or entered interactively
my $input;
if (@ARGV) {
    $input = $ARGV[0];
} else {
    print "Enter a string (or press ENTER to use default 'aaabbb'): ";
    $input = <STDIN>;
    chomp($input) if defined $input;
    $input = "aaabbb" unless defined $input && length($input);
}

print "Testing string: '$input'\n";

if ($input =~ m/^a+b*$/) {
    print "Result: Match found! ('$input' matches ^a+b*\$)\n\n";
} else {
    print "Result: No match.\n\n";
}

# Sub-test: Unanchored vs Anchored
my $string = "aaaaaaaabbbbbbbbbb";
print "Testing string: '$string'\n";
if ($string =~ m/a+b*/) {
    print "Result: Pattern 'at least one a followed by any number of b' matched.\n\n";
} else {
    print "Result: Pattern did not match.\n\n";
}


# =============================================================================
# Part 2: Escaping Regex Metacharacters: Backslashes and Asterisks
# =============================================================================
# In regex, '\' is the escape character and '*' is the zero-or-more quantifier.
# To match literal backslashes and asterisks:
#   '\\' -> Matches one literal backslash '\'
#   '\\*'-> Matches zero or more literal backslashes
#   '\*' -> Matches one literal asterisk '*'
#   '\**'-> Matches zero or more literal asterisks
#
# Anchored pattern: m/^\\*\**$/ validates that the string consists exclusively
# of zero or more backslashes followed by zero or more asterisks.
my $string1 = "\\\\\\\\\\\\\\**********";

print "=" x 70, "\n";
print "PART 2: ESCAPING METACHARACTERS (Backslashes and Asterisks)\n";
print "=" x 70, "\n";
print "Testing string: '$string1'\n";

if ($string1 =~ m/^\\*\**$/) {
    print "Result: Successfully matched string of backslashes and asterisks!\n\n";
} else {
    print "Result: Not matched.\n\n";
}


# =============================================================================
# Part 3: Variable Interpolation and Repetition Quantifiers '{N}'
# =============================================================================
# Perl interpolates variables inside regex patterns by default!
# Here '$whatever' contains "lakshay".
# The regex m/($whatever){4}/ checks for 4 consecutive repetitions: "lakshaylakshaylakshaylakshay".
# '$string2' has only 3 repetitions, so the match evaluates to FALSE.
my $string2  = "lakshaylakshaylakshay";
my $whatever = "lakshay";

print "=" x 70, "\n";
print "PART 3: VARIABLE INTERPOLATION AND EXACT QUANTIFIER {N}\n";
print "=" x 70, "\n";
print "Target string   : '$string2' (contains 3 repetitions)\n";
print "Pattern variable: '$whatever'\n";
print "Testing pattern : m/(\$whatever){4}/\n";

my $retval2 = ($string2 =~ m/($whatever){4}/);

printf("Result: '%s' %s match 4 repetitions of '%s'.\n\n",
       $string2, $retval2 ? "DOES" : "does NOT", $whatever);


# =============================================================================
# Part 4: Matching Newlines Without /s Using Alternation '(.|\n)'
# =============================================================================
# By default, the dot '.' matches any character EXCEPT newline '\n'.
# To match any 5 characters across lines without using the '/s' modifier,
# we can use the alternation '(.|\n)':
#   'abc\nab' has: 'a', 'b', 'c', '\n', 'a' -> 5 characters!
my $string3 = "abc\nab";

print "=" x 70, "\n";
print "PART 4: MATCHING ANY CHARACTER INCLUDING NEWLINE VIA (.|\n)\n";
print "=" x 70, "\n";
print "Testing string: \"abc\\nab\"\n";
print "Testing pattern: m/(.|\\n){5}/\n";

my $retval3 = ($string3 =~ m/(.|\n){5}/);
printf("Result: String %s have at least 5 characters (including newline).\n\n",
       $retval3 ? "DOES" : "does NOT");


# =============================================================================
# Part 5: Duplicate Word Detector Using Backreferences '\2'
# =============================================================================
# Goal: Detect repeated identical consecutive words separated by whitespace.
#
# Pattern breakdown:
#   (^|\s)      : Group 1 -> Start of string or whitespace before the word
#   (\S+)       : Group 2 -> The word itself (one or more non-whitespace chars)
#   (\s+\2)+    : Group 3 -> ONE OR MORE REPETITIONS of whitespace followed by
#                            the EXACT SAME WORD captured in Group 2 ('\2' is backreference)
#   (\s|$)      : Group 4 -> Whitespace or end of string following the duplicates
#
my $string4 = "aa aa aa";

print "=" x 70, "\n";
print "PART 5: REPEATED WORD DETECTION VIA BACKREFERENCES (\\2)\n";
print "=" x 70, "\n";
print "Testing string: '$string4'\n";
print "Pattern: m/(^|\\s)(\\S+)(\\s+\\2)+(\\s|\$)/\n";

my $retval4 = ($string4 =~ m/(^|\s)(\S+)(\s+\2)+(\s|$)/);
printf("Result: '%s' %s contain repeated consecutive duplicate words.\n",
       $string4, $retval4 ? "DOES" : "does NOT");
