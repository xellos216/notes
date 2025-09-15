#!/bin/bash
set -euo pipefail
DB="testdb"
LATEST=$(ls -1t "$HOME/pg_backups/${DB}_"*.sql.gz | head -n1)

echo "Restoring from: $LATEST"
sudo -iu postgres psql -c "DROP DATABASE IF EXISTS ${DB};"
sudo -iu postgres psql -c "CREATE DATABASE ${DB};"
gunzip -c "$LATEST" | psql -U postgres -d "$DB"
echo "Done."
