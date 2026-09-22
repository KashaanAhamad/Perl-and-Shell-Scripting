#!/usr/bin/perl -w
#
# =============================================================================
# Script 03: Reading User Input, chomp() vs chop(), and Simple Math
# =============================================================================
# TOPIC  : Standard input (<STDIN>), removing newlines/characters, arithmetic
# CONCEPTS: <STDIN> line input operator, chomp() vs chop(),
#           combined assignment/chomp, variable interpolation in strings
# =============================================================================

# --- 1. Reading from Standard Input (<STDIN>) ---
# <STDIN> reads one line from standard input (keyboard) up to and including
# the newline character (\n) when the user presses Enter.
print "Enter some text: ";
$text = <STDIN>;

# At this point, $text still contains the trailing newline (\n).
print "You entered (with newline): $text";

# --- chomp() Function ---
# chomp() removes the trailing newline character (\n) from a string if present.
# If there is no trailing newline, chomp() leaves the string untouched.
# It returns the total number of characters removed (usually 1).
chomp($text);
print "After chomp (no newline): $text\n";

# --- chop() Function vs chomp() ---
# CAUTION: Do not confuse chop() with chomp()!
# chop() UNCONDITIONALLY removes the very last character, whatever it is.
# It returns the character that was removed.
$x = "hello world";
$removed_char = chop($x); # removes 'd', leaving "hello worl"
print "After chop('$x'), removed character was: '$removed_char'\n";

# --- 2. Interactive Program: Celsius to Fahrenheit Converter ---
# Prompt the user for input
print "\nPlease enter temperature in Celsius > ";

# --- Idiomatic Perl: Read and chomp in one step ---
# In Perl, assignment is an expression that yields the assigned variable.
# So chomp($cel = <STDIN>) reads the line into $cel, then immediately
# chomps the trailing newline off $cel in a single clean idiom.
chomp($cel = <STDIN>);

# --- Arithmetic Calculation ---
# Formula: F = (C * 1.8) + 32  or  (C * 9/5) + 32
# Perl automatically converts the string in $cel into a numeric value for math.
$fah = ($cel * 1.8) + 32;

# --- Variable Interpolation ---
# Inside double quotes, Perl expands $cel and $fah to their respective values.
print "The Fahrenheit equivalent of $cel degrees Celsius is $fah\n";
