#!/usr/bin/perl -w
#
# =============================================================================
# Script 33: Binary File Copying — 'binmode' and Buffered 'read()'
# =============================================================================
# TOPIC  : Low-level byte-for-byte file copying using memory-safe buffers
# CONCEPTS:
#   1. 'binmode(FILEHANDLE)' — Disabling line-ending translation (vital on Windows!)
#   2. 'read(FILEHANDLE, $buffer, $bufferSize)' — Chunk-based I/O
#   3. Memory safety: streaming files in 1 KB chunks instead of slurping whole files
#   4. Subroutine prototypes: 'sub copy($$)'
#   5. The '$!' system error variable for 'die'
#   6. Production alternative: Perl core module 'File::Copy'
# =============================================================================

# =============================================================================
# Subroutine: copy($src, $dest)
# =============================================================================
# Prototype ($$) ensures the subroutine requires exactly two scalar arguments.

sub copy ($$) {
    my ($src, $dest) = @_;
    
    # Open source for reading, destination for writing (truncated/created)
    open FILE1, "<$src"  or die "Cannot open source file '$src': $!\n";
    open FILE2, ">$dest" or die "Cannot open destination file '$dest': $!\n";
    
    # --- The 'binmode' Directive ---
    # CRITICAL ON WINDOWS:
    # In Windows text mode, Perl converts carriage returns ("\r\n" <-> "\n").
    # For binary files (images, PDFs, executables), this translation corrupts the file!
    # 'binmode' disables all translation, ensuring an exact raw byte copy.
    binmode FILE1;
    binmode FILE2;
    
    # --- Chunked Buffered Reading ---
    # Instead of reading the entire file into memory at once (which would exhaust
    # RAM on large files), we stream it in chunks of 1024 bytes (1 KB).
    my ($buffer, $numChars);
    my $bufferSize = 1024;
    my $totalBytes = 0;
    
    # 'read(FH, $buf, $len)' returns:
    #   - Number of bytes actually read (positive integer)
    #   - 0 when EOF (End of File) is reached
    #   - undef on error
    while ($numChars = read(FILE1, $buffer, $bufferSize)) {
        $totalBytes += $numChars;
        print FILE2 $buffer; # Write raw chunk to destination
    }
    
    close FILE1;
    close FILE2;
    
    return $totalBytes;
}


# =============================================================================
# Main Execution
# =============================================================================
# Provide safe fallback filenames if arguments aren't supplied on command line:
my $src  = $ARGV[0] || 'myfile.dat';
my $dest = $ARGV[1] || 'new.dat';

print "--- Performing File Copy ---\n";
print "Source file     : $src\n";
print "Destination file: $dest\n";

# Call copy subroutine and capture total bytes copied
my $bytesCopied = copy($src, $dest);

print "\nSuccess! Copied $bytesCopied bytes from '$src' to '$dest'.\n";

# NOTE: In production Perl, use the standard library module:
#   use File::Copy;
#   copy($src, $dest) or die "Copy failed: $!";
