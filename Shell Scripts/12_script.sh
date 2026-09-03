#!/bin/bash

# ==========================================================
# Parse /etc/passwd to list regular (non-system) user accounts
# /etc/passwd format (7 fields separated by ':'):
# 1. Username
# 2. Encrypted password placeholder ('x')
# 3. User ID (UID)
# 4. Group ID (GID)
# 5. User ID info / Description (GECOS)
# 6. Home directory
# 7. Login shell
# ==========================================================

file="/etc/passwd"

if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

echo "=== Regular User Accounts (UID >= 1000) ==="

while IFS=: read -r user enpass uid gid desc home shell
do
    # 1. Verify that $uid is a valid integer
    # 2. Filter for regular users (UID >= 1000) and exclude 'nobody' (UID 65534)
    if [[ "$uid" =~ ^[0-9]+$ ]] && [ "$uid" -ge 1000 ] && [ "$uid" -ne 65534 ]; then
        echo "User: $user (UID: $uid) | Home: \"$home\" | Shell: $shell"
    fi
done < "$file"



# Below code is not working
# file=/etc/passwd
# while IFS=: read -r user enpass uid gid desc home shell
# do
#	[ $uid -ge 1000 ] && echo "User $user ($uid) assigned \"$home\"directory with $shell shell"
# done < "$file"