#!/bin/bash
#!/usr/bin/env bash
set -euo pipefail

DB="testdb"
BACKUP_DIR="$HOME/pg_backups"
mkdir -p "$BACKUP_DIR"
OUT="$BACKUP_DIR/${DB}_$(date +%Y%m%d_%H%M%S).sql.gz"

sudo -u postgres pg_dump -d "$DB" | gzip -9 > "$OUT"
echo "OK: $OUT"
