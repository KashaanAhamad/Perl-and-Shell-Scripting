#!/bin/bash

# ==============================================================================
# PURPOSE: Comprehensive Tutorial & Reference for 'sed' (Stream Editor)
#
# TOPICS COVERED:
#   1. Address selection & line printing (p, -n)
#   2. Line deletion (d)
#   3. Stepping / Strides (1~2)
#   4. In-place file modification (-i)
#   5. Substitution flags (first match, /g, /2, /p)
# ==============================================================================

# Create local sample file for demonstration
cat << 'EOF' > sample_license.txt
Line 1: Copyright (c) 2026 Developer
Line 2: All rights reserved.
Line 3: Redistribution and use in source and binary forms
Line 4: are permitted provided that the following conditions
Line 5: are met:
Line 6: 1. Redistributions of source code must retain notice.
Line 7: 2. Redistributions in binary form must reproduce notice.
Line 8: End of License.
EOF

echo "=========================================================="
echo "PART 1: SED PRINTING & ADDRESS RANGES"
echo "=========================================================="

echo -e "\n1. Print line 1 only (sed -n '1p'):"
sed -n '1p' sample_license.txt

echo -e "\n2. Print lines 1 to 3 (sed -n '1,3p'):"
sed -n '1,3p' sample_license.txt

echo -e "\n3. Print line 1 plus next 2 lines (sed -n '1,+2p'):"
sed -n '1,+2p' sample_license.txt

echo -e "\n4. Print odd-numbered lines only (stride 1~2: sed -n '1~2p'):"
sed -n '1~2p' sample_license.txt

echo
echo "=========================================================="
echo "PART 2: SED DELETION COMMANDS (d)"
echo "=========================================================="

echo -e "\n1. Delete lines 1 and 2 (sed '1,2d'):"
sed '1,2d' sample_license.txt

echo -e "\n2. Delete lines 3 through 5 (sed '3,+2d'):"
sed '3,+2d' sample_license.txt

echo
echo "=========================================================="
echo "PART 3: SED SUBSTITUTION (s/pattern/replacement/flags)"
echo "=========================================================="

# Create sample repetitive sentence
cat << 'EOF' > sample_song.txt
This is the song that goes on and on, my friend, on and on.
EOF

echo "Original text:"
cat sample_song.txt

echo -e "\n1. Replace FIRST occurrence of 'on' (sed 's/on/forward/'):"
sed 's/on/forward/' sample_song.txt

echo -e "\n2. Replace ALL occurrences globally (sed 's/on/forward/g'):"
sed 's/on/forward/g' sample_song.txt

echo -e "\n3. Replace only the SECOND occurrence of 'on' (sed 's/on/forward/2'):"
sed 's/on/forward/2' sample_song.txt

echo -e "\n4. Replace 2nd occurrence and print ONLY matching line (sed -n 's/on/forward/2p'):"
sed -n 's/on/forward/2p' sample_song.txt

# ==========================================================
# PART 4: IN-PLACE FILE EDITING (-i)
# Note: sed -i modifies the file directly on disk
# ==========================================================
echo -e "\nModifying sample_license.txt in-place..."
sed -i 's/2026/2027/g' sample_license.txt
echo "Updated line 1:"
head -n 1 sample_license.txt

# Clean up demonstration files
rm -f sample_license.txt sample_song.txt

echo -e "\nDone! All sed demonstrations executed successfully."
exit 0


