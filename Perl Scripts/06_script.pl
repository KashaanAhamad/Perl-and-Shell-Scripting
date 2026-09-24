#!/usr/bin/perl -w
#
# =============================================================================
# Script 06: Control Flow — if, else, and unless
# =============================================================================
# TOPIC  : Conditional branching in Perl
# CONCEPTS:
#   1. if (CONDITION) { ... } else { ... }
#   2. The 'unless' keyword: Perl's unique "if NOT" control structure
#   3. Common pitfalls with negated logic in 'unless'
# =============================================================================

# --- 1. User Input ---
print "How old are you? ";
chomp($a = <STDIN>);

# =============================================================================
# 2. Standard if / else
# =============================================================================
# The if block runs if the condition evaluates to TRUE (non-zero / non-empty).
# If the condition is FALSE, execution drops into the else block.
if ($a < 18) {
    print "So, you are not old enough to vote.\n";
} else {
    print "Old enough! So go vote!\n";
}

# =============================================================================
# 3. The 'unless' Statement 
# =============================================================================
# In Perl, 'unless (EXPR)' is exact shorthand for 'if (! EXPR)'.
# That is, the block runs ONLY when the condition is FALSE.
#
# To let adults (age >= 18) enter using 'unless', we say:
# "unless you are under 18" -> unless ($a < 18)

print "\n--- Checking admission to the bar ---\n";
if ($a < 18) {
    print "Not old enough, get lost!!\n";
}
unless ($a < 18) {
    # Runs when ($a < 18) is FALSE (i.e., when $a >= 18)
    print "Well well, come on in, have a drink!\n";
}

# NOTE: The above could also be written with statement modifiers (idiomatic Perl):
# print "Not old enough!\n" if $a < 18;
# print "Come on in!\n"     unless $a < 18;
