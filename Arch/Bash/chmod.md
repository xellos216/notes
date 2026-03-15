# chmod Permission Guide

## 1. Overview
`chmod` stands for **change mode**. It is used to change the file or directory permissions in Unix/Linux systems.

Permissions:
- **r** (read) = 4
- **w** (write) = 2
- **x** (execute) = 1

## 2. Symbolic Mode (기호 방식)
Symbolic mode uses letters to indicate *who* gets permissions and *which* permissions are modified.

### Who
- **u** = user (owner)
- **g** = group
- **o** = others
- **a** = all (user + group + others)

### Operators
- **+** = add permission
- **-** = remove permission
- **=** = set exact permission

### Example
```bash
chmod u+x file.sh   # Add execute permission for user
chmod g-w file.txt  # Remove write permission for group
chmod a=r file.txt  # Set read-only for everyone
```

## 3. Numeric Mode (숫자 방식)
Numeric mode uses a three-digit octal number to represent permissions.

### Calculation
| Permission | Value |
|------------|-------|
| r (read)   | 4     |
| w (write)  | 2     |
| x (execute)| 1     |

Each digit = sum of values for user, group, others.

### Example Table
| Mode | User | Group | Others | Meaning              |
|------|------|-------|--------|----------------------|
| 755  | rwx  | r-x   | r-x    | Owner can read/write/execute; others can read/execute |
| 644  | rw-  | r--   | r--    | Owner can read/write; others can read only |
| 700  | rwx  | ---   | ---    | Owner full control; no access for others |
| 777  | rwx  | rwx   | rwx    | Everyone full control |

### Example Commands
```bash
chmod 755 file.sh    # User: rwx, Group: r-x, Others: r-x
chmod 644 file.txt   # User: rw-, Group: r--, Others: r--
chmod 700 private.sh # User only full control
```

## 4. Notes
- Use **symbolic mode** when adding/removing specific permissions without affecting others.
- Use **numeric mode** for setting complete permission sets quickly.
- Always check permissions using:
```bash
ls -l file.sh
```
