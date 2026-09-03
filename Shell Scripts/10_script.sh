#!/bin/bash

# ==========================================================
# 1. Reading a file line-by-line
# - IFS= prevents trimming of leading and trailing whitespace
# - read -r prevents backslashes (\) from being treated as escape characters
# ==========================================================
file="/etc/passwd" #/usr/share/dict/words

if [ -f "$file" ]; then
    echo "=== Reading $file (first 5 lines) ==="
    count=0
    while IFS= read -r line
    do
        echo "$line"
        ((count++))
        # Limit output to 5 lines for demonstration
        if [ "$count" -ge 5 ]; then
            echo "... (truncated for brevity)"
            break
        fi
    done < "$file"
else
    echo "File '$file' not found."
fi

echo

# ==========================================================
# 2. Inspect file metadata
# ==========================================================
[ -f /etc/passwd ] && ls -l /etc/passwd
[ -f /etc/passwd ] && ls -l /usr/share/dict/words

echo

# ==========================================================
# 3. Creating a file non-interactively using a HereDoc
# (Interactive terminal equivalent: `cat > abc`, type lines, press Ctrl+D)
# ==========================================================
echo "=== Creating sample file 'abc' using Here-Doc ==="
cat << 'EOF' > abc
sandeep
himanshu
tanish
EOF

echo "Contents of 'abc':"
cat abc

# Clean up created sample file (optional)
rm -f abc
