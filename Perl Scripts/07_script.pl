#!/usr/bin/perl -w
#
# =============================================================================
# Script 07: Loops in Perl — C-style 'for' and 'while'
# =============================================================================
# TOPIC  : Iteration and repetition constructs
# CONCEPTS:
#   1. C-style 3-part 'for' loop: for (INIT; TEST; STEP)
#   2. 'while' loop: while (CONDITION) { ... }
#   3. Post-decrement operator ($a--)
#   4. Output formatting (spacing and newlines between loops)
# =============================================================================

# =============================================================================
# 1. C-Style 'for' Loop
# =============================================================================
# Syntax: for (INITIALIZATION; CONDITION; STEP)
#   - $i = 1  : run once before the loop begins
#   - $i <= 10: checked BEFORE each iteration; loop exits when false
#   - $i++    : executed at the end of each iteration (post-increment)
print "Counting from 1 to 10:\n";
for ($i = 1; $i <= 10; $i++) {
    print "$i "; 
}
print "\n\n";    


# =============================================================================
# 2. 'while' Loop with Countdown ($a--)
# =============================================================================
# Syntax: while (CONDITION) { BLOCK }
#   - Tests CONDITION at the start of every cycle.
#   - As long as CONDITION is TRUE (here $a > 0), the block executes.
#   - If initially false (e.g. user enters 0), the loop runs 0 times.

print "How old are you? ";
chomp($a = <STDIN>);

# The post-decrement operator ($a--):
# Uses current value of $a during the iteration, then reduces $a by 1.
while ($a > 0) {
    print "At one time, you were $a years old.\n";
    $a--;
}

