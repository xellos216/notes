#!/usr/bin/env bash
set -Eeuo pipefail

# ===== Config =====
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${HOME}/arch-backup-${STAMP}"
DOT_DIRS=(
  "${HOME}/.config/i3"
  "${HOME}/.config/i3status"
  "${HOME}/.config/polybar"
  "${HOME}/.config/picom"
  "${HOME}/.config/rofi"
  "${HOME}/.config/dunst"
  "${HOME}/.config/alacritty"
  "${HOME}/.config/kitty"
  "${HOME}/.config/nvim"
  "${HOME}/.config/tmux"
  "${HOME}/.config/zsh"
)
DOT_FILES=(
  "${HOME}/.zshrc"
  "${HOME}/.bashrc"
  "${HOME}/.Xresources"
  "${HOME}/.xinitrc"
)
WALLPAPERS_DIR="${HOME}/Pictures/Wallpapers"  # 있으면 백업
FONTS_DIR="${HOME}/.local/share/fonts"        # 있으면 백업
# ==================

mkdir -p "${BACKUP_DIR}"

echo "[1/7] package lists"
pacman -Qqen > "${BACKUP_DIR}/pkglist-pacman.txt"
pacman -Qqem > "${BACKUP_DIR}/pkglist-aur.txt" || true

echo "[2/7] enabled system services"
systemctl list-unit-files --state=enabled --no-legend | awk '{print $1}' \
  > "${BACKUP_DIR}/enabled-services-system.txt" || true
systemctl --user list-unit-files --state=enabled --no-legend | awk '{print $1}' \
  > "${BACKUP_DIR}/enabled-services-user.txt" || true

echo "[3/7] user crontab"
crontab -l > "${BACKUP_DIR}/user-crontab.txt" || true

echo "[4/7] dotfiles"
mkdir -p "${BACKUP_DIR}/dotfiles"
for p in "${DOT_DIRS[@]}"; do
  [[ -d "$p" ]] && rsync -a "$p" "${BACKUP_DIR}/dotfiles/"
done
for f in "${DOT_FILES[@]}"; do
  [[ -f "$f" ]] && rsync -a "$f" "${BACKUP_DIR}/dotfiles/"
done
[[ -d "${WALLPAPERS_DIR}" ]] && rsync -a "${WALLPAPERS_DIR}" "${BACKUP_DIR}/dotfiles/"
[[ -d "${FONTS_DIR}" ]] && rsync -a "${FONTS_DIR}" "${BACKUP_DIR}/dotfiles/"

echo "[5/7] /etc snapshot (root)"
sudo rsync -aAX --delete --numeric-ids /etc "${BACKUP_DIR}/etc"

echo "[6/7] package explicit list (optional)"
pacman -Qqe > "${BACKUP_DIR}/pkglist-all-explicit.txt"

echo "[7/7] archive"
tar -C "${HOME}" -czf "${BACKUP_DIR}.tar.gz" "$(basename "${BACKUP_DIR}")"
sha256sum "${BACKUP_DIR}.tar.gz" > "${BACKUP_DIR}.tar.gz.sha256"

echo "backup done -> ${BACKUP_DIR}  and ${BACKUP_DIR}.tar.gz"
