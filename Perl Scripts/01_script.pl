#!/usr/bin/perl -w
#
# =============================================================================
# Script 01: Hello World & Perl Basics
# =============================================================================
# TOPIC  : First Perl script — system commands, print, quoting differences
# CONCEPTS: shebang line, -w flag, system(), double quotes vs single quotes,
#           escape sequences (\n), string literals
# =============================================================================

# --- system() ---
# system() executes an external shell command.
# "ls -al" lists all files (including hidden) in long format.
# The return value is the exit status of the command (0 = success).
# NOTE: "ls -al" is a Unix/Linux command. On Windows, use "dir" instead.
system("ls -al");



# --- Double-quoted string ---
# Inside double quotes ("..."), Perl INTERPOLATES:
#   - Variables like $var and @arr are expanded to their values
#   - Escape sequences like \n (newline), \t (tab) are interpreted
print "Hello world\n"; # prints "Hello world" followed by a newline


# --- Single-quoted string ---
# Inside single quotes ('...'), Perl treats (almost) everything as LITERAL:
#   - Variables like $var are NOT expanded — printed as-is
#   - Escape sequences like \n are NOT interpreted — printed as literal \n
#   - Only \\ (backslash) and \' (single quote) are special inside single quotes
# FIX: Original had "Hellow world" — extra letter 'w' in "Hello"
# This will print: Hello world\n   (the \n appears as literal text, no newline)
print 'Hello world\n'; # \n is NOT recognized in single quotes