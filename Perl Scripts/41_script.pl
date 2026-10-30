#!/usr/bin/perl -w
#
# =============================================================================
# Script 41: References & Pointers — Type Introspection with ref()
# =============================================================================
# TOPIC  : Inspecting and identifying reference types at runtime
# CONCEPTS:
#   1. The Built-in 'ref($expr)' Function:
#      - Returns empty string ("") if the argument is NOT a reference (false).
#      - Returns the referent's data type (in uppercase) if it IS a reference.
#   2. Standard Built-in Return Values:
#      - 'ARRAY'  : Reference to an array (e.g., '[]' or '\@array')
#      - 'HASH'   : Reference to a hash (e.g., '{}' or '\%hash')
#      - 'SCALAR' : Reference to a scalar (e.g., '\1' or '\$scalar')
#      - 'REF'    : Reference to another reference (e.g., '\$ref')
#      - 'CODE'   : Reference to an anonymous or named subroutine (e.g., 'sub {}' or '\&sub')
#      - 'Regexp' : Compiled regular expression (e.g., 'qr/pattern/')
#   3. Blessed Objects (OOP Prelude):
#      - When a reference is blessed into a class using 'bless($ref, "ClassName")',
#        'ref($obj)' returns the CLASS NAME ("ClassName") instead of the underlying data type.
#   4. Defensive Programming Idioms:
#      - Checking reference type before dereferencing prevents fatal runtime crashes.
# =============================================================================

use warnings;
use strict;

print "=" x 70, "\n";
print "PART 1: BUILT-IN REFERENCE TYPE IDENTIFICATION WITH ref()\n";
print "=" x 70, "\n";

# Reference to an anonymous array: '[]'
my $arr_ref = [];

# Reference to an anonymous hash: '{}'
my $hash_ref = {};

# Reference to a constant scalar: '\1'
my $scalar_ref = \1;

# Reference to another reference ("double pointer"): '\$scalar_ref'
my $double_ref = \$scalar_ref;

# Formatting fixed: added consistent spaces so words don't run together
printf("\$arr_ref    is a %-8s reference (created with [])\n", ref $arr_ref);
printf("\$hash_ref   is a %-8s reference (created with {})\n", ref $hash_ref);
printf("\$scalar_ref is a %-8s reference (created with \\1)\n", ref $scalar_ref);
printf("\$double_ref is a %-8s reference (created with \\\$scalar_ref)\n\n", ref $double_ref);


# =============================================================================
# Part 2: Additional Reference Types (CODE, Regexp, Non-Reference)
# =============================================================================
print "=" x 70, "\n";
print "PART 2: ADDITIONAL BUILT-IN REFERENCE TYPES\n";
print "=" x 70, "\n";

# Subroutine reference (CODE)
my $code_ref = sub { print "Hello from anonymous sub!\n"; };
printf("\$code_ref   is a %-8s reference (created with sub {})\n", ref $code_ref);

# Compiled regular expression reference (Regexp)
my $regex_ref = qr/^[0-9]+$/;
printf("\$regex_ref  is a %-8s reference (created with qr//)\n", ref $regex_ref);

# Plain non-reference scalar
my $plain_string = "Just a string";
my $ref_type = ref $plain_string;
printf("\$plain_str  is '%s' (not a reference -> returns empty string \"\")\n\n",
       $ref_type ? $ref_type : "NON-REFERENCE");


# =============================================================================
# Part 3: Objects and 'bless' (Bridge to Script 42)
# =============================================================================
# When a reference is blessed into a package, ref() returns the package name!
print "=" x 70, "\n";
print "PART 3: BLESSED OBJECTS (Object-Oriented Perl)\n";
print "=" x 70, "\n";

my $object = bless {}, "Physics::Particle";
printf("\$object     is blessed into class: '%s'\n\n", ref $object);


# =============================================================================
# Part 4: Practical Idiom — Defensive Parameter Validation
# =============================================================================
# Subroutines often accept either an array reference or a hash reference.
# ref() allows dynamically routing based on the argument type:
print "=" x 70, "\n";
print "PART 4: DEFENSIVE DISPATCH BASED ON ref()\n";
print "=" x 70, "\n";

sub inspect_data {
    my ($data) = @_;

    my $type = ref($data);

    if ($type eq 'ARRAY') {
        print "Received an ARRAY ref containing " . scalar(@$data) . " elements.\n";
    } elsif ($type eq 'HASH') {
        print "Received a HASH ref containing " . scalar(keys %$data) . " keys.\n";
    } elsif ($type eq 'SCALAR') {
        print "Received a SCALAR ref pointing to value: $$data\n";
    } elsif ($type eq '') {
        print "Received a plain non-reference scalar: '$data'\n";
    } else {
        print "Received an object or specialized reference of type: '$type'\n";
    }
}

inspect_data([10, 20, 30]);
inspect_data({'name' => 'Kashaan', 'role' => 'Researcher'});
inspect_data(\"Speed of light");
inspect_data(42);
inspect_data($object);
