#!/usr/bin/perl -w
#
# =============================================================================
# Script 08: Post-Test Loops — 'do ... until'
# =============================================================================
# TOPIC  : Post-test loop constructs and loop termination conditions
# CONCEPTS:
#   1. 'do { ... } until (CONDITION);' post-test loop
#   2. 'until' vs 'while' (loop continues while condition is FALSE, stops when TRUE)
#   3. Guaranteed at least one execution
#   4. String equality ('eq') vs numeric equality ('==')
#   5. Logical OR ('||') short-circuit evaluation
#   6. Mandatory semicolon after 'do { } until ();'
# =============================================================================

# Initialize stop counter
$stops = 0;

# =============================================================================
# The 'do ... until' Construct
# =============================================================================
# KEY CHARACTERISTICS:
# 1. POST-TEST: The block { ... } always executes at least once BEFORE
#    the condition at the bottom is evaluated.
# 2. 'until (CONDITION)': The loop continues running WHILE the condition is FALSE.
#    As soon as the condition evaluates to TRUE, the loop terminates!
#    (It is the exact opposite of 'do ... while').
# 3. SEMICOLON REQUIRED: Because 'do { }' is technically an expression followed
#    by a modifier, the closing semicolon ';' on line with 'until' is MANDATORY.

do {
    $stops++;
    
    # Prompt user for destination
    print "Stop #$stops - Next stop? ";
    chomp($location = <STDIN>);
    
} until ($stops > 5 || $location eq 'home');

# --- Explanation of the exit condition ---
# Condition: ($stops > 5 || $location eq 'home')
# - Logical OR (||): stops if EITHER side is true.
# - 'eq' operator  : tests string equality (never use '==' for strings in Perl!).
# - If user types "home", $location eq 'home' becomes TRUE -> loop exits.
# - If user enters 6 stops, $stops > 5 becomes TRUE -> loop exits.

# Summary output upon exiting the loop
print "\nJourney ended at stop #$stops.\n";
if ($location eq 'home') {
    print "Welcome home!\n";
} else {
    print "Maximum stops limit reached (over 5 stops)!\n";
}
