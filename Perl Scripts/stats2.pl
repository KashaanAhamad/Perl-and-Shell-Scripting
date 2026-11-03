#!/usr/bin/perl -w
#
# =============================================================================
# Driver Script: stats2.pl — Extended Statistics Calculator with Min/Max
# =============================================================================
# TOPIC  : Using an inherited OOP module (stats2.pm extends stats.pm)
# CONCEPTS:
#   1. Polymorphism in Action:
#      - 'stats2->new()' calls the INHERITED constructor from stats.pm.
#      - '$obj->addvalue($num)' calls stats2's OVERRIDDEN version (which
#        tracks min/max, then delegates to stats::addvalue via SUPER::).
#      - '$obj->getMean()' calls the INHERITED method from stats.pm directly.
#   2. Inheritance Chain:
#      - stats2 inherits from stats via '@ISA = ("stats")'.
#      - Method resolution order: stats2 -> stats -> UNIVERSAL.
#   3. Signal Handling:
#      - Same Ctrl+C (SIGINT) technique as stats.pl, but the results now
#        include Minimum and Maximum from stats2's added methods.
#   4. The Original Script Was Incomplete:
#      - stats2.pl was cut off at line 13 mid-statement ('print ""').
#      - This version completes the full driver script with all statistics
#        output, interactive input loop, and input validation.
# =============================================================================

# Load modules from current directory (replaces hardcoded '/home/Kashaan/')
use lib '.';
use stats2;

# =============================================================================
# Signal Handler: Catch Ctrl+C (SIGINT)
# =============================================================================
$SIG{'INT'} = 'getResults';

# =============================================================================
# Create the stats2 object
# =============================================================================
# 'stats2->new()' works because:
#   1. stats2 does NOT define its own new().
#   2. Perl walks up @ISA and finds stats::new().
#   3. stats::new() uses 'ref($arg0) || $arg0' -> $cls = "stats2".
#   4. 'bless {}, "stats2"' creates an object blessed into the stats2 class.
#   5. The object inherits ALL stats methods + stats2's overrides and extensions.
my $obj = stats2->new();

# =============================================================================
# Signal Handler Subroutine: getResults()
# =============================================================================
# Prints all statistics (inherited from stats + min/max from stats2).
sub getResults {
    print "\n\n";
    print "=" x 50, "\n";
    print "  EXTENDED RESULTS (stats2)\n";
    print "=" x 50, "\n";

    my @values = $obj->getValueList();

    if (!@values) {
        print "  No values were entered.\n";
    } else {
        # --- Inherited methods from stats.pm ---
        printf "  Number of values    : %d\n",   scalar(@values);
        printf "  Total (Sum)         : %.4f\n",  $obj->getTotal();
        printf "  Mean (Average)      : %.4f\n",  $obj->getMean();
        printf "  Variance            : %.4f\n",  $obj->getVariance();
        printf "  Standard Deviation  : %.4f\n",  $obj->getStdDev();

        # --- New methods from stats2.pm ---
        printf "  Minimum             : %.4f\n",  $obj->getMinimum();
        printf "  Maximum             : %.4f\n",  $obj->getMaximum();
        printf "  Range (Max - Min)   : %.4f\n",  $obj->getMaximum() - $obj->getMinimum();

        print  "  Values entered      : ", join(", ", @values), "\n";
    }

    print "=" x 50, "\n";
    exit(0);
}

# =============================================================================
# Main Interactive Loop
# =============================================================================
print <<'BANNER';

╔══════════════════════════════════════════════════╗
║     EXTENDED STATISTICS CALCULATOR (stats2)      ║
╠══════════════════════════════════════════════════╣
║  Now includes: Min, Max, and Range tracking!     ║
║  Enter one numeric value per line                ║
║  Press Ctrl+C to display results and exit        ║
╚══════════════════════════════════════════════════╝

BANNER

while (1) {
    print ">> ";
    chomp(my $num = <STDIN>);

    # Skip blank lines silently
    next if $num eq '';

    # Validate that input is numeric (integer or decimal, optionally signed)
    if ($num !~ /^[+-]?\d+(\.\d+)?$/) {
        print "   (Skipping non-numeric input: '$num')\n";
        next;
    }

    $obj->addvalue($num);
    printf "   Added: %s  |  Total: %.4f  |  Min: %s  |  Max: %s  |  Count: %d\n",
           $num,
           $obj->getTotal(),
           $obj->getMinimum(),
           $obj->getMaximum(),
           scalar($obj->getValueList());
}
