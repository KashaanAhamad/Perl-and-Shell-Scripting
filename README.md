# Linux Shell & Perl Scripting Master Repository 🐧💻

[![Language - Bash](https://img.shields.io/badge/Language-Bash_5.0+-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Tool - AWK](https://img.shields.io/badge/Tool-AWK-red?logo=gnu&logoColor=white)](https://www.gnu.org/software/gawk/)
[![Standard - POSIX](https://img.shields.io/badge/Standard-POSIX_Compliant-blue)](https://pubs.opengroup.org/onlinepubs/9699919799/)
[![Code Style - ShellCheck](https://img.shields.io/badge/Linter-ShellCheck_Passed-00599C)](https://www.shellcheck.net/)

A curated, comprehensive repository of practical Linux Shell scripts and AWK utilities developed and refined through hands-on learning. Each script is heavily commented, follows modern Bash best practices, and explores specific concepts ranging from fundamental syntax to advanced system administration, stream processing, signal handling, and recursion.

---

## 📑 Table of Contents
- [Repository Structure](#-repository-structure)
- [Core Concepts Covered](#-core-concepts-covered)
- [Complete Shell Script Catalog](#-complete-shell-script-catalog)
- [How to Run the Scripts](#-how-to-run-the-scripts)
- [Key Bash Best Practices & Gotchas](#-key-bash-best-practices--gotchas)
- [Recommended Learning Resources](#-recommended-learning-resources)

---

## 📁 Repository Structure

```text
Perl & Shell Scripting/
├── Shell Scripts/           # Complete suite of 39 Bash & AWK learning scripts
│   ├── 01_script.sh         # Number range validations & modern [[ ... ]] test
│   ├── 02_script.sh         # Loop iterations & brace expansions {1..5}
│   │   ...
│   ├── 32_script.awk        # Standalone AWK financial report generator
│   └── 39_script.sh         # Recursive vs. iterative factorial algorithms
├── Perl Scripts/            # Perl programming scripts (Upcoming section)
└── README.md                # Comprehensive documentation and study guide
```

---

## 🧠 Core Concepts Covered

### 1. Arithmetic & Conditionals
- **Numeric Conditionals**: Utilizing native `(( expression ))` and `[[ ... ]]` arithmetic instead of legacy `expr`.
- **Input Validation**: Regular expression pattern matching (e.g. `^[-]?[0-9]+$`) to prevent shell evaluation errors.

### 2. Loops & Flow Control
- **`for` Loops**: Range brace expansions `{1..100}`, list iteration, and C-style 3-expression loops `for (( i=0; i<N; i++ ))`.
- **`while` & `until` Loops**: Sentinel exit loops, infinite loops (`while :`), and `until` inversion logic.
- **Loop Control**: Utilizing `break` for early termination and `continue` guard clauses.

### 3. File I/O, Streams & Redirection
- **Safe Line-by-Line Reading**: `while IFS= read -r line; do ... done < "$file"`.
- **Custom `IFS` Parsing**: Parsing colon-separated files (`/etc/passwd`) and space-delimited data.
- **Here-Documents (`<< 'EOF'`) & Here-Strings (`<<<`)**: Embedding non-interactive data streams and feeds without temporary files.
- **Process Substitution**: `<(find ...)` to prevent subshell variable scoping loss in loops.

### 4. Special Variables & Argument Handling
- **Positional Parameters**: `$0` (script name), `$1`..`$9` (arguments), `$#` (argument count).
- **Array Expansion**: Understanding the crucial difference between `"$*"` (single string joined by `IFS`) and `"$@"` (discrete quoted parameters).
- **Argument Shifting**: Processing arbitrary command-line arguments dynamically using `shift`.
- **Process ID & Status**: Inspecting `$$` (current PID) and `$?` (exit code of last command).

### 5. Signal Handling & Process Control (`trap`)
- **Signal Interception**: Using `trap` to catch `SIGINT` (Ctrl+C), `SIGQUIT` (Ctrl+\), and `SIGTSTP` (Ctrl+Z).
- **State Modification via Callbacks**: Executing custom callback handler functions when signals fire.
- **Trap Cleanup**: Restoring default signal behavior using `trap - SIGINT`.

### 6. Stream Editing & Text Processing (`sed`, `awk`, `tr`, `grep`)
- **`sed` Operations**: Address ranges (`1,5p`, `1~2d`), line deletions (`d`), substitution flags (`/g`, `/2`, `/p`), and in-place file modifications (`-i`).
- **`awk` Data Analysis**: Column summation (`awk -v col=N`), field record separators (`FS`), built-in counters (`NR`), and `BEGIN`/`END` reporting.
- **Pipelining**: Combining `tr -s`, `tr -d '[:punct:]'`, `sort`, `uniq -c`, and `sort -nr` for word frequency analysis.

### 7. Modular Functions & Recursion
- **Variable Scoping**: Using `local` to protect variable scope inside functions vs default global mutation.
- **Case Modification**: Pure Bash 4+ string transformations (`${var,,}`, `${var^^}`, `${var^}`) vs `tr`.
- **Recursion**: Implementing recursive algorithms (e.g. Factorials $N!$) and understanding base cases and subshell overhead.

---

## 📜 Complete Shell Script Catalog

| Script | Topic / Primary Concept | Key Commands & Features |
| :--- | :--- | :--- |
| [`01_script.sh`] | Range Validation & Robust Input | `read -r`, regex integer check, `[[ -ge && -le ]]` |
| [`02_script.sh`] | For Loop Iteration | Brace expansion `{1..5}`, list iteration |
| [`03_script.sh`] | Arithmetic Expansion & Modulo | `$((i * i))`, `(( i % 2 == 0 ))`, Even/Odd check |
| [`04_script.sh`] | Formatted Output Sequences | `echo -n` inline printing, loop filtering |
| [`05_script.sh`] | Command Execution & Formatting | `command -v` availability check, preserving newlines |
| [`06_script.sh`] | Safe File Globbing | Direct globbing `~/*` vs `ls` anti-patterns, quoting |
| [`07_script.sh`] | Bash Arrays & File Auditing | Array definitions `("${files[@]}")`, `[ -f ]`, `ls -l` |
| [`08_script.sh`] | C-Style Loops & Grid Patterns | `for (( i=1; i<=N; i++ ))`, nested loops |
| [`09_script.sh`] | While Loops & Process Controls | `while :`, `break`, background jobs `&`, `kill`, `ps` |
| [`10_script.sh`] | Line-by-Line File Reading | `while IFS= read -r line`, Here-Docs `cat << 'EOF'` |
| [`11_script.sh`] | Custom `IFS` Delimiter Parsing | `IFS=' '` vs `IFS=':'` multi-field extraction |
| [`12_script.sh`] | Linux User Account Auditing | `/etc/passwd` parsing, UID filtering ($\ge 1000$) |
| [`13_script.sh`] | Until Loop Construct | `until [ "$i" -gt 6 ]`, inverse while logic |
| [`14_script.sh`] | Interactive Menu with Sentinel | Sentinel check `-999`, compound command `{ ...; }` |
| [`15_script.sh`] | Linear Search & Flag Variables | Directory search, flag management, `break` early exit |
| [`16_script.sh`] | Chinese Remainder Congruences | `continue` guard clauses, multi-condition modulo |
| [`17_script.sh`] | Positional CLI Arguments | `$0`, `$*`, `$#`, `$1`, `grep -q` user lookup |
| [`18_script.sh`] | `$*` vs `$@` & Argument `shift` | Changing `IFS`, argument rotation using `shift` |
| [`19_script.sh`] | File Slicing Pipeline | `tail -n +X \| head -n Y`, range extraction |
| [`20_script.sh`] | Sum of Digits Calculation | Built-in arithmetic `(( sum += n % 10 ))`, `${n#-}` |
| [`21_script.sh`] | String Reversal Algorithm | Character substring slicing `${input:$i:1}`, `${#input}` |
| [`22_script.sh`] | Signal Trapping (`SIGINT`) | `trap handle_sigint SIGINT`, `trap - SIGINT` |
| [`23_script.sh`] | Multi-Signal Interception | Trapping `SIGINT`, `SIGQUIT`, `SIGTSTP`, `declare -i` |
| [`24_script.sh`] | Dynamic Signal Callback State | Modifying global state upon signal reception |
| [`25_script.sh`] | Binary String Inspection | `strings -f` inside compiled executables, `find` |
| [`26_script.sh`] | Space to Underscore Batch Rename | Classic `grep`/`sed` vs Pure Bash `${file// /_}` |
| [`27_script.sh`] | C Comment Stripping & Word Freq | Multi-regex `sed`, `tr -d '[:punct:]'`, `sort \| uniq -c` |
| [`28_script.sh`] | Sed Master Tutorial & Cheatsheet | Line ranges, deletions (`d`), substitution flags, `-i` |
| [`29_script.sh`] | ASCII Character Table Generator | Decimal, Hex (`%X`), Octal (`%o`), ASCII control labels |
| [`30_script.sh`] | Column Sum & Average with AWK | `awk -v col=N`, numeric validation, statistics |
| [`31_script.sh`] | User Enumeration (Bash vs AWK) | `awk -F:`, AWK record number `NR`, pure Bash `read` |
| [`32_script.awk`] | Standalone AWK Report Generator | `#!/usr/bin/awk -f`, `BEGIN`/`END`, formatted tables |
| [`33_script.sh`] | Multi-Mode Range Formatter | `case` statement, 10-per-line formatting, line wrap |
| [`34_script.sh`] | Standalone Word Frequency | Stream normalization, tokenization, sorting |
| [`35_script.sh`] | Process ID & Function Defaults | PID `$$`, fallback parameter `${1:-Friend}`, `date` |
| [`36_script.sh`] | Function Scoping & Parameters | `local` variable isolation vs global parameter mutation |
| [`37_script.sh`] | Deep Path & File Inspector | Inspecting symlinks (`-L`), directories, perms, sockets |
| [`38_script.sh`] | Case Conversion (Bash 4+ vs tr) | `${var,,}`, `${var^^}`, `${var^}`, `tr` Here-Strings |
| [`39_script.sh`] | Factorial Algorithms (Recursion) | Recursive vs iterative calculation, 64-bit bounds |

---

## 🚀 How to Run the Scripts

### 1. Grant Execution Permissions
Make scripts executable using `chmod`:
```bash
chmod +x "Shell Scripts"/*.sh
chmod +x "Shell Scripts"/*.awk
```

### 2. Executing Scripts
Run scripts directly by passing necessary arguments:
```bash
# Example 1: Check even/odd range with 10 numbers per line
./"Shell Scripts"/33_script.sh 1 50 1

# Example 2: Calculate word frequency in a file
./"Shell Scripts"/34_script.sh "Shell Scripts"/file.txt

# Example 3: Inspect file types and permissions
./"Shell Scripts"/37_script.sh /etc/passwd /usr/bin

# Example 4: Calculate factorials (Recursive and Iterative)
./"Shell Scripts"/39_script.sh 10

# Example 5: Run standalone AWK script
./"Shell Scripts"/32_script.awk "Shell Scripts"/data
# OR via awk:
awk -f "Shell Scripts"/32_script.awk "Shell Scripts"/data
```

---

## 💡 Key Bash Best Practices & Gotchas

> [!TIP]
> 1. **Always Double-Quote Variables**: Use `"$var"` rather than `$var` to prevent accidental word-splitting and pathname expansion on files containing spaces or special characters.
> 2. **Prefer `[[ ... ]]` and `(( ... ))` over `[ ... ]`**: Modern Bash double brackets `[[ ]]` prevent syntax crashes on empty strings and support regex matching (`=~`). `(( ))` handles integer arithmetic natively.
> 3. **Avoid Parsing `ls` in Loops**: Never write `for f in $(ls)`. Use native Bash globbing `for f in *` or `for f in /dir/*` which properly handles all filenames.
> 4. **Use `local` Inside Functions**: Prevent accidental corruption of outer script variables by declaring helper variables with `local var="value"`.
> 5. **Pass Variables to AWK using `-v`**: Never concatenate shell variables directly into AWK script strings (e.g. `awk '{ print $'"$col"' }'`). Use `awk -v col="$col" '{ print $col }'`.

---

## 📚 Recommended Learning Resources

### 📖 Documentation & Guides
1. **[GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/)** — The official, authoritative specification of the GNU Bourne-Again SHell.
2. **[Greg's Wiki / Bash Guide](https://mywiki.wooledge.org/BashGuide)** — Widely regarded as the best pragmatic guide to modern Bash programming and common pitfalls.
3. **[Advanced Bash-Scripting Guide (TLDP)](https://tldp.org/LDP/abs/html/)** — An in-depth exploration of shell scripting with hundreds of practical examples.
4. **[Bash Hackers Wiki](https://wiki.bash-hackers.org/)** — Comprehensive breakdown of syntax, parameter expansions, and internal commands.
5. **[The GNU Awk User's Guide (Gawk)](https://www.gnu.org/software/gawk/manual/)** — The definitive guide to stream manipulation and reporting with AWK.

### 🛠️ Linters & Tools
- **[ShellCheck](https://www.shellcheck.net/)** — Essential static analysis tool that automatically flags syntax errors, anti-patterns, and portability bugs in shell scripts.
- **[Explainshell.com](https://explainshell.com/)** — Interactive tool to dissect complex shell command-line flags and pipes.

---

*Authored and curated as part of the HEP Training Perl & Shell Scripting Program.*
