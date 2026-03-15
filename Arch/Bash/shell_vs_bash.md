# Shell Commands vs Bash Script Syntax

## 1. Shell Commands
Shell commands are executable programs or built-in commands in a shell environment.

### Key Points
- Work in any POSIX-compliant shell (`bash`, `sh`, `zsh`, etc.).
- Examples: `chmod`, `ls`, `cd`, `cp`, `mv`.
- Often located in system directories like `/bin`, `/usr/bin`.
- Invoked directly from the command line or inside scripts.

### Example
```bash
chmod 755 file.sh
ls -l
cd /home/user
```

## 2. Bash Script Syntax
Bash scripts are text files containing commands executed by the Bash interpreter.

### Key Points
- Start with a **shebang** (`#!/bin/bash`) to specify interpreter.
- Can include variables, loops, conditionals, functions.
- Execute by making the file executable (`chmod +x script.sh`) and running `./script.sh`.
- May contain both shell commands and Bash-specific syntax.

### Example
```bash
#!/bin/bash
# Bash script example

file="test.txt"

if [ -f "$file" ]; then
    echo "$file exists"
else
    echo "$file does not exist"
fi
```

## 3. Relationship Between the Two
- **Shell commands** can be part of a **Bash script**.
- Bash scripts extend basic shell commands with programming features (control flow, variables, etc.).
- Example: Using `chmod` inside a script to modify file permissions.

### Example
```bash
#!/bin/bash
chmod 755 "$1"
echo "Permissions changed for $1"
```

## 4. When to Use Which
- **Shell command**: Run quick, single actions directly in terminal.
- **Bash script**: Automate multiple commands, add logic, reuse tasks.

## 5. Notes
- Shell commands are available across many shells, but Bash syntax is specific to Bash (some may work in other shells with differences).
- Always verify your script's interpreter with the shebang if portability matters.
