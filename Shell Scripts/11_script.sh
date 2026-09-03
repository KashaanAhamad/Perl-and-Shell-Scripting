#!/bin/bash

# ==========================================================
# 1. Parsing space-separated fields (IFS=' ')
# ==========================================================
echo "=== Part 1: Space-delimited field parsing ==="

# file=/home/Kashaan/abc1  or file=/home/Kashaan
# Create temporary sample file with space-separated data
cat << 'EOF' > sample_space.txt
sandeep himanshu tanish
apple banana cherry
one two three
EOF

while IFS=' ' read -r f1 f2 f3
do
    echo "Field #3: $f3 ==> Field #2: $f2 ==> Field #1: $f1"
done < "sample_space.txt"

echo

# ==========================================================
# 2. Parsing colon-separated fields (IFS=':')
# ==========================================================
echo "=== Part 2: Colon-delimited field parsing ==="

# Create temporary sample file with colon-separated data
cat << 'EOF' > sample_colon.txt
sandeep:himanshu:tanish
root:x:0
first:second:third
EOF

while IFS=':' read -r f1 f2 f3
do
    echo "Field #3: $f3 ==> Field #2: $f2 ==> Field #1: $f1"
done < "sample_colon.txt"

# Clean up temporary demonstration files
rm -f sample_space.txt sample_colon.txt
