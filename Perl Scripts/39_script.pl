#!/usr/bin/perl -w
#
# =============================================================================
# Script 39: References & Pointers — Passing Hash References to Subroutines
# =============================================================================
# TOPIC  : Hash references, subroutine prototypes (\%), and dereferencing idioms
# CONCEPTS:
#   1. Subroutine Prototype '(\%$)':
#      - '\%': Automatically takes a reference to the passed hash. The caller
#        can pass '%myhash' directly, and Perl passes '\%myhash' internally!
#      - '$' : Expects a scalar in the second position (here an explicit '\%myhash').
#   2. The Three Syntaxes for Hash Element Dereferencing:
#      - Sigil shorthand : '$$hashref{key}'
#      - Block syntax    : '${$hashref}{key}'
#      - Arrow operator  : '$hashref->{key}' (modern, idiomatic Perl)
#   3. Addressing the Author's Question:
#      - "Why is '$$hashref1{key1}' NOT a double reference?"
#      - In '$$hashref1{key}', the first '$' specifies that the return value is
#        a SCALAR, and '$hashref1' is the variable holding the hash reference.
#        It is NOT a double pointer!
#   4. Whole-Hash Dereferencing:
#      - '%$hashref' or '%{$hashref}' dereferences the entire hash.
#      - Allows using 'keys %$hashref', 'values %$hashref', and 'each %$hashref'.
#   5. Pass-by-Reference Advantages:
#      - Memory efficiency: Avoids flattening and copying large hashes across the stack.
#      - In-place mutation: Changes made through the reference reflect in the caller.
# =============================================================================

# =============================================================================
# Subroutine Definition with Prototype
# =============================================================================
# Prototype '(\%$)':
#   - 1st parameter '\%': Implicitly passes a reference to whatever %hash is provided.
#   - 2nd parameter '$' : Expects any scalar value (such as an explicit hash reference).
sub passArgs(\%$) {
    my ($hashref1, $hashref2) = @_;

    print "=" x 70, "\n";
    print "INSIDE passArgs() SUBROUTINE\n";
    print "=" x 70, "\n";
    print "Address of hashref1 (via prototype \\%) : $hashref1\n";
    print "Address of hashref2 (explicit \\% arg)  : $hashref2\n\n";

    # -------------------------------------------------------------------------
    # 1. Three Ways to Access Individual Hash Elements
    # -------------------------------------------------------------------------
    print "--- 1. Individual Key Dereferencing (hashref1) ---\n";

    # Style A: Sigil shorthand '$$hashref{key}'
    # The first '$' means we are accessing a SCALAR value inside the hash.
    # The second '$' is part of the variable name '$hashref1'.
    print "Style A (Sigil shorthand \$\$hashref1{'key1'}) : ", $$hashref1{'key1'}, "\n";

    # Style B: Explicit block notation '${$hashref}{key}'
    # Fully disambiguates that '$hashref1' is being dereferenced as a hash.
    print "Style B (Block notation \${\$hashref1}{'key1'}) : ", ${$hashref1}{'key1'}, "\n";

    # Style C: The Arrow Operator '$hashref->{key}'
    # Modern, readable, and standard in professional Perl code.
    print "Style C (Arrow operator \$hashref1->{'key2'})  : ", $hashref1->{'key2'}, "\n\n";

    # -------------------------------------------------------------------------
    # Why is '$$hashref1{key1}' NOT a double reference?
    # -------------------------------------------------------------------------
    print "--- Answering the Question: Why is \$\$hashref NOT a double pointer? ---\n";
    print "In standard Perl hash lookup:       \$hash{'key'}\n";
    print "  - The sigil is '\$' because an individual hash value is a scalar.\n";
    print "When replacing 'hash' with ref:     \${\$hashref}{'key'}\n";
    print "Omitting curly braces yields:       \$\$hashref{'key'}\n";
    print "  -> 1st '\$' is the scalar value sigil.\n";
    print "  -> '\$hashref' is the reference variable.\n";
    print "  -> Therefore, it is a SINGLE dereference, not a double pointer!\n\n";

    # -------------------------------------------------------------------------
    # 2. Accessing Individual Elements via hashref2
    # -------------------------------------------------------------------------
    print "--- 2. Individual Key Dereferencing (hashref2) ---\n";
    print "Style A (\$\$hashref2{'key1'})    : ", $$hashref2{'key1'}, "\n";
    print "Style B (\${\$hashref2}{'key1'})  : ", ${$hashref2}{'key1'}, "\n";
    print "Style C (\$hashref2->{key2})     : ", $hashref2->{key2}, "\n\n";

    # -------------------------------------------------------------------------
    # 3. Whole-Hash Dereferencing (keys, values, iteration)
    # -------------------------------------------------------------------------
    # To use 'keys' or 'values', dereference the entire hash using '%$hashref':
    print "--- 3. Iterating the Entire Hash via '%\$hashref1' ---\n";
    foreach my $k (sort keys %$hashref1) {
        my $v = $hashref1->{$k};
        print "  $k => $v\n";
    }
    print "\n";

    # -------------------------------------------------------------------------
    # 4. In-Place Modification via Reference
    # -------------------------------------------------------------------------
    # Adding a new key-value pair through the reference:
    $hashref1->{'modified_by'} = 'passArgs subroutine';
    print "Added 'modified_by' key in-place through \$hashref1.\n\n";
}

# =============================================================================
# Main Program
# =============================================================================
# Declare a named hash
my %myhash = ('key1' => 'value1', 'key2' => 'value2');

print "=" x 70, "\n";
print "CALLING passArgs(%myhash, \\%myhash)\n";
print "=" x 70, "\n";
print "Initial %myhash keys: ", join(", ", sort keys %myhash), "\n\n";

# Call subroutine:
# - Arg 1: %myhash is automatically converted to \%myhash due to '\%' prototype
# - Arg 2: \%myhash is explicitly passed as a reference to satisfy '$' prototype
passArgs(%myhash, \%myhash);

# Verify in-place modification after subroutine call:
print "=" x 70, "\n";
print "AFTER SUBROUTINE EXECUTION (Caller Scope)\n";
print "=" x 70, "\n";
print "Notice that %myhash was modified in-place by the subroutine:\n";
foreach my $k (sort keys %myhash) {
    print "  $k => $myhash{$k}\n";
}
