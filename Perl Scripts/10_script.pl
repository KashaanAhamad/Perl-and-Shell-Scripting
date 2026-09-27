#!/usr/bin/perl -w
#
# =============================================================================
# Script 10: Loop Control with Labels — 'last', 'next', and 'redo'
# =============================================================================
# TOPIC  : Controlling multi-level nested loops using labels
# CONCEPTS:
#   1. Loop labels (OUTER:, INNER:)
#   2. 'last LABEL'  — Perl equivalent of 'break' (exits labeled loop)
#   3. 'next LABEL'  — Perl equivalent of 'continue' (jumps to next iteration)
#   4. 'redo LABEL'  — Restarts current iteration without re-evaluating condition
#   5. Default behavior without label (affects only the innermost enclosing loop)
# =============================================================================

# =============================================================================
# Tracing the Logic: Finding Factors of 63
# =============================================================================
# - OUTER loop: $i counts from 1 to 10.
# - INNER loop: $j counts from 1 to 10.
#
# Notice condition: if ($j >= $i) { next OUTER; }
# This means $j only runs while $j < $i. As soon as $j reaches $i,
# it abandons the INNER loop and advances to the next $i!
#
# Why 7 * 9 doesn't trigger:
# When $i = 7, $j only reaches 7 before jumping to $i = 8.
#
# Why 9 * 7 DOES trigger:
# When $i = 9, $j counts 1, 2, 3, 4, 5, 6, 7.
# At $j = 7: ($i * $j == 9 * 7 == 63) -> Condition matches!
#
# 'last OUTER' then immediately terminates BOTH loops entirely.

OUTER: for ($i = 1; $i <= 10; $i++) {

    INNER: for ($j = 1; $j <= 10; $j++) {

        # Check if the product equals 63
        if ($i * $j == 63) {
           
            print "$i times $j is 63!\n";
            
            # 'last' is Perl's 'break'.
            # Specifying 'OUTER' breaks completely out of the outer loop!
            last OUTER;
        }

        # Skip to the next iteration of the OUTER loop when $j reaches $i
        if ($j >= $i) {
            # 'next' is Perl's 'continue'.
            # Specifying 'OUTER' increments $i and starts the next outer cycle.
            next OUTER;
        }
    }
}

print "Loop finished successfully after 'last OUTER'.\n";
