#!/usr/bin/perl -w
#
# =============================================================================
# Script 21: Reading Multi-Line Input, 'rand()', and Random Array Selection
# =============================================================================
# TOPIC  : Slurping STDIN into an array and generating pseudo-random selections
# CONCEPTS:
#   1. 'srand' — Seeding the random number generator (legacy vs modern Perl)
#   2. '<STDIN>' in LIST context: reading all lines until EOF (Ctrl+D / Ctrl+Z)
#   3. 'chomp(@array)' — Stripping newlines across an entire array at once
#   4. 'rand(@array)' — Passing an array forces scalar context (array length)
#   5. 'int(rand(@b))' — Converting random float into a valid integer index
# =============================================================================

# --- 1. Seeding with 'srand' ---
# In modern Perl (v5.004+), Perl automatically calls srand() with a secure seed
# the first time rand() is called. An explicit 'srand;' call is preserved here
# for historical/educational completeness.
srand;

# --- 2. Slurping Multi-Line Input in LIST Context ---
# When <STDIN> is assigned to an ARRAY (@b), Perl enters LIST context:
# It keeps reading lines from the terminal until it encounters EOF (End of File):
#   - On Windows: Press Enter, then Ctrl+Z, then Enter.
#   - On Linux/macOS: Press Ctrl+D.
print "Enter list of strings (one per line, finish with Ctrl+D or Ctrl+Z):\n";
@b = <STDIN>;

# 'chomp' can accept an entire array!
# It strips the trailing newline from every single element in @b:
chomp(@b);

# Set Output Field Separator for readable array printing
$, = " ";
print "\n--- You entered (", scalar(@b), " elements) ---\n";
print @b, "\n\n";


# =============================================================================
# 3. Generating Random Numbers with 'rand(@b)'
# =============================================================================
# SYNTAX: rand(EXPR) returns a random fractional float in range [0, EXPR).
#
# In 'rand(@b)', the array @b is evaluated in SCALAR CONTEXT:
# It evaluates to the number of elements (array size, e.g. 4).
# So 'rand(@b)' is equivalent to 'rand(4)', producing floats like 2.7481...

print "--- Generating 10 random floats between 0 and ", scalar(@b), " ---\n";
for ($i = 0; $i < 10; $i++) {
    printf "Sample %2d: %0.4f\n", $i + 1, rand(@b);
}
print "\n";


# =============================================================================
# 4. Picking a Random Element from an Array 
# =============================================================================
# 1. SLICE WARNING: Using '@b[...]' to access ONE element triggers a warning:
#    "Scalar value @b[...] better written as $b[...]"
#    Because we are retrieving a single scalar, the correct sigil is '$b[...]'.
# 2. INTEGER CONVERSION: rand(@b) yields a floating point value.
#    While Perl truncates floats when used as indices, wrapping with int()
#    is the standard, explicit Perl idiom: int(rand(@b)).

$randomIndex = int(rand(@b));
$randomChoice = $b[$randomIndex];

print "--- Random Selection ---\n";
print "Random Index Selected: $randomIndex\n";
print "Random Choice Answer : $randomChoice\n";

