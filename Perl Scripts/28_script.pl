#!/usr/bin/perl -w
#
# =============================================================================
# Script 28: Context-Sensitive Subroutines — 'wantarray()', 'index()', and '$"'
# =============================================================================
# TOPIC  : Creating subroutines that adapt their return behavior based on context
# CONCEPTS:
#   1. 'wantarray()' — detects whether caller expects a LIST, a SCALAR, or VOID
#   2. 'index(STR, SUBSTR)' — locates substring position (returns offset or -1)
#   3. '$"' ($LIST_SEPARATOR) — delimiter used when arrays are interpolated in "..."
#   4. Difference between '$"' (double-quote interpolation) and '$,' (print separator)
# =============================================================================

# =============================================================================
# Subroutine: search($substr, @targets_or_single_string)
# =============================================================================
# This subroutine dynamically adapts its behavior:
# - In LIST context  : Searches a list of strings, returns all matching strings.
# - In SCALAR context: Searches a single string, returns integer character offset.

sub search {
    my $substr = shift; # First argument is always the substring to search for
    
    # -------------------------------------------------------------------------
    # Case 1: Caller called search() in LIST Context (e.g., @found = search(...))
    # -------------------------------------------------------------------------
    if (wantarray()) {
        my @values = @_;
        my @retval = ();
        
        foreach (@values) {
            my $index = index($_, $substr);
            push @retval, ($index >= 0) ? $_ : ();
        }
        return @retval; # Return list of matching strings
    }
    
    # -------------------------------------------------------------------------
    # Case 2: Caller called search() in SCALAR Context (e.g., $pos = search(...))
    # -------------------------------------------------------------------------
    else {
        my $value = shift; # The single target string
        my $index = index($value, $substr);
        
        # Return character position (>= 0), or -1 if not found
        return ($index >= 0) ? $index : -1;
    }
}


# =============================================================================
# Part 1: Testing in SCALAR Context ($pos = search(...))
# =============================================================================
my $scalar = 'delinquency';
my $substr = 'que';

# Test A: Finding 'que' inside 'delinquency'
my $search1 = search($substr, $scalar); # SCALAR context: wantarray() is FALSE
print "--- SCALAR Context Search ---\n";
print "'$substr' " . ($search1 >= 0 ? "found at offset $search1" : "not found") . " in '$scalar'\n";

# Test B: Searching for 'san' inside 'delinquency' (should NOT be found)
$substr = 'san';
$search1 = search($substr, $scalar);
print "'$substr' " . ($search1 >= 0 ? "found at offset $search1" : "not found") . " in '$scalar'\n\n";


# =============================================================================
# Part 2: Testing in LIST Context (@matches = search(...))
# =============================================================================
my @items = ('systematic', 'system');

# --- The '$"' ($LIST_SEPARATOR) Special Variable ---
# When an array is interpolated inside double quotes (e.g. "@search2"),
# Perl joins the elements using the character in '$"'.
# By default, '$"' is a space (" "). Setting '$" = "\n"' prints each item on a new line!
$" = "\n  * ";

print "--- LIST Context Search ---\n";

# Test C: Search for 'tic' in @items (should match only 'systematic')
$substr = 'tic';
my @search2 = search($substr, @items); # LIST context: wantarray() is TRUE
print "Searching for '$substr':\n";
if (@search2) {
    print "  * @search2\n";
} else {
    print "  (No matches found)\n";
}
print "\n";

# Test D: Search for 'stem' in @items (should match both 'systematic' and 'system')
$substr = 'stem';
@search2 = search($substr, @items);
print "Searching for '$substr':\n";
if (@search2) {
    print "  * @search2\n";
} else {
    print "  (No matches found)\n";
}
print "\n";

# Test E: Search for 'san' in @items (should match none)
$substr = 'san';
@search2 = search($substr, @items);
print "Searching for '$substr':\n";
if (@search2) {
    print "  * @search2\n";
} else {
    print "  (No matches found)\n";
}
