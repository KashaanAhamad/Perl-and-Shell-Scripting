#!/bin/bash

# ==============================================================================
# PURPOSE: Inspect and report the file type and permissions of a given path.
#
# USAGE:   ./37_script.sh <path_to_file_or_directory>
# EXAMPLE: ./37_script.sh /etc/passwd
#          ./37_script.sh /usr/bin
# ==============================================================================

# ------------------------------------------------------------------------------
# Function: inspect_path
# Returns:
#   0 on success (file found and inspected)
#   1 on missing argument or non-existent path
# ------------------------------------------------------------------------------
inspect_path() {
    # 1. Validate function argument
    if [ "$#" -eq 0 ] || [ -z "$1" ]; then
        echo "Error: No file or directory path specified."
        echo "Usage: inspect_path <path>"
        return 1
    fi

    local target="$1"

    echo "=========================================================="
    echo "Inspecting: $target"
    echo "=========================================================="

    # 2. Check if path exists
    # -e checks existence (for symlinks pointing to valid targets)
    # -h checks if it's a symlink (even broken ones)
    if [ ! -e "$target" ] && [ ! -h "$target" ]; then
        echo "Status: Path does NOT exist."
        return 1
    fi

    # 3. Check File Type (Symlink MUST be checked first)
    if [ -L "$target" ]; then
        local destination
        destination="$(readlink "$target" 2>/dev/null)"
        echo "Type  : Symbolic Link (-> $destination)"
    elif [ -d "$target" ]; then
        echo "Type  : Directory"
    elif [ -f "$target" ]; then
        echo "Type  : Regular File"
    elif [ -b "$target" ]; then
        echo "Type  : Block Device File"
    elif [ -c "$target" ]; then
        echo "Type  : Character Device File"
    elif [ -p "$target" ]; then
        echo "Type  : Named Pipe (FIFO)"
    elif [ -S "$target" ]; then
        echo "Type  : Socket File"
    else
        echo "Type  : Other / Special File"
    fi

    # 4. Check File Permissions
    local permissions=""
    [ -r "$target" ] && permissions+="Read (r) "
    [ -w "$target" ] && permissions+="Write (w) "
    [ -x "$target" ] && permissions+="Execute (x) "
    echo "Perms : ${permissions:-None}"

    # 5. Check if file is empty
    if [ -s "$target" ]; then
        echo "Size  : Non-empty file"
    else
        echo "Size  : 0 bytes (Empty)"
    fi

    echo "=========================================================="
    return 0
}

# ==============================================================================
# SCRIPT ENTRYPOINT
# ==============================================================================
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <filename_or_directory>"
    echo "Examples:"
    echo "  $0 /etc/passwd"
    echo "  $0 /var/log"
    echo "  $0 /dev/null"
    exit 1
fi

# Inspect each argument passed from the command line
for path in "$@"
do
    inspect_path "$path"
    echo
done

exit 0
