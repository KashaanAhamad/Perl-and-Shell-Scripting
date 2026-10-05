#!/usr/bin/perl -w
#
# =============================================================================
# Script 23: Linear Search Algorithm (Sequential Search)
# =============================================================================
# TOPIC  : Generating random numbers and searching through an unsorted array
# CONCEPTS:
#   1. Array generation with 'rand()' and 'push'
#   2. Comma-separated list printing ('unless' modifier vs 'join')
#   3. Linear Search Algorithm: sequentially checking each element
#   4. Search metrics: tracking comparisons and early loop exit with 'last'
#   5. Time Complexity: O(N) worst-case, O(1) best-case
# =============================================================================

# Configuration constants
$NUM    = 100;   # Total count of numbers to generate
$MAXINT = 5000;  # Upper bound (exclusive) for generated numbers

# Initialize random number generator seed
srand(); 


# =============================================================================
# 1. Generating 100 Random Integers
# =============================================================================
# rand(1) generates a float in [0.0, 1.0).
# Multiplying by $MAXINT yields numbers in [0.0, 5000.0).
# sprintf("%d", ...) truncates the float to an integer.
# (Note: int(rand($MAXINT)) is an alternative idiomatic Perl way to write this).

print "Numbers Generated:\n(";
for $i (1..$NUM) {
    # Generate random integer and append to @array
    push @array, sprintf("%d", rand(1) * $MAXINT);
    
    # Print the element just pushed (at index $i - 1)
    print $array[$i - 1];
    
    # Print a comma and space after every element EXCEPT the last one ($NUM)
    unless ($i == $NUM) { 
        print ", "; 
    }
}
print ")\n\n";

# Educational Note: The entire loop above could be written in one idiomatic line:
#   @array = map { int(rand($MAXINT)) } 1..$NUM;
#   print "Numbers Generated:\n(" . join(', ', @array) . ")\n\n";


# =============================================================================
# 2. Reading Search Target from User
# =============================================================================
print "Please enter the number to search for >> ";
chomp($toSearch = <STDIN>);


# =============================================================================
# 3. Linear Search Algorithm
# =============================================================================
# ALGORITHM OVERVIEW:
# - Inspect each element from left to right, one by one.
# - If a match is found ($num == $toSearch):
#     - Report the subscript (index).
#     - Set the flag ($hit = 1).
#     - Terminate the loop immediately with 'last' (no need to check further).
# - If the loop finishes without a match, report not found.
#
# COMPLEXITY:
# - Best Case : 1 comparison (element is at index 0)
# - Worst Case: N comparisons (element is at the very end, or not present)
# - Average   : N / 2 comparisons

$counter = 0; # Tracks number of comparisons performed
$hit     = 0; # Boolean flag: 0 = not found, 1 = found

foreach $num (@array) {
    $counter++;
    
    if ($num == $toSearch) {
        print "\"$toSearch\" found at subscript ", $counter - 1, "\n";
        $hit = 1;
        last; # Early exit from loop upon finding the target
    }
}

# If search concluded with no hits
if ($hit == 0) {
    print "\"$toSearch\" not found in array.\n";
}

print "Number of comparisons: $counter / ", scalar(@array), "\n";

