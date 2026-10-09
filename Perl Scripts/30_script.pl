#!/usr/bin/perl -w
#
# =============================================================================
# Script 30: File Locking (Reader Process) — 'flock' and Shared Locks (LOCK_SH)
# =============================================================================
# TOPIC  : Inter-process file synchronization using advisory file locking
# CONCEPTS:
#   1. 'use Fcntl ":flock"' — importing lock constants (LOCK_SH, LOCK_EX, etc.)
#   2. '$$' special variable: the current Process ID (PID)
#   3. 'flock(FILE, LOCK_SH)' — SHARED read lock
#   4. Difference between Shared (read) and Exclusive (write) locks
#   5. The '$!' special variable for error reporting with 'die'
#   6. Cooperative concurrency pair: Script 30 (Reader) + Script 31 (Writer)
# =============================================================================

# Import standard locking constants from the Fcntl module:
#   LOCK_SH = 1 (Shared lock: multiple readers allowed)
#   LOCK_EX = 2 (Exclusive lock: only one writer allowed)
#   LOCK_NB = 4 (Non-blocking: don't wait if locked)
#   LOCK_UN = 8 (Unlock: release lock)
use Fcntl ':flock';

# =============================================================================
# 1. Opening the File for Reading
# =============================================================================
# Best practice: Always include '$!' in 'die' messages to show the OS error reason.
open(FILE, "<myfile.dat") or die "Cannot open myfile.dat: $!\n";

# '$$' holds the current process's OS Process ID (PID)
print "[PID: $$] Requesting shared read lock (LOCK_SH) for myfile.dat...\n";


# =============================================================================
# 2. Acquiring Shared Read Lock (LOCK_SH)
# =============================================================================
# - Multiple processes can hold LOCK_SH at the same time.
# - If a writer process holds LOCK_EX (from Script 31), flock() will BLOCK (pause)
#   until the writer finishes and releases the lock.
# - Once LOCK_SH is granted, writers (LOCK_EX) are blocked from writing until we unlock.

flock(FILE, LOCK_SH);

# Fixed typo: "loack" -> "lock", clarified message
print "[PID: $$] Acquired shared read lock for myfile.dat.\n";
print "[PID: $$] Reading lines from myfile.dat (sleeping 1s per line):\n";

# Read each line sequentially
while (<FILE>) {
    # 'sleep 1' pauses for 1 second per line to simulate ongoing read work
    # and give you time to observe concurrent readers/writers running!
    sleep 1;
    print "  [PID: $$] $_";
}


# =============================================================================
# 3. Releasing Lock and Closing
# =============================================================================
# LOCK_UN releases the lock so waiting writers can proceed.
# (Note: closing the filehandle via close() also releases locks automatically).
flock(FILE, LOCK_UN);
print "[PID: $$] Released shared read lock for myfile.dat.\n";

close FILE;
print "[PID: $$] File closed. Done.\n";
