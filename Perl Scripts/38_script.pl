#!/usr/bin/perl -w
#
# =============================================================================
# Script 38: References & Pointers — Scalar References and Dereferencing
# =============================================================================
# TOPIC  : Creating references, multi-level references, and the read-only trap
# CONCEPTS:
#   1. Reference Creation: The backslash operator '\'
#      - Similar to C's address-of operator '&'.
#      - '\$var' creates a reference to scalar variable '$var'.
#      - '\100'  creates a reference to a READ-ONLY constant literal.
#   2. Reference Stringification (Memory Address):
#      - Printing a reference displays its referent type and hex memory address,
#        e.g., 'SCALAR(0x...)' or 'REF(0x...)'.
#   3. Dereferencing:
#      - Prepending sigils: '$$a' dereferences scalar reference '$a'.
#      - Multi-level dereferencing: '$$$b' dereferences reference-to-reference '$b'.
#      - Alternative block syntax: '${$a}' or '${${$b}}'.
#   4. The Problem on Line 19 ("Modification of a read-only value attempted"):
#      - In '$a = \100;', 100 is an anonymous constant literal.
#      - Perl marks constant literals as READ-ONLY in memory.
#      - Any assignment to '$$a' or '$$$b' throws a fatal runtime exception!
#      - Solution: Reference a mutable variable ('$val = 100; $a = \$val;').
# =============================================================================

# =============================================================================
# Part 1: Reference to a Constant Literal and the Read-Only Trap
# =============================================================================
print "=" x 70, "\n";
print "PART 1: REFERENCE TO A CONSTANT LITERAL (\$a = \\100)\n";
print "=" x 70, "\n";

# '\100' allocates a reference to an immutable scalar constant containing 100
my $a = \100;

# Printing a reference gives the data type and hexadecimal memory address:
# e.g., 'SCALAR(0x24a87f0)'
print "1. Value of \$a (reference itself)      : $a\n";

# Dereferencing using '$$a' yields the value pointed to:
print "2. Dereferenced \$\$a (value pointed to) : $$a\n\n";


# Multi-level reference (Reference to a Reference / "Double Pointer")
my $b = \$a;

# '$b' points to '$a', which is itself a reference.
# Perl identifies this as 'REF(0x...)' because its referent is another reference:
print "3. Value of \$b (double reference)       : $b\n";

# '$$b' dereferences $b one level -> gives $a ('SCALAR(0x...)')
print "4. Dereferenced \$\$b (yields \$a ref)    : $$b\n";

# '$$$b' dereferences $b two levels -> gives the scalar value 100
print "5. Dereferenced \$\$\$b (yields 100)       : $$$b\n\n";


# -----------------------------------------------------------------------------
# Explaining Line 19: Why '$$$b = 90;' causes a problem!
# -----------------------------------------------------------------------------
# If we run '$$$b = 90;' directly, Perl crashes with:
#   "Modification of a read-only value attempted at line 19."
# We use an 'eval { ... }' block to safely trap the error and demonstrate it
# without terminating the script:
print "--- Investigating the Problem with '\$\$\$b = 90;' ---\n";
eval {
    $$$b = 90;  # Attempting to overwrite the constant literal 100
};

if ($@) {
    print "Caught Expected Error: $@";
    print "Explanation: '\\100' points to a constant literal stored in read-only\n";
    print "memory. Perl forbids modifying constant literals via references!\n\n";
}


# =============================================================================
# Part 2: The Proper Way — Referencing a Mutable Variable
# =============================================================================
# To allow modification through a reference, point to a real variable:
print "=" x 70, "\n";
print "PART 2: MUTABLE REFERENCE USING A REAL VARIABLE\n";
print "=" x 70, "\n";

my $num = 100;          # Regular mutable scalar variable
my $ref_a = \$num;      # Reference to $num
my $ref_b = \$ref_a;    # Reference to $ref_a (double reference)

print "Initial state:\n";
print "  \$num    = $num\n";
print "  \$\$ref_a = $$ref_a\n";
print "  \$\$\$ref_b = $$$ref_b\n\n";

print "Modifying value via double reference: '\$\$\$ref_b = 90;' ...\n";
$$$ref_b = 90;          # Works perfectly because $num is mutable!

print "State after modification:\n";
print "  \$num    = $num (directly modified!)\n";
print "  \$\$ref_a = $$ref_a\n";
print "  \$\$\$ref_b = $$$ref_b\n\n";


# =============================================================================
# Part 3: Explicit Curly-Brace Dereferencing Syntax
# =============================================================================
# In complex expressions, chaining sigils ($$$) can become hard to read.
# Perl provides the explicit block notation '${...}':
#   $$ref_a    is identical to  ${$ref_a}
#   $$$ref_b   is identical to  ${${$ref_b}}
print "=" x 70, "\n";
print "PART 3: EXPLICIT BLOCK DEREFERENCING SYNTAX\n";
print "=" x 70, "\n";
print "Using \${\$ref_a}     : ${$ref_a}\n";
print "Using \${\${\$ref_b}} : ${${$ref_b}}\n";
