#!/usr/bin/env bash
set -euo pipefail

DEST_ROOT="${1:-/mnt/backup}"     # 저장 위치 (외장디스크 등)
TS="$(date +%Y%m%d_%H%M%S)"
HOST="$(hostname -s)"
SNAP_DIR="$DEST_ROOT/${HOST}-backup-$TS"

mkdir -p "$SNAP_DIR"/{home,lists}

echo "[*] Backup to: $SNAP_DIR"

# 1. APT 패키지 목록
dpkg --get-selections > "$SNAP_DIR/lists/apt_selections.txt"
apt-cache policy > "$SNAP_DIR/lists/apt_repos.txt"
sudo bash -c 'cp -a /etc/apt/sources.list /etc/apt/sources.list.d \
  '"$SNAP_DIR/lists/"' 2>/dev/null || true'

# Snap / Flatpak (있으면)
command -v snap >/dev/null && snap list > "$SNAP_DIR/lists/snap_list.txt" || true
command -v flatpak >/dev/null && flatpak list --app --columns=all > "$SNAP_DIR/lists/flatpak_list.txt" || true

# pip / npm (있으면)
command -v pip >/dev/null && pip list --format=freeze > "$SNAP_DIR/lists/pip_user.txt" || true
command -v npm >/dev/null && npm list -g --depth=0 > "$SNAP_DIR/lists/npm_global.txt" || true

# 2. 홈 디렉토리 설정 백업 (rsync)
EXCLUDES=(
  "--exclude=.cache"
  "--exclude=.local/share/Trash"
  "--exclude=node_modules"
  "--exclude=.venv" "--exclude=venv"
  "--exclude=__pycache__"
  "--exclude=Downloads"
)
rsync -aHAX --info=progress2 "${EXCLUDES[@]}" ~ "$SNAP_DIR/home/"

echo "[*] Done: $SNAP_DIR"

