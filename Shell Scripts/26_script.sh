#!/bin/bash

# ==============================================================================
# PURPOSE: Replace whitespace/spaces with underscores in filenames within a directory.
# This script demonstrates TWO approaches:
#   1. Approach 1: The classic way using external utilities (grep + sed).
#   2. Approach 2: The modern, safe, and efficient way using Pure Bash.
# ==============================================================================


# ==============================================================================
# APPROACH 1: Classic Method (grep + sed + expr/let)
# ==============================================================================
#
# HOW IT WORKS:
# 1. Loops over files in current directory with 'for filename in *'.
# 2. Pipes each filename to 'grep -q " "' to check if it contains a space.
# 3. If grep returns 0 (found space), pipes filename to 'sed -e "s/ /_/g"' to
#    substitute all spaces with underscores.
# 4. Calls 'mv "$fname" "$n"' to rename the file.
# 5. Increments a counter with 'let "number += 1"'.
#
# FLAWS / LIMITATIONS OF APPROACH 1:
# 1. Performance Overhead (High Forking Cost):
#    - Spawns TWO external subshell processes (grep and sed) for EVERY file.
#    - In a directory with 1,000 files, this forks 2,000+ processes, making it slow.
# 2. Risk of Accidental File Overwrite (Data Loss):
#    - 'mv "$fname" "$n"' does not check if "$n" already exists. If "my_file.txt"
#      already exists, renaming "my file.txt" will permanently overwrite it!
# 3. Fixed Directory:
#    - Hardcoded to run only in the current directory ('*').
# 4. Filenames with Special Characters:
#    - If filenames contain characters like '&' or backslashes, passing them
#      directly to sed without escaping can cause unexpected substitution errors.
#
# ==============================================================================

classic_rename_method() {
    echo "=== Running Approach 1: Classic Method (grep + sed) ==="
    ONE=1
    number=0
    FOUND=0

    for filename in *
    do
        # Check if filename contains a space using grep
        echo "$filename" | grep -q " "
        if [ $? -eq $FOUND ]; then
            fname="$filename"
            # Substitute space with underscore using sed
            n=$(echo "$fname" | sed -e "s/ /_/g")
            mv "$fname" "$n"
            let "number += 1"
        fi
    done

    # Print summary with singular/plural handling
    if [ "$number" -eq "$ONE" ]; then
        echo "$number file renamed"
    else
        echo "$number files renamed"
    fi
}


# ==============================================================================
# APPROACH 2: Modern Pure Bash Method (Recommended)
# ==============================================================================
#
# WHY THIS IS BETTER:
# 1. Zero External Subprocesses (Blazing Fast):
#    - Uses native Bash pattern matching: [[ "$filename" == *" "* ]]
#    - Uses native Bash parameter expansion: ${filename// /_}
#    - Runs 100% inside the shell without invoking grep or sed.
# 2. Overwrite Protection:
#    - Checks '[ -e "$new_filepath" ]' before renaming to avoid data loss.
# 3. Configurable Target Directory:
#    - Accepts a custom directory as an argument (defaults to current directory '.').
# 4. Safe Globbing:
#    - Uses 'shopt -s nullglob' so empty directories don't expand to a literal '*'.
#
# ==============================================================================

modern_rename_method() {
    local target_dir="${1:-.}"

    if [ ! -d "$target_dir" ]; then
        echo "Error: Directory '$target_dir' does not exist."
        return 1
    fi

    echo "=== Running Approach 2: Pure Bash Method in '$target_dir' ==="
    local number=0

    # Enable nullglob to safely handle empty directories
    shopt -s nullglob

    for filepath in "$target_dir"/*
    do
        local filename="$(basename "$filepath")"
        local dirpath="$(dirname "$filepath")"

        # 1. Pure Bash check for spaces
        if [[ "$filename" == *" "* ]]; then
            # 2. Pure Bash global replacement: replace ' ' with '_'
            local new_filename="${filename// /_}"
            local new_filepath="$dirpath/$new_filename"

            # 3. Collision protection: check if destination already exists
            if [ -e "$new_filepath" ]; then
                echo "[SKIPPED] '$filename' -> Target '$new_filename' already exists!"
                continue
            fi

            # 4. Safely rename
            mv "$filepath" "$new_filepath"
            echo "[RENAMED] '$filename'  ==>  '$new_filename'"
            ((number++))
        fi
    done

    echo "--------------------------------------------------"
    if [ "$number" -eq 1 ]; then
        echo "Summary: 1 file renamed."
    else
        echo "Summary: $number files renamed."
    fi
}


# ==============================================================================
# MAIN EXECUTION
# (Calls Approach 2 by default; you can change to classic_rename_method to test)
# ==============================================================================
modern_rename_method "${1:-.}"
exit 0
