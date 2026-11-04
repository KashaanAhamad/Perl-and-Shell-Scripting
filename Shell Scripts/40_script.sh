#!/bin/bash
#
# =============================================================================
# Script 40: LAN File Sync — Distribute Files to Multiple LAN Devices via SSH
# =============================================================================
# PURPOSE:
#   Sync/copy files from this machine to all connected LAN devices using
#   rsync over SSH. Supports both a static config file of hosts AND automatic
#   network discovery via nmap.
#
# PREREQUISITES:
#   1. SSH key-based authentication set up on target machines (ssh-copy-id)
#   2. rsync installed on both local and remote machines
#   3. nmap installed (only needed for auto-discovery mode)
#
# USAGE:
#   ./40_script.sh [OPTIONS]
#
# OPTIONS:
#   -f FILE/DIR     : File or directory to sync (REQUIRED)
#   -d REMOTE_DIR   : Destination directory on remote hosts (default: ~/synced/)
#   -c HOSTS_FILE   : Path to hosts config file (default: ./lan_hosts.conf)
#   -s SUBNET       : Subnet to scan for auto-discovery (e.g., 192.168.1.0/24)
#   -u USER         : SSH username for remote connections (default: current user)
#   -p PORT         : SSH port (default: 22)
#   -n              : Dry run — show what would be synced without actually doing it
#   -v              : Verbose output
#   -h              : Show this help message
#
# EXAMPLES:
#   # Sync a file to all hosts listed in lan_hosts.conf
#   ./40_script.sh -f /path/to/myfile.txt
#
#   # Sync a directory to all auto-discovered hosts on the subnet
#   ./40_script.sh -f /path/to/project/ -s 192.168.1.0/24
#
#   # Sync with a custom destination, user, and dry-run
#   ./40_script.sh -f ./data/ -d /opt/shared/ -u admin -n
#
#   # Combine config file hosts + auto-discovery
#   ./40_script.sh -f ./config.yaml -c ./my_hosts.conf -s 192.168.1.0/24
#
# HOSTS CONFIG FILE FORMAT (lan_hosts.conf):
#   One hostname or IP per line. Lines starting with '#' are comments.
#   Example:
#     192.168.1.10
#     192.168.1.20
#     server-node-3
#     # This is a comment
# =============================================================================

# ========================== Configuration Defaults ===========================
SOURCE_PATH=""
REMOTE_DIR="~/synced/"
HOSTS_FILE="./lan_hosts.conf"
SUBNET=""
SSH_USER="$(whoami)"
SSH_PORT=22
DRY_RUN=false
VERBOSE=false

# ========================== Color Codes for Output ===========================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ========================== Helper Functions =================================

# Print a styled banner
print_banner() {
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║              LAN FILE SYNC — Distribute to LAN Devices             ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Print success message
log_success() {
    echo -e "  ${GREEN}✔${NC} $1"
}

# Print error message
log_error() {
    echo -e "  ${RED}✘${NC} $1"
}

# Print warning message
log_warn() {
    echo -e "  ${YELLOW}⚠${NC} $1"
}

# Print info message
log_info() {
    echo -e "  ${CYAN}ℹ${NC} $1"
}

# Show usage/help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -f FILE/DIR     File or directory to sync (REQUIRED)"
    echo "  -d REMOTE_DIR   Destination directory on remote hosts (default: ~/synced/)"
    echo "  -c HOSTS_FILE   Path to hosts config file (default: ./lan_hosts.conf)"
    echo "  -s SUBNET       Subnet for auto-discovery (e.g., 192.168.1.0/24)"
    echo "  -u USER         SSH username (default: current user)"
    echo "  -p PORT         SSH port (default: 22)"
    echo "  -n              Dry run mode"
    echo "  -v              Verbose output"
    echo "  -h              Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 -f ./myfile.txt"
    echo "  $0 -f ./project/ -s 192.168.1.0/24"
    echo "  $0 -f ./data/ -d /opt/shared/ -u admin -n"
}


# ========================== Parse Command-Line Arguments =====================

while getopts "f:d:c:s:u:p:nvh" opt; do
    case "$opt" in
        f) SOURCE_PATH="$OPTARG" ;;
        d) REMOTE_DIR="$OPTARG" ;;
        c) HOSTS_FILE="$OPTARG" ;;
        s) SUBNET="$OPTARG" ;;
        u) SSH_USER="$OPTARG" ;;
        p) SSH_PORT="$OPTARG" ;;
        n) DRY_RUN=true ;;
        v) VERBOSE=true ;;
        h) show_help; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done

# ========================== Validation =======================================

print_banner

# Validate that a source file/directory was provided
if [ -z "$SOURCE_PATH" ]; then
    log_error "No source file or directory specified. Use -f to specify."
    echo ""
    show_help
    exit 1
fi

# Validate that the source exists
if [ ! -e "$SOURCE_PATH" ]; then
    log_error "Source path '$SOURCE_PATH' does not exist."
    exit 1
fi

# Check that rsync is available
if ! command -v rsync &>/dev/null; then
    log_error "'rsync' is not installed. Please install it first."
    log_info "  On Debian/Ubuntu: sudo apt install rsync"
    log_info "  On CentOS/RHEL:   sudo yum install rsync"
    exit 1
fi

# ========================== Collect Target Hosts =============================

declare -a HOSTS=()

# --- Method 1: Read hosts from config file ---
if [ -f "$HOSTS_FILE" ]; then
    log_info "Reading hosts from config file: $HOSTS_FILE"
    while IFS= read -r line; do
        # Skip empty lines and comments (lines starting with #)
        line=$(echo "$line" | xargs)  # Trim whitespace
        if [ -n "$line" ] && [[ ! "$line" =~ ^# ]]; then
            HOSTS+=("$line")
        fi
    done < "$HOSTS_FILE"
    log_success "Found ${#HOSTS[@]} host(s) from config file."
else
    log_warn "Config file '$HOSTS_FILE' not found. Skipping file-based hosts."
fi

# --- Method 2: Auto-discover hosts on the LAN subnet using nmap ---
if [ -n "$SUBNET" ]; then
    log_info "Scanning subnet $SUBNET for active hosts..."

    if ! command -v nmap &>/dev/null; then
        log_error "'nmap' is not installed. Cannot perform auto-discovery."
        log_info "  On Debian/Ubuntu: sudo apt install nmap"
        log_info "  On CentOS/RHEL:   sudo yum install nmap"
    else
        # Perform a ping scan (-sn) to find active hosts, filter for IPs
        # Exclude the local machine's IP from the results
        LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}')

        # nmap -sn outputs lines like "Nmap scan report for 192.168.1.x"
        DISCOVERED=$(nmap -sn "$SUBNET" 2>/dev/null \
            | grep "Nmap scan report" \
            | awk '{print $NF}' \
            | tr -d '()')

        DISCOVERED_COUNT=0
        for ip in $DISCOVERED; do
            # Skip our own IP to avoid syncing to ourselves
            if [ "$ip" != "$LOCAL_IP" ]; then
                # Only add if not already in the list (avoid duplicates)
                if [[ ! " ${HOSTS[*]} " =~ " ${ip} " ]]; then
                    HOSTS+=("$ip")
                    DISCOVERED_COUNT=$((DISCOVERED_COUNT + 1))
                fi
            fi
        done
        log_success "Discovered $DISCOVERED_COUNT new host(s) via network scan."
    fi
fi

# Final check: do we have any hosts?
if [ ${#HOSTS[@]} -eq 0 ]; then
    log_error "No target hosts found. Provide a hosts file (-c) or subnet (-s)."
    exit 1
fi

# ========================== Display Summary ==================================

echo ""
echo -e "${BOLD}Sync Summary:${NC}"
echo "  Source        : $SOURCE_PATH"
echo "  Destination   : $REMOTE_DIR"
echo "  SSH User      : $SSH_USER"
echo "  SSH Port      : $SSH_PORT"
echo "  Target Hosts  : ${#HOSTS[@]}"
echo "  Dry Run       : $DRY_RUN"
echo ""

echo -e "${BOLD}Target Devices:${NC}"
for host in "${HOSTS[@]}"; do
    echo "  → $host"
done
echo ""

# ========================== Sync to Each Host ================================

SUCCESS_COUNT=0
FAIL_COUNT=0

# Build rsync options
RSYNC_OPTS="-avz --progress"

if [ "$DRY_RUN" = true ]; then
    RSYNC_OPTS="$RSYNC_OPTS --dry-run"
    log_warn "DRY RUN MODE — no files will actually be transferred."
    echo ""
fi

if [ "$VERBOSE" = true ]; then
    RSYNC_OPTS="$RSYNC_OPTS --verbose"
fi

echo -e "${BOLD}Starting file distribution...${NC}"
echo "────────────────────────────────────────────────────────────────────────"

for host in "${HOSTS[@]}"; do
    echo ""
    echo -e "${CYAN}▶ Syncing to ${BOLD}${SSH_USER}@${host}:${REMOTE_DIR}${NC}"

    # Step 1: Ensure the remote destination directory exists
    ssh -p "$SSH_PORT" -o ConnectTimeout=5 -o StrictHostKeyChecking=no \
        "${SSH_USER}@${host}" "mkdir -p ${REMOTE_DIR}" 2>/dev/null

    # Step 2: Use rsync to transfer files over SSH
    # rsync flags:
    #   -a : Archive mode (preserves permissions, timestamps, symlinks, etc.)
    #   -v : Verbose output
    #   -z : Compress data during transfer (saves bandwidth)
    #   --progress : Show transfer progress per file
    rsync $RSYNC_OPTS \
        -e "ssh -p ${SSH_PORT} -o ConnectTimeout=5 -o StrictHostKeyChecking=no" \
        "$SOURCE_PATH" \
        "${SSH_USER}@${host}:${REMOTE_DIR}" 2>&1

    # Check exit status of rsync
    if [ $? -eq 0 ]; then
        log_success "Successfully synced to $host"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    else
        log_error "Failed to sync to $host"
        FAIL_COUNT=$((FAIL_COUNT + 1))
    fi
done

# ========================== Final Report =====================================

echo ""
echo "────────────────────────────────────────────────────────────────────────"
echo -e "${BOLD}Distribution Complete!${NC}"
echo ""
echo -e "  ${GREEN}✔ Successful${NC} : $SUCCESS_COUNT device(s)"
if [ $FAIL_COUNT -gt 0 ]; then
    echo -e "  ${RED}✘ Failed${NC}     : $FAIL_COUNT device(s)"
fi
echo ""

if [ "$DRY_RUN" = true ]; then
    log_warn "This was a DRY RUN. Re-run without -n to actually transfer files."
fi

# Exit with non-zero if any hosts failed
if [ $FAIL_COUNT -gt 0 ]; then
    exit 1
fi

exit 0
