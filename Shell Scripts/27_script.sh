#!/bin/bash

# ==========================================================
# PURPOSE: Demonstrate advanced text processing with sed, tr,
#          sort, and uniq.
#
# USAGE:
#   ./27_script.sh strip_comments <c_file.c>
#   ./27_script.sh word_freq <text_file.txt>
# ==========================================================

# ----------------------------------------------------------
# Function 1: Strip C-style comments from a source file
# ----------------------------------------------------------
remove_c_comments() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found."
        exit 1
    fi

    echo "=== Stripping C comments from '$file' ==="
    # 1. Delete single-line block comments /* ... */
    # 2. Delete multi-line comment delimiters
    # 3. Delete // single-line comments
    sed -e 's%/\*.*\*/%%g' \
        -e '/^\/\*/,/\*\//d' \
        -e 's%//.*$%%' \
        "$file" > "${file%.*}_nocomments.${file##*.}"

    echo "Saved cleaned file to: ${file%.*}_nocomments.${file##*.}"
}

# ----------------------------------------------------------
# Function 2: Word Frequency Count
# ----------------------------------------------------------
word_frequency() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found."
        exit 1
    fi

    echo "=== Word Frequency Analysis for '$file' ==="
    # Pipeline breakdown:
    # 1. tr -s ' ' '\n'   : Squeeze multiple spaces and convert to newlines (one word per line)
    # 2. tr -d '[:punct:]': Remove all punctuation (.,?!;:)
    # 3. tr 'A-Z' 'a-z'   : Convert all words to lowercase
    # 4. grep -v '^$'     : Remove empty lines
    # 5. sort             : Sort words alphabetically (REQUIRED before uniq)
    # 6. uniq -c          : Count occurrences of each unique word
    # 7. sort -nr         : Sort numerically in reverse (highest frequency first)
    tr -s ' ' '\n' < "$file" | \
        tr -d '[:punct:]' | \
        tr '[:upper:]' '[:lower:]' | \
        grep -v '^$' | \
        sort | \
        uniq -c | \
        sort -nr | \
        head -n 20
}

# ----------------------------------------------------------
# Main Execution Router
# ----------------------------------------------------------
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [strip_comments|word_freq] <filename>"
    echo "Examples:"
    echo "  $0 strip_comments program.c"
    echo "  $0 word_freq document.txt"
    exit 1
fi

case "$1" in
    strip_comments)
        remove_c_comments "${2:-me.c}"
        ;;
    word_freq)
        word_frequency "${2:-file.txt}"
        ;;
    *)
        # Default fallback: if a single filename was passed directly
        if [ -f "$1" ]; then
            echo "Running word frequency on $1:"
            word_frequency "$1"
        else
            echo "Unknown mode: $1"
            echo "Usage: $0 [strip_comments|word_freq] <filename>"
            exit 1
        fi
        ;;
esac

exit 0


# #!/bin/bash
# #using sed command you need to remove comment from a c file

# filen=$1
# if [ $# -eq "1" ]
# then
# 	sed -e '/^\/\*/d' -e '/.*\*\//d' $filen > comment
# else
# 	echo "Usage $0 filename"
# fi

# sed_exercise=$1
# if [ $# -eq "1" ]
# then
# 	sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\\/g' $sed_exercise | tr 'A-Z' 'a-z' | uniq -c | sort -n > changes
# else
# 	echo "Usage $0 sed_exercise"
# fi

# cat > sed_exercise

# sed -e 's/\.//g' -e 's/\,//g' sed_exercise  #sed 's/[.,]//g'
# sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\\/g' sed_exercise
# sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\\//g' sed_exercise | tr 'A-Z' 'a-z'
# sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\\/g' sed_exercise | tr 'A-Z' 'a-z' | uniq -c
# sed -e 's/\.//g' -e 's/\,//g' -e 's/ /\\/g' sed_exercise | tr 'A-Z' 'a-z' | uniq -c sort -n