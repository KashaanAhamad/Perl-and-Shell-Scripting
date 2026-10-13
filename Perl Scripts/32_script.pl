#!/usr/bin/perl -w
#
# =============================================================================
# Script 32: File Pointers & Byte Size — 'seek', 'tell', and 'local *FILE'
# =============================================================================
# TOPIC  : Low-level filehandle positioning and determining file byte sizes
# CONCEPTS:
#   1. 'use Fcntl ":seek"' — importing SEEK_SET (0), SEEK_CUR (1), SEEK_END (2)
#   2. 'seek(FH, OFFSET, WHENCE)' — moving the file pointer
#   3. 'tell(FH)' — querying the current byte position
#   4. 'local *FILE' — Typeglob localization for safe subroutines (legacy vs modern)
#   5. Modern alternative: lexical filehandles ('open my $fh, "<", $file')
#   6. Shortcut comparison: Perl's built-in file test operator '-s $filename'
# =============================================================================

# Import seek constants:
#   SEEK_SET = 0 : Seek from the beginning of the file
#   SEEK_CUR = 1 : Seek relative to the current position
#   SEEK_END = 2 : Seek relative to the end of the file
use Fcntl ':seek';

# =============================================================================
# Subroutine: getFileSize($filename)
# =============================================================================
# Prototype ($) declares that this subroutine accepts exactly ONE scalar argument.

sub getFileSize ($) {
    my $filename = $_[0];
    
    # --- Typeglob Localization: 'local *FILE;' ---
    # In older Perl, bareword filehandles (like 'FILE') were package-global.
    # If two functions used 'FILE', one would close or overwrite the other's handle!
    # 'local *FILE' creates a localized symbol table entry for the duration of this sub.
    # (In modern Perl 5.6+, writing 'open my $fh, "<", $filename' is preferred).
    local *FILE;
    
    # Open the file for reading; return undef if opening fails
    open FILE, "<$filename" or return undef;
    
    # Move the file pointer 0 bytes from the very END of the file
    seek(FILE, 0, SEEK_END);
    
    # 'tell(FILE)' returns the current byte offset of the pointer.
    # Since we are at the end, the offset equals the total file size in bytes!
    # (Note: Explicitly passing 'FILE' to tell(FILE) is safer than bare 'tell()').
    my $size = tell(FILE);
    
    close FILE;
    return $size;
}


# =============================================================================
# Main Program Execution
# =============================================================================
# If arguments are not passed via command line, use default files present in repo:
@ARGV = ("myfile.dat", "file1", "file2") unless @ARGV >= 3;

my $filename = $ARGV[0];
my $file1    = $ARGV[1];
my $file2    = $ARGV[2];

print "Checking sizes for: $filename, $file1, $file2\n\n";

# Print formatted table of file sizes
printf "%-15s %-15s %-15s\n", "Filename", "Size (seek/tell)", "Size (built-in -s)";
printf "%-15s %-15s %-15s\n", "--------", "----------------", "-----------------";

for my $f ($filename, $file1, $file2) {
    my $size = getFileSize($f);
    my $seek_str = defined($size) ? "$size Bytes" : "Not Found";
    
    # The built-in -s operator returns file size directly from filesystem metadata (stat)
    my $stat_str = (-e $f) ? (-s $f) . " Bytes" : "Not Found";
    
    printf "%-15s %-15s %-15s\n", $f, $seek_str, $stat_str;
}
