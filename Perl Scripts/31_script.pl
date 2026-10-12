#!/usr/bin/perl -w
#
# =============================================================================
# Script 31: File Locking (Writer Process) — 'flock' and Exclusive Locks (LOCK_EX)
# =============================================================================
# TOPIC  : Exclusive write locking and multi-process file appending
# CONCEPTS:
#   1. 'flock(FILE, LOCK_EX)' — EXCLUSIVE write lock (only one writer allowed)
#   2. Mutual exclusion: LOCK_EX blocks all other readers (LOCK_SH) and writers
#   3. Append mode ('>>') for safe file extension
#   4. Process ID tracking ('$$') in file output
#   5. The Diamond Operator '<>' with default fallback files in '@ARGV'
# =============================================================================

use Fcntl ':flock';

# --- 1. Setting Default Target Files ---
# If no files were passed via the command line, use default repository files:
@ARGV = ("file1", "file2") unless @ARGV;

# --- 2. Open File in Append Mode (>>) ---
# '>>' opens the file for writing at the end (creates the file if nonexistent).
open(FILE, ">>myfile.dat") or die "Cannot open myfile.dat: $!\n";

print "[PID: $$] Requesting exclusive write lock (LOCK_EX) for myfile.dat...\n";


# =============================================================================
# 3. Acquiring Exclusive Write Lock (LOCK_EX)
# =============================================================================
# - LOCK_EX ensures MUTUAL EXCLUSION:
#   Only ONE process in the entire operating system can hold LOCK_EX on this file.
# - If Script 30 is currently reading (holding LOCK_SH), this call to flock()
#   will BLOCK (wait) until Script 30 finishes and releases its read lock!
# - Conversely, while Script 31 holds LOCK_EX, all other readers and writers must wait.

flock(FILE, LOCK_EX);

print "[PID: $$] Acquired exclusive write lock for myfile.dat.\n";
print "[PID: $$] Reading from (@ARGV) and appending to myfile.dat:\n";


# =============================================================================
# 4. Appending Lines with Process ID
# =============================================================================
# The diamond operator '<>' reads lines from 'file1', then 'file2'
while (<>) {
    chomp;
    
    print "  [PID: $$] Appending line: '$_'\n";
    print FILE "$_ (process id $$)\n";
    
    # Simulate deliberate work while holding the lock
    sleep 1;
}


# =============================================================================
# 5. Releasing Lock and Closing
# =============================================================================
# Releases the exclusive lock so other waiting processes (like Script 30) can proceed
flock(FILE, LOCK_UN);
print "[PID: $$] Released exclusive write lock for myfile.dat.\n";

close FILE;
print "[PID: $$] File closed. Done.\n";

