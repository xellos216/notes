# 데이터베이스 & 자동화

## 1. PostgreSQL 설치 및 기본 사용

* **PostgreSQL**: 오픈소스 관계형 데이터베이스.

**설치/초기화**

```bash
sudo pacman -S postgresql
sudo -iu postgres initdb --locale=en_US.UTF-8 -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
```

**기본 조작**

```sql
CREATE DATABASE testdb;
\c testdb
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL
);
INSERT INTO users (name,email) VALUES ('Alice','alice@example.com');
SELECT * FROM users;
```

---

## 2. 백업/복원 자동화

* **pg\_dump**: DB 백업.
* **gzip**: 압축.
* **systemd timer**: 주기 실행.

**백업 스크립트 (`~/bin/pg_backup.sh`)**

```bash
#!/usr/bin/env bash
set -euo pipefail
DB="testdb"
BACKUP_DIR="$HOME/pg_backups"
mkdir -p "$BACKUP_DIR"
OUT="$BACKUP_DIR/${DB}_$(date +%Y%m%d_%H%M%S).sql.gz"

sudo -u postgres pg_dump -d "$DB" | gzip -9 > "$OUT"
echo "OK: $OUT"
```

**복원 스크립트 (`~/bin/pg_restore_latest.sh`)**

```bash
#!/usr/bin/env bash
set -euo pipefail
DB="testdb"
LATEST=$(ls -1t "$HOME/pg_backups/${DB}_"*.sql.gz | head -n1)

echo "Restoring from: $LATEST"
sudo -iu postgres psql -c "DROP DATABASE IF EXISTS ${DB};"
sudo -iu postgres psql -c "CREATE DATABASE ${DB};"
gunzip -c "$LATEST" | psql -U postgres -d "$DB"
echo "Done."
```
