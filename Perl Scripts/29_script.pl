#!/usr/bin/perl -w
#
# =============================================================================
# Script 29: The Diamond Operator (<>), '@ARGV', and Unix-Style Filters
# =============================================================================
# TOPIC  : Command-line input processing and file slurping with '<>'
# CONCEPTS:
#   1. The Diamond Operator '<>' (The "Null Filehandle")
#   2. Automatic fallback: reads files in '@ARGV' OR reads from '<STDIN>'
#   3. The '@ARGV' array (stores command-line arguments)
#   4. The '$ARGV' scalar (stores the filename currently being processed)
#   5. Programmatically manipulating '@ARGV' to specify target files
#   6. Cross-platform handling (Unix /etc/passwd vs local test files)
# =============================================================================

# =============================================================================
# 1. How the Diamond Operator (<>) Works
# =============================================================================
# - If command-line arguments are provided:
#     e.g., perl 29_script.pl file1 file2
#     Perl opens 'file1', reads all its lines, closes it, then opens 'file2'.
# - If NO command-line arguments are provided (@ARGV is empty):
#     '<>' automatically defaults to reading from standard input (<STDIN>)!
#
# Each read sets '$_' to the current line (including the trailing newline).

print "=== Part 1: Processing Command-Line Arguments or STDIN via '<>' ===\n";

if (@ARGV) {
    print "Reading files passed via command line: @ARGV\n";
} else {
    print "No arguments passed. Enter text below (finish with Ctrl+D / Ctrl+Z):\n";
}

while (<>) {
    # '$ARGV' holds the name of the file currently open (or '-' for STDIN)
    print "[$ARGV line $.] $_";
}


# =============================================================================
# 2. Programmatically Setting '@ARGV'
# =============================================================================
# You can override or populate '@ARGV' directly in code!
# The next '<>' loop will process whatever filenames you place in '@ARGV'.

print "\n=== Part 2: Programmatically Overriding \@ARGV ===\n";

# Using local file 'file1' (exists in this repository) or fallback to sample
my $sample_file = -e "file1" ? "file1" : "myfile.dat";

# Original had: @ARGV = ("/etc/passwd"); (Unix only)
# Cross-platform: use local file if /etc/passwd doesn't exist
@ARGV = (-e "/etc/passwd") ? ("/etc/passwd") : ($sample_file);

print "Assigned \@ARGV = (@ARGV). Reading contents via '<>':\n";

while (<>) {
    print "[$ARGV] $_";
}
