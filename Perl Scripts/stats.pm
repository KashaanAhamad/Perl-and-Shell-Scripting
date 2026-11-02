package stats;
#
# =============================================================================
# Module: stats.pm — Object-Oriented Statistics Calculator
# =============================================================================
# TOPIC  : Building a reusable OOP module in Perl
# CONCEPTS:
#   1. 'package' Declaration:
#      - Creates a namespace. All subroutines defined after 'package stats;'
#        belong to the 'stats' namespace (stats::new, stats::addvalue, etc.).
#   2. Constructor Pattern ('sub new'):
#      - Creates a blessed anonymous hash '{}' to serve as the object.
#      - 'ref($arg0) || $arg0' allows both 'stats->new()' (class method)
#        and '$obj->new()' (copy constructor idiom).
#   3. Instance Data:
#      - Object attributes are stored as hash keys:
#        'numlist' (array ref), 'x_sum' (running sum), 'x2_sum' (sum of squares).
#   4. Running Accumulators (Optimization):
#      - Instead of recalculating sums each time, this module accumulates
#        'x_sum' and 'x2_sum' incrementally in addvalue().
#      - Variance formula: Var = (n * Σx² - (Σx)²) / n²
#   5. Module Return Value:
#      - Every Perl module MUST end with a true value ('1;') to indicate
#        successful loading. Without this, 'use stats;' would fail!
#
# =============================================================================

# =============================================================================
# Constructor: new()
# =============================================================================
# Usage:
#   my $obj = stats->new();     # Class method call
#   my $obj = new stats;        # Indirect object syntax (same thing)
#
# How it works:
#   1. $_[0] receives the class name ("stats") when called as stats->new().
#   2. 'ref($arg0) || $arg0' handles both class and instance invocation:
#      - If called on a class name (string): ref("stats") returns "", so
#        $cls = "stats" (the string itself via the || fallback).
#      - If called on an existing object: ref($obj) returns "stats", so
#        $cls = "stats" (from the ref() result).
#   3. An empty anonymous hash '{}' is created and blessed into the class.
#   4. 'clear()' initializes instance attributes to default values.
sub new {
    my $arg0 = $_[0];
    my $cls  = ref($arg0) || $arg0;
    my $this = {};
    bless $this, $cls;
    $this->clear();
    return $this;
}

# =============================================================================
# Method: clear()
# =============================================================================
# Resets all instance data to initial state.
# This is called by the constructor and can also be called manually to
# re-use the same object for a new dataset.
sub clear {
    my $this = $_[0];
    $this->{'numlist'} = undef;   # Will become an array ref on first addvalue()
    $this->{'x_sum'}   = 0;      # Running sum: Σx
    $this->{'x2_sum'}  = 0;      # Running sum of squares: Σx²
}

# =============================================================================
# Method: addvalue($num)
# =============================================================================
# Append a value to the list and update running accumulators.
# Uses push to grow the 'numlist' array ref, and incrementally updates
# both 'x_sum' (for mean) and 'x2_sum' (for variance/std dev).
sub addvalue {
    my $this = $_[0];
    my $num  = $_[1];
    if (defined $num) {
        push @{$this->{'numlist'}}, $num;
        $this->{'x_sum'}  += $num;
        # BUG FIX: Was 'num**2' (missing '$' sigil), now '$num ** 2'
        $this->{'x2_sum'} += $num ** 2;
    }
}

# =============================================================================
# Method: getTotal()
# =============================================================================
# Returns the running sum of all values added so far.
# Time complexity: O(1) — just reads the pre-accumulated value.
sub getTotal {
    my $this = $_[0];
    return $this->{'x_sum'};
}

# =============================================================================
# Method: getMean()
# =============================================================================
# Returns the arithmetic mean: Mean = Σx / n
# Returns 0 if no values have been added (guards against division by zero).
sub getMean {
    my $this    = $_[0];
    my @numlist = @{$this->{'numlist'}};
    if (!@numlist) { return 0; }
    return $this->getTotal() / @numlist;
}

# =============================================================================
# Method: getVariance()
# =============================================================================
# Returns the population variance using the computational formula:
#   Var = (n * Σx² - (Σx)²) / n²
#
# This is mathematically equivalent to:
#   Var = (1/n) * Σ(xi - mean)²
# but avoids a second pass through the data by using running accumulators.
sub getVariance {
    my $this    = $_[0];
    my @numlist = @{$this->{'numlist'}};
    my $n       = @numlist;
    my $sum_x2  = $this->{'x2_sum'};
    my $sum_x   = $this->{'x_sum'};
    if (!$n) { return 0; }
    return ($n * $sum_x2 - $sum_x ** 2) / ($n ** 2);
}

# =============================================================================
# Method: getStdDev()
# =============================================================================
# Returns the population standard deviation: StdDev = √Variance
# Uses '** 0.5' as an alternative to 'sqrt()'.
sub getStdDev {
    my $this = $_[0];
    return $this->getVariance() ** 0.5;
}

# =============================================================================
# Method: getValueList()
# =============================================================================
# Returns the full list of values that have been added.
# In scalar context, returns the count of values.
sub getValueList {
    my $this = $_[0];
    return @{$this->{'numlist'}};
}

# Every Perl module MUST return a true value as its last statement.
# Without '1;', any script doing 'use stats;' will fail with:
#   "stats.pm did not return a true value"
1;
