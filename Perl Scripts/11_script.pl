#!/usr/bin/perl -w
#
# =============================================================================
# Script 11: Multi-Way Branching — 'if', 'elsif', and 'else'
# =============================================================================
# TOPIC  : Chained conditional statements
# CONCEPTS:
#   1. 'if ... elsif ... else' syntax structure
#   2. Spelling rule: In Perl it is 'elsif' (NOT 'elif', NOT 'else if')
#   3. Relational comparisons with numeric input
#   4. Proper string formatting with terminal newlines
# =============================================================================

# --- 1. User Input ---
print "What temperature is it? ";

# 'chomp()' strips the trailing newline character from user input.
chomp($temperature = <STDIN>);


# =============================================================================
# 2. Multi-Way Decision Ladder
# =============================================================================
# SYNTAX NOTE:
# Perl requires 'elsif' as a single keyword without the second 'e'.
#   - Python uses:  elif
#   - C/C++/Java:   else if (two separate words)
#   - Perl uses:    elsif   (single word)

if ($temperature > 75) {
    print "Too hot! Ouch!\n";
} elsif ($temperature < 68) {
    print "Too cold!\nWow!\n";
} else {
    print "Just right!\nNow we are talking.\n";
}
