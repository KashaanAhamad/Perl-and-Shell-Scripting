package stats2;
#
# =============================================================================
# Module: stats2.pm — Derived Statistics Class with Min/Max Tracking
# =============================================================================
# TOPIC  : Perl inheritance using @ISA and method overriding with SUPER::
# CONCEPTS:
#   1. Inheritance via '@ISA':
#      - '@ISA' (Is-A) is Perl's mechanism for single and multiple inheritance.
#      - Setting '@ISA = ("stats")' tells Perl: "When a method is not found in
#        package stats2, look for it in package stats."
#      - This means stats2 automatically inherits: new(), clear(), getTotal(),
#        getMean(), getVariance(), getStdDev(), getValueList() from stats.pm.
#   2. Method Overriding:
#      - stats2 defines its own 'addvalue()' which OVERRIDES stats::addvalue().
#      - The override adds min/max tracking logic, then delegates to the
#        parent's version using 'SUPER::addvalue($num)'.
#   3. 'SUPER::' Pseudo-Class:
#      - '$this->SUPER::addvalue($num)' calls the parent class's version of
#        addvalue() (i.e., stats::addvalue), allowing the child to extend
#        functionality without duplicating the parent's code.
#   4. Why No Constructor is Defined:
#      - Because stats::new() uses the 2-argument form of bless:
#        'bless $this, $cls' where $cls = ref($arg0) || $arg0.
#      - When called as 'stats2->new()', $cls becomes "stats2", so the object
#        is blessed into stats2 automatically. No override needed!
# =============================================================================

use lib '.';
use stats;

# @ISA declares the parent class(es) for inheritance.
# Perl's method resolution: stats2 -> stats -> UNIVERSAL
our @ISA = ('stats');

# =============================================================================
# Method Override: addvalue($num)
# =============================================================================
# Extends the parent's addvalue() by tracking minimum and maximum values.
#
# Flow:
#   1. On the FIRST value added, both 'min' and 'max' are initialized to $num.
#   2. On subsequent values, 'min' and 'max' are updated via ternary comparisons.
#   3. After tracking, delegates to stats::addvalue() via SUPER:: to handle
#      the numlist push and running sum/sum-of-squares accumulation.
sub addvalue {
    my ($this, $num) = @_;

    # Guard: only process defined values (same contract as parent)
    return unless defined $num;

    if (!defined $this->{'min'}) {
        # First value ever added — initialize both min and max
        $this->{'min'} = $num;
        $this->{'max'} = $num;
    } else {
        # Update min if $num is smaller
        $this->{'min'} = ($num < $this->{'min'}) ? $num : $this->{'min'};
        # Update max if $num is larger
        $this->{'max'} = ($num > $this->{'max'}) ? $num : $this->{'max'};
    }

    # Invoke the BASE CLASS version of addvalue() to handle:
    #   - push to numlist
    #   - x_sum accumulation
    #   - x2_sum accumulation
    # Alternative syntax: $this->stats::addvalue($num);
    $this->SUPER::addvalue($num);
}

# =============================================================================
# Method: getMinimum()
# =============================================================================
# Returns the smallest value added so far.
sub getMinimum {
    my $this = $_[0];
    return $this->{'min'};
}

# =============================================================================
# Method: getMaximum()
# =============================================================================
# Returns the largest value added so far.
sub getMaximum {
    my $this = $_[0];
    return $this->{'max'};
}

# Module must return true value
1;
