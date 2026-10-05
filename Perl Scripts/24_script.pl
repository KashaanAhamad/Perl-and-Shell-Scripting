#!/usr/bin/perl -w
#
# =============================================================================
# Script 24: Binary Search Algorithm (Divide-and-Conquer)
# =============================================================================
# TOPIC  : Efficient searching in a SORTED array using Binary Search
# CONCEPTS:
#   1. Prerequisite: The array MUST be sorted first (@sortedArray)
#   2. Divide-and-conquer strategy: repeatedly halving the search space
#   3. Tracking boundaries ($start, $mid, $end)
#   4. Time Complexity: O(log2 N) — at most ~7 comparisons for 100 elements!
# =============================================================================

# Configuration constants
$NUM    = 100;
$MAXINT = 5000;

srand();

# =============================================================================
# 1. Generating 100 Random Integers
# =============================================================================
print "Numbers Generated:\n(";
for $i (1..$NUM) {
    push @array, sprintf("%d", rand(1) * $MAXINT);
    print $array[$i - 1];
    unless ($i == $NUM) { print ", "; }
}
print ")\n\n";

# Prompt user for search target
print "Please enter the number to search for >> ";
chomp($toSearch = <STDIN>);


# =============================================================================
# 2. Sorting the Array (Mandatory for Binary Search)
# =============================================================================
# Binary Search REQUIRES the dataset to be in sorted order!
# We use numeric ascending sort: { $a <=> $b }
@sortedArray = sort { $a <=> $b } @array;

# Set Output Field Separator to space so the sorted list prints readably
$, = " ";
print "\nSorted Array (for Binary Search):\n";
print @sortedArray;
print "\n\n";


# =============================================================================
# 3. Binary Search Algorithm
# =============================================================================
# ALGORITHM:
# 1. Maintain two pointers: $start (lower bound) and $end (upper bound).
# 2. Calculate the middle index: $mid = int(($start + $end) / 2).
# 3. If $sortedArray[$mid] == $toSearch:
#      Target found! Stop search.
# 4. If $sortedArray[$mid] > $toSearch:
#      Target must be in the left half -> set $end = $mid - 1.
# 5. If $sortedArray[$mid] < $toSearch:
#      Target must be in the right half -> set $start = $mid + 1.
# 6. Repeat while $start <= $end.

$counter = 0; # Tracks number of comparisons
$hit     = 0; # Boolean flag: 0 = not found, 1 = found

$start = 0;
$end   = $#sortedArray; # Last valid index (99)

print "--- Binary Search Execution Trace ---\n";

while ($start <= $end) {
    $counter++;
    
    # Calculate middle index (truncated to integer)
    $mid = sprintf("%d", ($start + $end) / 2);
    
    # Trace the current step
    printf "Step %2d | Range [%2d, %2d] | Values [%4d .. %4d] | Mid [%2d] = %4d\n",
        $counter, $start, $end, $sortedArray[$start], $sortedArray[$end], $mid, $sortedArray[$mid];
    
    # Check if target is at $mid
    if ($sortedArray[$mid] == $toSearch) {
        print "\n\"$toSearch\" found at index $mid!\n";
        $hit = 1;
        last;
    } elsif ($sortedArray[$mid] > $toSearch) {
        # Target is smaller: eliminate right half
        $end = $mid - 1;
    } else {
        # Target is larger: eliminate left half
        $start = $mid + 1;
    }
}

if ($hit == 0) {
    print "\n\"$toSearch\" not found in array.\n";
}
# Notice that even in worst case (not found), Binary Search takes <= 7 comparisons!
print "Number of comparisons: $counter / ", scalar(@sortedArray), "\n";
print "(Notice: Linear Search in Script 23 took up to 100 comparisons!)\n";

