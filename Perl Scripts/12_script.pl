#!/usr/bin/perl -w
#
# =============================================================================
# Script 12: Accumulator Pattern & Sentinel-Controlled 'while' Loop
# =============================================================================
# TOPIC  : Running sum accumulator using a sentinel value to terminate
# CONCEPTS:
#   1. Accumulator variable ($sum = 0)
#   2. Sentinel value (999) to signal termination
#   3. The "Priming Read" pattern in while loops
#   4. Compound assignment operator (+=)
#   5. Alternative Perl idioms: 'until' and 'while(1)' with 'last if'
# =============================================================================

# --- 1. Initialize Accumulator ---
# An accumulator variable stores a running total across iterations.
$sum = 0;

# --- 2. Priming Read ---
# A priming read gathers the first value BEFORE entering the loop,
# ensuring the loop condition can be tested on the first pass.
print "Enter a number (999 to quit): ";
chomp($n = <STDIN>);

# =============================================================================
# 3. Sentinel-Controlled Loop
# =============================================================================
# The loop condition ($n != 999) checks if the sentinel value was entered.
# As long as $n is NOT 999, the loop body runs.
while ($n != 999) {
    # Add input number to running total ($sum = $sum + $n)
    $sum += $n;
    
    # Prompt and read the NEXT number at the end of the loop
    print "Enter another number (999 to quit): ";
    chomp($n = <STDIN>);
}

# --- 4. Display Final Result ---
print "The sum is: $sum\n";


# =============================================================================
# Alternative Approaches (Educational Reference)
# =============================================================================
# Approach A: Using 'until' instead of 'while':
#   until ($n == 999) {
#       $sum += $n;
#       ...
#   }
#
# Approach B: Eliminating duplicate read code using 'while (1)' with 'last if':
#   while (1) {
#       print "Enter a number (999 to quit): ";
#       chomp(my $num = <STDIN>);
#       last if $num == 999;
#       $sum += $num;
#   }
