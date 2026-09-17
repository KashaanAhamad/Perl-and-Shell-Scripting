#!/bin/bash -v

# ==============================================================================
# PURPOSE: String Case Conversion in Bash (to_lower, to_upper, capitalize)
# Demonstrates:
#   1. Method A: Pure Bash 4+ parameter expansion (${var,,} and ${var^^})
#   2. Method B: External 'tr' with Here-Strings (<<<)
#   3. Command Substitution: capturing function return values via $(func)
# ==============================================================================

# ------------------------------------------------------------------------------
# METHOD A: Pure Bash (Fastest, zero external subprocesses)
# ------------------------------------------------------------------------------
to_lower_bash() {
    local input="$*"
    echo "${input,,}"       # ,, converts all characters to lowercase
}

to_upper_bash() {
    local input="$*"
    echo "${input^^}"       # ^^ converts all characters to uppercase
}

to_title_bash() {
    local input="$*"
    echo "${input^}"        # ^ capitalizes the first character
}

# ------------------------------------------------------------------------------
# METHOD B: Using 'tr' and Here-Strings (<<<)
# ------------------------------------------------------------------------------
to_lower_tr() {
    local input="$*"
    # tr with POSIX character classes using Here-String (<<<)
    tr '[:upper:]' '[:lower:]' <<< "$input"
}

# ==============================================================================
# DEMONSTRATION
# ==============================================================================
domain="AirtelIndia.COM"
sample_text="ThIs Is A TeSt MeSsAgE!"

echo "=========================================================="
echo "Original Domain      : $domain"
echo "Original Sample Text : $sample_text"
echo "=========================================================="

echo
echo "1. Pure Bash Lowercase (${str,,}):"
out_lower=$(to_lower_bash "$domain")
echo "   Domain -> $out_lower"

echo
echo "2. Pure Bash Uppercase (${str^^}):"
out_upper=$(to_upper_bash "$domain")
echo "   Domain -> $out_upper"

echo
echo "3. Pure Bash Capitalize First Letter (${str^}):"
out_title=$(to_title_bash "hello world")
echo "   Result -> $out_title"

echo
echo "4. POSIX 'tr' with Here-String (<<<):"
out_tr=$(to_lower_tr "$sample_text")
echo "   Result -> $out_tr"

echo "=========================================================="
exit 0
