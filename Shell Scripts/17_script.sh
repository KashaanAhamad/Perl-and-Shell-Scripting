#!/bin/bash

# ==========================================================
# PURPOSE: Demonstrate command-line arguments and check if
#          a user account exists in /etc/passwd.
# ==========================================================

# 1. Parameter Inspection
echo "Script name (\$0)     : $0"
echo "All arguments (\$*)   : $*"
echo "Argument count (\$#)  : $#"

# 2. Argument Validation (Ensure at least 1 argument is provided)
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

user="$1"
db="/etc/passwd"

# 3. Check if user exists in /etc/passwd
# -q: Quiet mode (suppresses stdout/stderr output)
# ^${user}: Matches username strictly from the beginning of the line up to ':'
if grep -q "^${user}:" "$db" 2>/dev/null; then
    echo "Result: User '$user' was found in $db (Exit code: $?)"
else
    echo "Result: User '$user' was NOT found in $db (Exit code: $?)"
fi

#   [ $# -eq 0 ] && {echo "Usage: $0 username"; exit 1; }
#   grep "^$user" $db > /dev/null
#   retval=$?
#   [ $retval -eq 0 ] && echo "$user found" || echo "$user not found"

# ==========================================================
# Example usage:
#   ./17_script.sh
#   ./17_script.sh root
#   ./17_script.sh nonexistentuser
#   
#   ./finduser
#   ./finduser sandeep
#   ./finduser spandeep sandeep
# ==========================================================
