#!/bin/bash

# ==============================================================================
# PURPOSE: Demonstrate:
#   1. How positional parameters ($0, $1, $@) behave inside vs outside functions
#   2. Variable scoping in Bash (Global variables vs 'local' variables)
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Function modifying global variable (Default Bash behavior)
# ------------------------------------------------------------------------------
func_global() {
    echo "  [Inside func_global]"
    echo "  Script Name (\$0)     : $0"
    echo "  Function Arg 1 (\$1)   : $1"
    echo "  Function Arg 2 (\$2)   : $2"
    echo "  Function All Args (\$@): $@"
    
    # Modifying x without 'local' overwrites global x!
    x=2
    echo "  Assigned x = $x (globally modified)"
}

# ------------------------------------------------------------------------------
# 2. Function using local variables (Best Practice)
# ------------------------------------------------------------------------------
func_local() {
    echo "  [Inside func_local]"
    # 'local' prevents modifying outer/global x
    local x=99
    echo "  Assigned local x = $x (protected scope)"
}

# ==============================================================================
# SCRIPT BODY
# ==============================================================================
echo "=========================================================="
echo "1. Positional Parameters in Script Body"
echo "=========================================================="
echo "Script Name (\$0)    : $0"
echo "Script Arg 1 (\$1)   : ${1:-(none)}"
echo "Script Arg 2 (\$2)   : ${2:-(none)}"
echo "Script All Args (\$@): ${@:-(none)}"
echo

echo "=========================================================="
echo "2. Global Variable Mutation Demonstration"
echo "=========================================================="
x=1
echo "Before calling func_global : x = $x"

# Call function with parameters 10 and 20
func_global 10 20

echo "After calling func_global  : x = $x (Notice x changed from 1 to 2!)"
echo

echo "=========================================================="
echo "3. Local Variable Protection Demonstration"
echo "=========================================================="
x=1
echo "Before calling func_local  : x = $x"

func_local

echo "After calling func_local   : x = $x (Notice global x remains 1!)"
echo

exit 0
