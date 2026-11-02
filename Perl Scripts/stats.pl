#!/usr/bin/perl -w
#
# =============================================================================
# Driver Script: stats.pl — Interactive Statistics Calculator
# =============================================================================
# TOPIC  : Using a custom OOP module (stats.pm) and UNIX signal handling
# CONCEPTS:
#   1. 'use lib "."' vs 'BEGIN { @INC = ... }':
#      - The original script hardcoded '/home/Kashaan/' in @INC, which only
#        works on the author's machine.
#      - 'use lib "."' adds the current working directory to @INC portably.
#      - Modern Perl (5.26+) removed '.' from @INC for security, so this is
#        necessary even when stats.pm is in the same directory.
#   2. Signal Handling via '%SIG':
#      - '$SIG{"INT"} = "getResults";' installs a handler for SIGINT (Ctrl+C).
#      - When the user presses Ctrl+C, instead of terminating immediately,
#        Perl calls the 'getResults' subroutine first.
#   3. Indirect Object Syntax:
#      - 'new stats' is Perl's indirect object syntax for 'stats->new()'.
#      - Both are equivalent; the arrow syntax 'stats->new()' is preferred
#        in modern Perl for clarity.
#   4. Interactive Input Loop:
#      - An infinite 'while(1)' loop reads numbers from STDIN one at a time.
#      - The user terminates by pressing Ctrl+C, which triggers the signal handler.
#
# =============================================================================

# 'use lib "."' adds the current directory to @INC so Perl can find stats.pm
# regardless of the system or user. This replaces the hardcoded path.
use lib '.';
use stats;

# =============================================================================
# Signal Handler: Catch Ctrl+C (SIGINT)
# =============================================================================
# %SIG is Perl's special hash for signal handlers.
# Key 'INT' corresponds to SIGINT (sent by Ctrl+C).
# Value is the name of a subroutine to call when the signal is received.
$SIG{'INT'} = 'getResults';

# =============================================================================
# Create the stats object
# =============================================================================
# 'stats->new()' calls the constructor defined in stats.pm:
#   1. Creates an anonymous hash {}
#   2. Blesses it into the 'stats' package
#   3. Calls clear() to initialize attributes
#   4. Returns the blessed reference
my $obj = stats->new();

# =============================================================================
# Signal Handler Subroutine: getResults()
# =============================================================================
# Called when the user presses Ctrl+C. Prints all computed statistics
# and then exits cleanly.
sub getResults {
    print "\n\n";
    print "=" x 50, "\n";
    print "  RESULTS\n";
    print "=" x 50, "\n";

    my @values = $obj->getValueList();

    if (!@values) {
        print "  No values were entered.\n";
    } else {
        printf "  Number of values    : %d\n",   scalar(@values);
        printf "  Total (Sum)         : %.4f\n",  $obj->getTotal();
        printf "  Mean (Average)      : %.4f\n",  $obj->getMean();
        printf "  Variance            : %.4f\n",  $obj->getVariance();
        printf "  Standard Deviation  : %.4f\n",  $obj->getStdDev();
        print  "  Values entered      : ", join(", ", @values), "\n";
    }

    print "=" x 50, "\n";
    exit(0);
}

# =============================================================================
# Main Interactive Loop
# =============================================================================
# Prints a welcome banner and continuously reads numbers from STDIN.
print <<'BANNER';

╔══════════════════════════════════════════════════╗
║         INTERACTIVE STATISTICS CALCULATOR        ║
╠══════════════════════════════════════════════════╣
║  Calculate statistics on a sequence of numbers   ║
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
    printf "   Added: %s  |  Running total: %.4f  |  Count: %d\n",
           $num, $obj->getTotal(), scalar($obj->getValueList());
}

# Note: This line is never reached because the loop is infinite.
# The script exits via the getResults() signal handler (Ctrl+C).
