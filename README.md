# Linux Shell & Perl Scripting Master Repository 🐧💻🐪

[![Language - Bash](https://img.shields.io/badge/Language-Bash_5.0+-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Language - Perl](https://img.shields.io/badge/Language-Perl_5.26+-39457E?logo=perl&logoColor=white)](https://www.perl.org/)
[![Tool - AWK](https://img.shields.io/badge/Tool-AWK-red?logo=gnu&logoColor=white)](https://www.gnu.org/software/gawk/)
[![Standard - POSIX](https://img.shields.io/badge/Standard-POSIX_Compliant-blue)](https://pubs.opengroup.org/onlinepubs/9699919799/)
[![Code Style - ShellCheck](https://img.shields.io/badge/Linter-ShellCheck_Passed-00599C)](https://www.shellcheck.net/)

A curated, comprehensive repository of practical Linux Shell scripts, AWK utilities, and Perl programs developed and refined through hands-on learning. Each script is heavily commented, follows modern best practices, and explores specific concepts ranging from fundamental syntax to advanced system administration, stream processing, signal handling, regular expressions, references, and object-oriented programming.

---

## 📑 Table of Contents
- [Repository Structure](#-repository-structure)
- [Core Concepts Covered — Shell](#-core-concepts-covered--shell)
- [Complete Shell Script Catalog](#-complete-shell-script-catalog)
- [Core Concepts Covered — Perl](#-core-concepts-covered--perl)
- [Complete Perl Script Catalog](#-complete-perl-script-catalog)
- [How to Run the Scripts](#-how-to-run-the-scripts)
- [Key Bash Best Practices & Gotchas](#-key-bash-best-practices--gotchas)
- [Key Perl Best Practices & Gotchas](#-key-perl-best-practices--gotchas)
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
├── Perl Scripts/            # Complete suite of 46 Perl learning scripts & modules
│   ├── 01_script.pl         # Hello World & Perl basics
│   ├── 02_script.pl         # String operators & type coercion
│   │   ...
│   ├── 42_script.pl         # Object-Oriented Perl with bless()
│   ├── stats.pm             # OOP statistics module (mean, variance, stddev)
│   ├── stats.pl             # Interactive statistics calculator driver
│   ├── stats2.pm            # Derived class with inheritance & SUPER::
│   └── stats2.pl            # Extended statistics calculator with min/max
└── README.md                # Comprehensive documentation and study guide
```

---

## 🧠 Core Concepts Covered — Shell

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

## 🐪 Core Concepts Covered — Perl

### 1. Scalars, Strings & Basic I/O
- **Hello World & `print`**: System commands via `system()`, double-quoted interpolation vs single-quoted literals, escape sequences.
- **String Operators**: Concatenation (`.`), repetition (`x`), operator precedence, automatic string↔number coercion.
- **Built-in String Functions**: `length()`, `reverse()`, `substr()` (extract, insert, lvalue form).
- **Standard Input**: `<STDIN>` line input operator, `chomp()` vs `chop()`, combined `chomp($var = <STDIN>)` idiom.

### 2. Operators & Expressions
- **Arithmetic & Modulo**: `%` with negative numbers (sign-of-divisor rule), compound assignment (`.=`, `x=`).
- **String vs Numeric Comparison**: `lt`, `gt`, `eq`, `cmp` (string) vs `<`, `>`, `==`, `<=>` (numeric).
- **Ternary Operator**: `CONDITION ? TRUE : FALSE` inline branching.
- **Bitwise Operations**: Left shift `<<`, right shift `>>`, AND, OR, XOR.

### 3. Control Flow & Branching
- **Conditionals**: `if`/`elsif`/`else` chains, the unique `unless` keyword (negated conditional).
- **Statement Modifiers**: Postfix `if`/`unless` for single-expression guards.
- **Spelling Rule**: Perl uses `elsif` (not `elif` or `else if`).

### 4. Loops & Iteration
- **C-Style `for` Loop**: `for (INIT; TEST; STEP) { ... }`.
- **`while` & `until` Loops**: Pre-test vs inverted-condition iteration.
- **Post-Test Loop**: `do { ... } until (CONDITION)` guaranteeing at least one execution.
- **`foreach` Iteration**: Direct list traversal with loop variable aliasing.
- **Loop Control**: `last` (break), `next` (continue), `redo`, and labeled loops (`OUTER:`, `INNER:`) for multi-level control.

### 5. Arrays & List Operations
- **Array Basics**: `@` sigil, `$array[N]` element access, `$#array` (last index), scalar context for array size.
- **Stack/Queue Operations**: `push`, `pop`, `shift`, `unshift`.
- **Slicing & Splicing**: Array slices `@array[LIST]`, `splice(ARRAY, OFFSET, LENGTH, REPLACEMENT)`.
- **Transformations**: `map { BLOCK } @list`, `sort { $a <=> $b }` (spaceship), `reverse`, `join`, `split`.
- **Special Variables**: `$,` (output field separator), `$_` (topic variable).
- **List Flattening**: Perl's automatic flattening of nested lists into a single list.

### 6. Hashes & Lookup Algorithms
- **Hash Basics**: `%hash`, fat comma `=>`, `$hash{key}`, hash slices `@hash{LIST}`.
- **Hash Utilities**: `keys`, `values`, `delete`, `exists()`, `each` iterator.
- **Algorithm Comparison**: Linear search O(N) vs Binary search O(log N) vs Hash lookup O(1).

### 7. Subroutines & Functions
- **Subroutine Definition**: `sub name { }`, `@_` argument array, `return` values.
- **Lexical Scoping**: `my` variable declarations for proper encapsulation.
- **Prototypes**: `sub name($$) { }`, `sub name(\%$) { }` for compile-time argument checking.
- **Context Sensitivity**: `wantarray()` for returning different values in list vs scalar context.

### 8. File I/O & System Operations
- **Diamond Operator `<>`**: Reading from `@ARGV` files or `STDIN`, `$.` line number, `$ARGV` filename.
- **File Locking**: `use Fcntl ':flock'`, `flock(FH, LOCK_SH)` shared locks, `flock(FH, LOCK_EX)` exclusive locks, `LOCK_UN` unlock.
- **File Pointers**: `seek(FH, OFFSET, WHENCE)`, `tell(FH)`, `use Fcntl ':seek'` constants.
- **Binary I/O**: `binmode(FH)` for platform-safe binary mode, `read(FH, $buffer, $size)` chunked buffered reads.
- **Error Handling**: `die` with `$!` (system error), `open ... or die`.

### 9. Regular Expressions
- **Pattern Matching**: `=~` binding operator, `m/PATTERN/`, alternation `(a|b|c)`, dot wildcard `.`.
- **Modifiers**: `/i` (case-insensitive), `/g` (global), `/s` (single-line), `/m` (multi-line), `/e` (eval in substitution).
- **Character Classes**: `[0-9]`, `[a-zA-Z]`, `\d`, `\w`, `\s`, negated classes `[^...]`.
- **Quantifiers**: `?` (0 or 1), `*` (0+), `+` (1+), `{min,max}` (bounded).
- **Anchors**: `^` (start), `$` (end), word boundaries `\b`.
- **Capture Groups & Backreferences**: `(...)`, `$1`/`$2`/`$3`, backreferences `\1`/`\2` for duplicate detection.
- **Substitution & Transliteration**: `s/PATTERN/REPLACEMENT/flags`, `tr/SEARCHLIST/REPLACEMENTLIST/`.

### 10. References & Pointers
- **Reference Creation**: Backslash operator `\$var`, `\@array`, `\%hash`.
- **Dereferencing**: Sigil shorthand `$$ref`, block syntax `${$ref}`, arrow operator `$ref->{key}` / `$ref->[0]`.
- **Anonymous Constructors**: `[...]` (anonymous arrays), `{...}` (anonymous hashes).
- **Multi-Level References**: References to references (`REF(0x...)`), read-only constant references.
- **Type Introspection**: `ref()` function returning `SCALAR`, `ARRAY`, `HASH`, `REF`, `CODE`, `Regexp`, or class name.

### 11. Object-Oriented Perl
- **`bless()` Function**: Transforming plain references into objects by attaching a package (class) name.
- **Constructor Pattern**: `sub new { bless {}, shift }` with `ref($arg0) || $arg0` for class/instance dispatch.
- **Instance Data**: Storing attributes in blessed anonymous hashes (`$self->{key}`).
- **Method Dispatch**: Arrow operator `$obj->method()`, `isa()`, `can()` introspection.
- **Inheritance**: `@ISA` array for Is-A relationships, method resolution order.
- **Method Overriding**: `SUPER::method()` for parent delegation, polymorphic behavior.
- **Signal Handling**: `%SIG` hash for trapping `SIGINT`, `SIGQUIT` in interactive OOP programs.

---

## 🐪 Complete Perl Script Catalog

| Script | Topic / Primary Concept | Key Features & Functions |
| :--- | :--- | :--- |
| [`01_script.pl`] | Hello World & Perl Basics | `system()`, `print`, double vs single quoting, `\n` escape sequences, shebang, `-w` flag |
| [`02_script.pl`] | String Operators, Coercion & `substr` | `.` (concat), `x` (repeat), auto coercion, `length()`, `reverse()`, `substr()` |
| [`03_script.pl`] | Reading User Input & Simple Math | `<STDIN>`, `chomp()` vs `chop()`, combined `chomp($var = <STDIN>)`, arithmetic |
| [`04_script.pl`] | String Repetition with User Input | `x` repetition operator, newline retention effects on repeated output |
| [`05_script.pl`] | Operators: Modulo, Comparison, Bitwise | `%` (modulo), `lt`/`gt`/`eq`, ternary `? :`, bitwise `>>` `<<`, `.=` and `x=` |
| [`06_script.pl`] | Control Flow — `if`, `else`, `unless` | `if`/`else` branching, `unless` (negated conditional), statement modifiers |
| [`07_script.pl`] | Loops — C-style `for` and `while` | `for (INIT; TEST; STEP)`, `while` loop, post-decrement `$a--` |
| [`08_script.pl`] | Post-Test Loops — `do ... until` | `do { } until ()`, guaranteed execution, `eq` string equality, sentinel loop |
| [`09_script.pl`] | Arrays & Iteration — `foreach` vs `for` | `@` sigil, `foreach`, `reverse()` in list context, `$#a` last index |
| [`10_script.pl`] | Loop Control with Labels | Loop labels (`OUTER:`, `INNER:`), `last LABEL`, `next LABEL`, factor-finding |
| [`11_script.pl`] | Multi-Way Branching — `if`/`elsif`/`else` | `elsif` spelling rule, chained conditionals, numeric relational comparisons |
| [`12_script.pl`] | Accumulator Pattern & Sentinel Loop | Accumulator `$sum`, sentinel value 999, priming read, `+=`, `until`, `while(1)/last if` |
| [`13_script.pl`] | Formatted Output — `printf` (Counter) | `printf`, format specifiers `%g`/`%d`/`%f`, field width `%5g`, C-style `for` loop |
| [`14_script.pl`] | Formatted Output — `printf` (Range) | Range operator `..`, `foreach` list iteration, loop variable aliasing |
| [`15_script.pl`] | Arrays, `$,` Separator & List Flattening | `$,` output field separator, scalar vs list context, automatic list flattening |
| [`16_script.pl`] | Array Manipulation — `push`, `unshift` | `push`, `unshift`, scalar context array size, `$,` output field separator |
| [`17_script.pl`] | Array Slices, `pop` & `shift` | Character range `'a'..'z'`, array slice `@array[LIST]`, `pop`, `shift`, sigil rules |
| [`18_script.pl`] | In-Place Modification — `splice` & `map` | `splice(OFFSET, LENGTH, REPLACEMENT)`, `map` with `uc`, universal array mutation |
| [`19_script.pl`] | List Transforms — `map`, `join`, `split` | `map { BLOCK }`, `$_` topic variable, `lc`, `ucfirst`, `join`, `split` |
| [`20_script.pl`] | Sorting — Numeric & String Comparisons | `sort { BLOCK }`, `<=>` spaceship, `cmp` string compare, `qw()`, ascending/descending |
| [`21_script.pl`] | STDIN Slurping & Random Selection | `srand`, `<STDIN>` list context, `chomp(@array)`, `rand`, `int(rand(@a))`, `scalar()` |
| [`22_script.pl`] | Reversing Lists & Scalar Context Trap | `reverse` in list vs scalar context, `<STDIN>` slurp, `$,` output separator |
| [`23_script.pl`] | Linear Search Algorithm | `rand`, `sprintf`, `push`, `foreach`, `last` early exit, `unless` modifier, O(N) |
| [`24_script.pl`] | Binary Search Algorithm | `sort { $a <=> $b }`, binary search `$start/$mid/$end`, `$#array`, O(log N) |
| [`25_script.pl`] | Hashes — Slices, `delete`, Sorting | `%hash`, fat comma `=>`, hash slices `@hash{LIST}`, `delete`, `keys`, `values`, sort by value |
| [`26_script.pl`] | Hash Lookup with `exists()` — O(1) | `exists()`, `each %hash` iterator, key uniqueness, O(N) vs O(log N) vs O(1) |
| [`27_script.pl`] | Subroutine Basics & Prototypes | `sub name(@) { }`, `@_` args, `my` lexical scoping, `return`, `..` range operator |
| [`28_script.pl`] | Context-Sensitive Subs — `wantarray` | `wantarray()`, `index(STR, SUBSTR)`, `$"` list separator, list vs scalar return |
| [`29_script.pl`] | Diamond Operator `<>` & `@ARGV` | `<>` diamond operator, `@ARGV`, `$ARGV`, `$.` line number, `-e` file test |
| [`30_script.pl`] | File Locking — `flock` (Shared Locks) | `use Fcntl ':flock'`, `flock(FH, LOCK_SH)`, `LOCK_UN`, `$$` PID, `sleep` |
| [`31_script.pl`] | File Locking — `flock` (Exclusive Locks) | `flock(FH, LOCK_EX)`, mutual exclusion, append mode `>>`, `$$` PID, `<>` |
| [`32_script.pl`] | File Pointers — `seek`, `tell` & Byte Size | `use Fcntl ':seek'`, `seek()`, `tell()`, `local *FILE` typeglob, `-s` file test |
| [`33_script.pl`] | Binary File Copying — `binmode` & `read` | `binmode(FH)`, `read(FH, $buf, $len)`, 1 KB chunked I/O, `$!` error variable |
| [`34_script.pl`] | Regex — Pattern Matching & Modifiers | `=~`, `m//`, alternation `(a\|b)`, dot `.`, `/s` single-line, `/m` multi-line, anchors |
| [`35_script.pl`] | Regex — Character Classes & Quantifiers | `[0-9]`, `\d`, `\w`, `\s`, quantifiers `?`/`*`/`+`/`{min,max}`, anchored validation |
| [`36_script.pl`] | Regex — Capture Groups, `s///` & `tr///` | `(...)` capture, `$1`/`$2`, `/g` global, `pos()`, `/i`, `s///` substitution, `/e` eval, `tr///` |
| [`37_script.pl`] | Regex — Anchors, Escaping & Backreferences | `^`/`$` anchors, `\\` escaped metacharacters, variable interpolation, `\1`/`\2` backrefs |
| [`38_script.pl`] | References — Scalar Refs & Dereferencing | `\` backslash operator, `$$ref` deref, multi-level refs, read-only trap, `eval { }` / `$@` |
| [`39_script.pl`] | References — Hash Refs & Subroutine Prototypes | Prototype `(\%$)`, `$$hashref{key}`, `$hashref->{key}` arrow, `%$hashref` whole deref |
| [`40_script.pl`] | Complex Data — Hashes of Arrays (HoA) | Anonymous `[...]` constructor, `my %p = @_` unpacking, `$ref->[0]` arrow deref |
| [`41_script.pl`] | Type Introspection with `ref()` | `ref()` returns `ARRAY`/`HASH`/`SCALAR`/`REF`/`CODE`/`Regexp`, `bless`, `qr//`, `sub {}` |
| [`42_script.pl`] | OOP — `bless()` & Class Creation | `bless($ref, $class)`, `package`, `$self->{key}`, `->` dispatch, `isa()`, `can()` |
| [`stats.pm`] | OOP Module — Statistics Calculator | `package stats`, `bless {}`, constructor idiom, instance data, running accumulators, `1;` |
| [`stats.pl`] | Driver — Interactive Statistics Calculator | `use lib '.'`, `use stats`, `%SIG{'INT'}` signal handler, `while(1)` input loop, heredoc |
| [`stats2.pm`] | Derived Class — Inheritance & `SUPER::` | `@ISA = ('stats')` inheritance, method overriding, `$this->SUPER::addvalue()`, min/max |
| [`stats2.pl`] | Driver — Extended Stats with Min/Max | `use stats2`, inherited constructors, polymorphic `addvalue()`, range calculation |

---

## 🚀 How to Run the Scripts

### 1. Grant Execution Permissions
Make scripts executable using `chmod`:
```bash
chmod +x "Shell Scripts"/*.sh
chmod +x "Shell Scripts"/*.awk
chmod +x "Perl Scripts"/*.pl
```

### 2. Executing Shell Scripts
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

### 3. Executing Perl Scripts
Run Perl scripts directly or via the `perl` interpreter:
```bash
# Example 1: Hello World & Perl basics
perl "Perl Scripts"/01_script.pl

# Example 2: String operators and type coercion
perl "Perl Scripts"/02_script.pl

# Example 3: Sorting arrays (numeric & string)
perl "Perl Scripts"/20_script.pl

# Example 4: Regular expressions — pattern matching
perl "Perl Scripts"/34_script.pl

# Example 5: OOP — Interactive statistics calculator (Ctrl+C for results)
cd "Perl Scripts" && perl stats.pl

# Example 6: Extended statistics with inheritance (Ctrl+C for results)
cd "Perl Scripts" && perl stats2.pl
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

## 🐪 Key Perl Best Practices & Gotchas

> [!TIP]
> 1. **Always Use `use strict` and `use warnings`**: These pragmas catch undeclared variables, typos, and common bugs at compile time. Every production Perl script should start with them.
> 2. **Prefer Lexical Variables (`my`) Over Global**: Use `my $var` to declare variables in the smallest possible scope. Avoid package globals that can be silently mutated by distant code.
> 3. **Use `chomp()`, Not `chop()`**: `chomp()` safely removes only the input record separator (`$/`, usually `\n`), while `chop()` blindly removes the last character regardless.
> 4. **Prefer 3-Argument `open` with Lexical Filehandles**: Write `open my $fh, '<', $file or die "Cannot open $file: $!"` instead of the legacy 2-argument `open(FILE, $file)`. This prevents injection attacks and provides automatic cleanup.
> 5. **Understand Scalar vs List Context**: Perl operators and functions behave differently depending on context. Use `scalar()` to force scalar context and `wantarray()` inside subroutines to detect calling context.
> 6. **Use the Arrow Operator for Dereferencing**: Prefer `$hashref->{key}` and `$arrayref->[0]` over the sigil-heavy `$$hashref{key}` and `$$arrayref[0]` for readability.

---

## 📚 Recommended Learning Resources

### 📖 Documentation & Guides
1. **[GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/)** — The official, authoritative specification of the GNU Bourne-Again SHell.
2. **[Greg's Wiki / Bash Guide](https://mywiki.wooledge.org/BashGuide)** — Widely regarded as the best pragmatic guide to modern Bash programming and common pitfalls.
3. **[Advanced Bash-Scripting Guide (TLDP)](https://tldp.org/LDP/abs/html/)** — An in-depth exploration of shell scripting with hundreds of practical examples.
4. **[Bash Hackers Wiki](https://wiki.bash-hackers.org/)** — Comprehensive breakdown of syntax, parameter expansions, and internal commands.
5. **[The GNU Awk User's Guide (Gawk)](https://www.gnu.org/software/gawk/manual/)** — The definitive guide to stream manipulation and reporting with AWK.

### 🐪 Perl Documentation & Guides
6. **[Official Perl Documentation (perldoc)](https://perldoc.perl.org/)** — The definitive reference for all Perl built-in functions, operators, and modules.
7. **[Learn Perl (learn.perl.org)](https://learn.perl.org/)** — The official learning portal with tutorials, books, and community resources for beginners.
8. **[Modern Perl (modernperlbooks.com)](http://modernperlbooks.com/)** — Free online book covering best practices, idioms, and modern Perl programming techniques.
9. **[Perl Regex Tutorial (perlretut)](https://perldoc.perl.org/perlretut)** — The official step-by-step guide to Perl's powerful regular expression engine.
10. **[Perl OOP Tutorial (perlootut)](https://perldoc.perl.org/perlootut)** — Official tutorial on object-oriented programming in Perl.

### 🛠️ Linters & Tools
- **[ShellCheck](https://www.shellcheck.net/)** — Essential static analysis tool that automatically flags syntax errors, anti-patterns, and portability bugs in shell scripts.
- **[Explainshell.com](https://explainshell.com/)** — Interactive tool to dissect complex shell command-line flags and pipes.
- **[Perl::Critic](https://metacpan.org/pod/Perl::Critic)** — Static analysis tool for Perl that enforces best practices based on *Perl Best Practices* by Damian Conway.
- **[Perl::Tidy](https://metacpan.org/pod/Perl::Tidy)** — Automatic code formatter and beautifier for Perl source code.

---

*Authored and curated as part of the HEP Training Perl & Shell Scripting Program.*
