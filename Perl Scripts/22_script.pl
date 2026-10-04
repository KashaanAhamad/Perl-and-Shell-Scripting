#!/usr/bin/perl -w
#
# =============================================================================
# Script 22: Reversing Lists & The List-vs-Scalar Context Trap
# =============================================================================
# TOPIC  : User-input list reversal and deep dive into 'reverse' context
# CONCEPTS:
#   1. Slurping multiple lines of input into an array via '<STDIN>'
#   2. 'chomp(@array)' across multiple input lines
#   3. 'reverse' in LIST context (reverses elements: [a, b, c] -> [c, b, a])
#   4. THE TRAP: 'reverse' in SCALAR context (concatenates then reverses characters!)
#   5. The Output Field Separator ($,)
#   6. Pipelined one-liner alternative: print reverse @list
# =============================================================================

# --- 1. Slurp User Input in LIST Context ---
# Prompts user to enter strings line-by-line until EOF
print "Enter a list of strings (one per line, finish with Ctrl+D or Ctrl+Z):\n";
@list = <STDIN>;

# Remove trailing newlines from all entered strings
chomp(@list);


# =============================================================================
# 2. Output Before Setting '$,'
# =============================================================================
# Before '$,' is defined, print outputs array items back-to-back with no spaces:
print "\n--- Raw entered list (no separator defined yet) ---\n";
print @list, "\n\n";


# =============================================================================
# 3. 'reverse' in LIST Context
# =============================================================================
# When assigned to an ARRAY (@reverselist), 'reverse' operates in LIST CONTEXT.
# It inverts the order of the elements:
#   Original: ('apple', 'banana', 'cherry')
#   Reversed: ('cherry', 'banana', 'apple')

@reverselist = reverse @list;

# Set Output Field Separator to space so elements are visibly delimited
$, = ' ';

print "--- Reversed list in LIST context (elements swapped) ---\n";
print @reverselist, "\n\n";


# =============================================================================
# 4. Educational Deep Dive: The 'reverse' Context Trap!
# =============================================================================
# WHAT HAPPENS IF WE USE SCALAR CONTEXT?
# If you assign reverse(@list) to a SCALAR variable ($scalar_rev):
#   1) Perl first concatenates all elements together into a single string!
#   2) Then it reverses the CHARACTERS of that concatenated string!
#
# Example with ('cat', 'dog'):
#   - In LIST context  : ('dog', 'cat')
#   - In SCALAR context: "godtac" !

$scalar_rev = reverse @list;
print "--- The 'reverse' SCALAR context trap (\$scalar_rev = reverse \@list) ---\n";
print "Notice all characters are reversed backwards: $scalar_rev\n";

