#!/usr/bin/perl -w
#
# =============================================================================
# Script 27: Subroutine Basics, The '@_' Argument Array, and Prototypes
# =============================================================================
# TOPIC  : Creating custom functions and understanding parameter passing
# CONCEPTS:
#   1. Subroutine declaration: 'sub name { ... }'
#   2. The special parameter array: '@_' (holds all arguments passed to sub)
#   3. Lexical variables with 'my' (block scoping)
#   4. Subroutine prototypes: 'sub sum(@)' and operator precedence
#   5. Perl's special punctuation variables: $_, @_, $,, and $[
# =============================================================================

# =============================================================================
# Subroutine Definition: sum(@)
# =============================================================================
# THE PROTOTYPE '(@)':
# The '(@)' prototype tells Perl to expect a list of arguments.
#
# WHY THE PROTOTYPE MATTERS (The line 2 question):
# Without the '(@)' prototype, writing:
#     print sum 0 .. 100;
# would be parsed as:
#     (print sum(0)) .. 100;   # 'sum' only takes '0', then range operator fails!
# With the '(@)' prototype, Perl knows 'sum' consumes the entire list (0..101)
# before passing the return value to 'print'!

sub sum(@) {
    # All arguments passed to this subroutine reside in the special array '@_'
    
    my $sum = 0;
    
    # Iterate through all arguments passed in '@_'
    for my $tmp (@_) {
        $sum += $tmp;
    }
    
    # Return the accumulated total
    return $sum;
}


# =============================================================================
# Calling the Subroutine
# =============================================================================
# Calculates sum of numbers from 0 to 101:
# Sum formula: n * (n + 1) / 2 = 101 * 102 / 2 = 5151
$result = sum 0 .. 101;

print "--- Subroutine sum(\@) Output ---\n";
print "The sum of numbers from 0 to 101 is: $result\n\n";


# =============================================================================
# Educational Reference: Special Perl Variables Noted on Line 14
# =============================================================================
# $_  : The default topic variable (used automatically by loops, map, etc.)
# @_  : The subroutine argument array (holds parameters passed to functions)
# $,  : The output field separator for print() arguments
# $[  : The base index of arrays (historically 0, but could be set to 1; deprecated in modern Perl)
