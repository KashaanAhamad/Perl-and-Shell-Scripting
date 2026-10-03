#!/usr/bin/perl -w
#
# =============================================================================
# Script 20: Sorting Arrays — Numeric (<=>), String (cmp), and 'qw()'
# =============================================================================
# TOPIC  : Custom sorting and quoted-words list syntax
# CONCEPTS:
#   1. 'sort { BLOCK } LIST' syntax
#   2. Special variables '$a' and '$b' used automatically by sort
#   3. Spaceship operator '<=>' for NUMERIC comparison
#   4. Three-way comparison operator 'cmp' for STRING (ASCII) comparison
#   5. Ascending ($a <=> $b) vs Descending ($b <=> $a)
#   6. Default sort pitfall: sort @numbers sorts alphabetically by default!
# =============================================================================

# Set Output Field Separator to space so lists print cleanly
$, = ' ';


# =============================================================================
# 1. Numeric Sorting with the Spaceship Operator (<=>)
# =============================================================================
# The '<=>' operator compares two numbers:
#   Returns -1 if $a < $b, 0 if $a == $b, 1 if $a > $b.
#
# $a and $b are special package variables populated by sort (never declare them with 'my').

@list = (1, 10, 2, 20, 50, 40, 30);

# Ascending numeric sort ($a <=> $b)
@sorted = sort { $a <=> $b } @list;
print "--- Numeric Ascending (\$a <=> \$b) ---\n";
print @sorted, "\n\n"; # Output: 1 2 10 20 30 40 50

# Descending numeric sort ($b <=> $a)
# Simply swapping $a and $b inverts the sort direction!
@sorted_desc = sort { $b <=> $a } @list;
print "--- Numeric Descending (\$b <=> \$a) ---\n";
print @sorted_desc, "\n\n"; # Output: 50 40 30 20 10 2 1


# =============================================================================
# 2. String (ASCII) Sorting with 'cmp'
# =============================================================================
# The 'cmp' operator compares two strings by their ASCII/Unicode values:
#   - Digits ('0'-'9') come before uppercase letters (ASCII 48-57)
#   - Uppercase ('A'-'Z') comes before lowercase (ASCII 65-90)
#   - Lowercase ('a'-'z') comes last (ASCII 97-122)

@alphanum = ('bear', '20', 'Post', 'ant', '20ant');

# Ascending ASCII sort ($a cmp $b)
@sorted1 = sort { $a cmp $b } @alphanum;
print "--- String Ascending (\$a cmp \$b) ---\n";
print @sorted1, "\n\n"; # Output: 20 20ant Post ant bear

# Descending ASCII sort ($b cmp $a)
@sorted2 = sort { $b cmp $a } @alphanum;
print "--- String Descending (\$b cmp \$a) ---\n";
print @sorted2, "\n\n"; # Output: bear ant Post 20ant 20


# =============================================================================
# 3. Quoted Words Operator: 'qw()' 
# =============================================================================
#
# 'qw(...)' takes whitespace-separated words and automatically wraps each in quotes,
# producing a list: ('fred', 'barney', 'betty', 'wilma').

@a = qw(fred barney betty wilma);
print "--- Quoted Words (qw) ---\n";
print @a, "\n";
