#!/bin/bash
# catching interrupt #2 i.e. SIGINT

# ==========================================================
# PURPOSE: Demonstrate signal handling and trapping (SIGINT / Ctrl+C)
#
# Common Signals:
#   1  = SIGHUP  (Hangup / Terminal closed)
#   2  = SIGINT  (Interrupt from keyboard via Ctrl+C)
#   15 = SIGTERM (Termination request)
#   9  = SIGKILL (Force kill - CANNOT be trapped or ignored)
# ==========================================================

# Custom function to execute when Ctrl+C (SIGINT) is received
handle_sigint() {
    echo -e "\n[TRAP] Ctrl+C was pressed, but SIGINT is trapped! The script will continue running."
}

# 1. Set the trap for SIGINT (Signal 2)
# To completely ignore with no output: trap '' SIGINT
trap handle_sigint SIGINT

echo "=========================================================="
echo "SIGINT (Ctrl+C) is now trapped for the next 10 seconds."
echo "Try pressing Ctrl+C in your terminal to see the trap in action!"
echo "=========================================================="

for (( i = 10; i >= 1; i-- ))
do
    echo "Sleeping... $i seconds remaining (Ctrl+C disabled)"
    sleep 1
done

echo
echo "Resetting SIGINT trap back to default behavior..."
# Reset trap to default
trap - SIGINT

echo "Trap removed. Pressing Ctrl+C will now exit normally."
read -r -t 10 -p "Press Ctrl+C within 10s to verify normal exit: " input
echo -e "\nScript finished successfully."


# trap '' 2
# read CTRL-C from keyboard with 30 second timeout
# read -t 30 -p "I am sleeping. you can not exit even by ctrl-C"