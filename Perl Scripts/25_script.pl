#!/usr/bin/perl -w
#
# =============================================================================
# Script 25: Hashes (Associative Arrays) — Slices, 'delete', and Sorting
# =============================================================================
# TOPIC  : Key-value associative data structures in Perl
# CONCEPTS:
#   1. Hash declaration with '%' sigil and fat comma '=>'
#   2. Single element access: '$Age{key}' (sigil changes to '$')
#   3. Hash Slices: '@Age{key1, key2}' (sigil changes to '@')
#   4. 'delete' function on hash slices (removes keys and returns deleted values)
#   5. 'keys %hash' and 'values %hash' functions
#   6. Sorting hash keys numerically ({ $a <=> $b })
#   7. Sorting hash values alphabetically ({ $a cmp $b })
#   8. Advanced idiom: Sorting keys based on their values
# =============================================================================

# =============================================================================
# 1. Hash Initialization & Fat Comma (=>)
# =============================================================================
# '%' denotes a hash (associative array of key => value pairs).
# The '=>' (fat comma) acts as a comma, but automatically quotes barewords on its left.
# So 'Tom => 26' is identical to "'Tom', 26".

%Age = (
    Tom   => 26,
    Peter => 51,
    Jones => 23
);

# Accessing a single value:
# - Uses '$' sigil (because the value returned is a single scalar).
# - Uses curly braces '{ }' to identify hash lookup (vs '[ ]' for arrays).
print "--- Single Hash Element Lookup ---\n";
print "Tom's age is: $Age{Tom}\n\n";


# =============================================================================
# 2. Hash Slices & 'delete'
# =============================================================================
# HASH SLICE SYNTAX: @hash{KEY_LIST}
# Notice the sigil is '@' because multiple values (a list) are returned!
#
# 'delete' on a hash slice:
# Removes 'Tom' and 'Peter' from %Age and returns their values into @temp (26, 51).

@temp = delete @Age{'Tom', 'Peter'};

# Set Output Field Separator to space
$, = " ";

print "--- Deleting via Hash Slice (\@Age{'Tom', 'Peter'}) ---\n";
print "Deleted values : ", @temp, "\n";

# 'keys %hash' returns a list of all current keys remaining in the hash
print "Remaining keys : ", keys %Age, "\n\n";


# =============================================================================
# 3. Sorting Hash Keys and Values
# =============================================================================
%array = (
    '3'  => 'apple',
    '11' => 'orange',
    '5'  => 'banana',
);

# --- Sort Keys Numerically ---
# keys %array returns ('3', '11', '5')
# Sorting with { $a <=> $b } produces: ('3', '5', '11')
@key = sort { $a <=> $b } keys %array;

# --- Sort Values Alphabetically ---
# values %array returns ('apple', 'orange', 'banana')
# Sorting with { $a cmp $b } produces: ('apple', 'banana', 'orange')
@value = sort { $a cmp $b } values %array;

print "--- Sorted Keys & Values ---\n";
print "Keys sorted numerically  : ", @key, "\n";
print "Values sorted alphabetically: ", @value, "\n\n";


# =============================================================================
# 4. Idiomatic Perl: Sorting Keys by Their Values
# =============================================================================
# A very common real-world task: sort the hash entries alphabetically by value
# while keeping their corresponding keys.
@keys_by_value = sort { $array{$a} cmp $array{$b} } keys %array;

print "--- Keys sorted by their corresponding values ---\n";
foreach my $k (@keys_by_value) {
    print "Key: $k => Value: $array{$k}\n";
}
