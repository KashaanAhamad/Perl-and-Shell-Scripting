#!/usr/bin/perl -w
#
# =============================================================================
# Script 26: Hash Search & Iteration — 'exists()', 'each()', and O(1) Lookup
# =============================================================================
# TOPIC  : Fast searching using Hash Tables vs Linear and Binary Search
# CONCEPTS:
#   1. Using hash keys for instant lookups (key = number, value = insertion order)
#   2. Key uniqueness in hashes (duplicates overwrite values)
#   3. 'keys %hash' and 'values %hash' functions
#   4. 'while (($k, $v) = each %hash)' — hash iterator
#   5. 'exists($hash{$k})' vs 'defined()' vs truthy value check
#   6. Search Algorithm Trilogy: Linear O(N) vs Binary O(log N) vs Hash O(1)
# =============================================================================

# Configuration constants
$NUM    = 100;
$MAXINT = 5000;

srand();

# =============================================================================
# 1. Populating the Hash with Random Integers
# =============================================================================
# We store the random number as the HASH KEY, and the loop counter as the VALUE:
#   $hash{$valueToInsert} = $i;
#
# KEY UNIQUENESS:
# Hash keys are always unique. If a duplicate random number is generated,
# it simply updates the existing key's value.

print "Numbers Generated:\n(";
for $i (1..$NUM) {
    $valueToInsert = sprintf("%d", rand(1) * $MAXINT);
    $hash{$valueToInsert} = $i;
    
    print $valueToInsert;
    print ", " unless ($i == $NUM);
}
print ")\n\n";

print "Total unique numbers stored in hash: ", scalar(keys %hash), "\n\n";


# =============================================================================
# 2. Inspecting Keys, Values, and the 'each' Iterator
# =============================================================================
# Set Output Field Separator to space so lists print readably
$, = " ";

# Display a sample of keys and values (first 10 for clean terminal display)
@all_keys = keys %hash;
print "--- Sample of Hash Keys (first 10) ---\n";
print @all_keys[0..9], "\n\n";

# --- The 'each %hash' Iterator ---
# 'each' returns the next (key, value) pair from the hash on each call.
# When all pairs have been visited, it returns an empty list, ending the loop.
# (Showing first 5 entries as a demonstration):
print "--- Iterating with 'each %hash' (sample of 5 pairs) ---\n";
$sample_count = 0;
while (($key, $val) = each %hash) {
    print "Key: $key => Value (order): $val\n";
    last if ++$sample_count >= 5;
}
# Reset the internal iterator so future each() calls start from the beginning
keys %hash; 
print "\n";


# =============================================================================
# 3. Hash Search via 'exists()' & The O(1) Constant Time Advantage
# =============================================================================
print "Please enter the number to search for >> ";
chomp($toSearch = <STDIN>);

# WHY 'exists()' IS THE RIGHT TOOL:
# - exists($hash{$toSearch}) tests whether the KEY exists in the hash table.
# - Do NOT use: if ($hash{$toSearch}) { ... }
#   Because if the value stored happens to be 0 or "", it would falsely evaluate to false!
# - Do NOT use: if (defined($hash{$toSearch})) { ... }
#   Because if a key exists with an explicit 'undef' value, defined() returns false.
# - 'exists()' is the only guaranteed, correct test for key presence.

if (exists($hash{$toSearch})) {
    print "\n\"$toSearch\" found! (Stored at insertion step: $hash{$toSearch})\n";
} else {
    print "\n\"$toSearch\" not found in hash!\n";
}

# =============================================================================
# Search Algorithms Comparison Summary:
# =============================================================================
# 1. Linear Search (Script 23): O(N)       — Checked up to 100 elements sequentially.
# 2. Binary Search (Script 24): O(log2 N)  — Required sorting, checked at most 7 elements.
# 3. Hash Search   (Script 26): O(1)       — ZERO comparisons! Instant hash table lookup.
