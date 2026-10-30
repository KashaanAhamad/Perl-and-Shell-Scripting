#!/usr/bin/perl -w
#
# =============================================================================
# Script 40: Complex Data Structures — Hashes of Arrays and Dereferencing
# =============================================================================
# TOPIC  : Storing array references inside hashes (HoA: Hash of Arrays)
# CONCEPTS:
#   1. Anonymous Array Constructor '[ ... ]':
#      - Square brackets create an anonymous array in memory and return a reference.
#   2. Subroutine Parameter Unpacking for Hashes:
#      - 'my %params = @_;' unpacks flattened key-value pairs into a named hash.
#   3. Dereferencing Array References Stored in Hashes:
#      - Reference extraction : 'my $args_ref = $params{"ARGS"};'
#      - Whole-array deref    : 'my @args = @{$params{"ARGS"}};' (or '@$args_ref')
#      - Element deref styles :
#          * Sigil form       : '$$args_ref[0]'
#          * Block notation   : '${$args_ref}[1]'
#          * Arrow operator   : '$args_ref->[0]'
#
# =============================================================================

# =============================================================================
# Subroutine: somesub()
# =============================================================================
# Accepts a hash (passed as a flattened list of key-value pairs in @_)
sub somesub (%) {
    # pairs from the caller are unpacked into %params.
    my %params = @_;

    my $filename = $params{'FILE'};

    my $args_ref = $params{'ARGS'};

    # Dereferencing the entire array reference into a standard named array:
    my @args = @{$params{'ARGS'}};

    print "=" x 70, "\n";
    print "INSIDE somesub() SUBROUTINE\n";
    print "=" x 70, "\n";
    print "Executable file : $filename\n\n";

    # -------------------------------------------------------------------------
    # Exercise: Demonstrating the 3 Styles of Array Element Dereferencing
    # -------------------------------------------------------------------------
    print "--- Three Ways to Dereference Array Elements via \$args_ref ---\n";

    # Style 1: Sigil shorthand '$$args_ref[0]'
    # The first '$' indicates an individual scalar element is being accessed.
    # '$args_ref' is the array reference variable.
    print "Style 1 (Sigil shorthand \$\$args_ref[0]) : ", $$args_ref[0], "\n";

    # Style 2: Block notation '${$args_ref}[1]'
    # Explicitly encloses the reference expression in curly braces.
    print "Style 2 (Block notation \${\$args_ref}[1]) : ", ${$args_ref}[1], "\n";

    # Style 3: Arrow operator '$args_ref->[0]'
    # Modern, readable, standard Perl idiom.
    print "Style 3 (Arrow operator \$args_ref->[0])  : ", $args_ref->[0], "\n\n";

    # -------------------------------------------------------------------------
    # Working with the Unpacked Named Array (@args)
    # -------------------------------------------------------------------------
    print "--- Accessing via the Unpacked Named Array (@args) ---\n";
    print "Element 0: $args[0]\n";
    print "Element 1: $args[1]\n";
    print "All args : ", join(" ", @args), "\n\n";

    # -------------------------------------------------------------------------
    # Simulating the Intended Command
    # -------------------------------------------------------------------------
    print "Simulated Command Line: $filename ", join(" ", @args), "\n";
}

# =============================================================================
# Main Program
# =============================================================================
# Construct a Hash containing a scalar and an anonymous Array Reference (HoA).
#
# Square brackets '[ ... ]' create an anonymous array reference in Perl.
my %hash = (
    'FILE' => 'bin/ls',
    'ARGS' => ['-1', 'R']
);

print "=" x 70, "\n";
print "CALLING somesub(%hash)\n";
print "=" x 70, "\n";
print "Hash structure:\n";
print "  FILE => $hash{'FILE'}\n";
print "  ARGS => $hash{'ARGS'} (Array Reference: $hash{'ARGS'})\n\n";

# Pass the hash to the subroutine
somesub(%hash);
