#!/usr/bin/perl -w
#
# =============================================================================
# Script 04: String Repetition Operator ('x') and User Input
# =============================================================================
# TOPIC  : Repeating strings based on interactive user input
# CONCEPTS: The string repetition operator ('x'), numeric conversion of input,
#           how chomp() affects the output formatting (stacked vs inline)
# =============================================================================

# --- 1. Prompt and Read the String ($a) ---
print "String: ";
$a = <STDIN>;

# NOTE ON CHOMPING $a:
# If we do NOT chomp($a), $a retains its trailing newline ("\n").
# Repeating it ($a x $b) will print each copy on a NEW line:
#   hello\n
#   hello\n
#   hello\n
#
# If we DID chomp($a), repeating it would concatenate them on the SAME line:
#   hellohellohello
# Uncomment the line below if single-line repeating is preferred:
# chomp($a);

# --- 2. Prompt and Read the Repeat Count ($b) ---
print "Number of times: ";


# Clarification: Chomping $b is NOT an error!
# In fact, chomp($b = <STDIN>) is standard, good practice.
# Perl will convert "3\n" to 3 during numeric operations anyway, but chomping
# ensures clean data without trailing whitespace.
chomp($b = <STDIN>);

# --- 3. The String Repetition Operator ('x') ---
# SYNTAX: STRING x COUNT
#   - Left operand: evaluated as a string (the text to repeat)
#   - Right operand: evaluated as an integer (how many times to repeat)
# If COUNT <= 0, the result is an empty string ("").
$c = $a x $b;

# --- 4. Display the Result ---
print "The result is:\n$c";
