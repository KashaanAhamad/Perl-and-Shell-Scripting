#!/usr/bin/perl -w
#
# =============================================================================
# Script 42: Object-Oriented Perl — The bless() Function and Class Creation
# =============================================================================
# TOPIC  : Transforming plain references into objects using 'bless'
# CONCEPTS:
#   1. What is an Object in Perl?
#      - An object is simply a REFERENCE that has been "blessed" into a PACKAGE.
#      - Most objects in Perl are references to anonymous hashes ('{}'), which
#        act as containers for instance variables (attributes).
#   2. The 'bless($ref, $class)' Function:
#      - Attaches a package (class) name to the referent in memory.
#      - Modifies the referent IN-PLACE and returns the blessed reference.
#      - After blessing, 'ref($obj)' returns the class name instead of 'HASH'.
#   3. Method Dispatch via the Arrow Operator '->':
#      - When you invoke '$obj->method(@args)', Perl:
#        a. Checks 'ref($obj)' to find its class name ('Person').
#        b. Looks up 'sub method' inside 'package Person'.
#        c. Invokes 'Person::method($obj, @args)', passing the object itself as
#           the first argument (conventionally named '$self').
#   4. Object Introspection:
#      - '$obj->isa("Person")' : Checks if the object belongs to or inherits from a class.
#      - '$obj->can("method")' : Checks if the object implements a specific method.
#
# =============================================================================

use warnings;
use strict;

# =============================================================================
# Part 1: Anatomy of bless()
# =============================================================================
print "=" x 70, "\n";
print "PART 1: BLESSING A PLAIN REFERENCE INTO A CLASS\n";
print "=" x 70, "\n";

# Step 1: Create a plain anonymous hash reference
my $a = { 'name' => 'Kashaan', 'role' => 'Physicist' };

# Prior to blessing, ref($a) returns the underlying data structure: 'HASH'
printf("Before blessing : \$a is a %s reference\n", ref $a);

# Step 2: Bless the reference into the "Person" package.
# Notice: 'bless' modifies the underlying hash IN-PLACE and returns the reference.
my $b = bless($a, "Person");

# After blessing, ref() returns the class name "Person" for both $a and $b
# because they both point to the exact same blessed hash in memory!
printf("After blessing  : \$a is a blessed '%s' object\n", ref $a);
printf("After blessing  : \$b is a blessed '%s' object\n\n", ref $b);

# Verify both variables reference the exact same memory address:
print "Memory address of \$a : $a\n";
print "Memory address of \$b : $b\n\n";


# =============================================================================
# Part 2: Defining Methods in the "Person" Package
# =============================================================================
# In Perl, a "class" is simply a package that contains subroutines (methods).
# Here we define methods for the "Person" package:
package Person;

# Method: introduce()
# In Perl OO, the first argument to any method call is the invocant ($self)
sub introduce {
    my ($self) = @_;
    print "Hello! My name is ", $self->{'name'}, " and I am a ", $self->{'role'}, ".\n";
}

# Method: set_role() - mutator
sub set_role {
    my ($self, $new_role) = @_;
    $self->{'role'} = $new_role;
}

# Constructor idiom: new()
# Standard pattern to instantiate new Person objects:
sub new {
    my ($class, %args) = @_;
    # Bless an anonymous hash containing instance properties into the class:
    my $self = \%args;
    return bless $self, $class;
}

# Return to the main package to invoke methods:
package main;

print "=" x 70, "\n";
print "PART 2: METHOD DISPATCH VIA THE ARROW OPERATOR (->)\n";
print "=" x 70, "\n";

# Calling the 'introduce' method on our blessed object $b:
# '$b->introduce()' is syntactic sugar for 'Person::introduce($b)'
print "Calling \$b->introduce():\n  ";
$b->introduce();

# Calling a mutator method to change an attribute:
print "\nUpdating role via \$b->set_role('Senior Scientist')...\n  ";
$b->set_role('Senior Scientist');
$b->introduce();
print "\n";


# =============================================================================
# Part 3: Instantiating via Constructor and Object Introspection
# =============================================================================
print "=" x 70, "\n";
print "PART 3: CONSTRUCTOR (new) AND INTROSPECTION (isa, can)\n";
print "=" x 70, "\n";

# Create a second object using the standard Person->new() constructor
my $person2 = Person->new(
    'name' => 'Lakshay',
    'role' => 'Engineer'
);

print "Instantiated second object via Person->new():\n  ";
$person2->introduce();
print "\n";

# Using UNIVERSAL methods 'isa' and 'can':
print "Introspection:\n";
print "  Is \$person2 a Person?        : ", $person2->isa("Person") ? "YES" : "NO", "\n";
print "  Can \$person2 'introduce'?    : ", $person2->can("introduce") ? "YES" : "NO", "\n";
print "  Can \$person2 'fly'?          : ", $person2->can("fly") ? "YES" : "NO", "\n";
