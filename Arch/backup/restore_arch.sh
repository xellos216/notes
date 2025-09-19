#!/usr/bin/env bash
set -Eeuo pipefail

# 사용법: ./restore_arch.sh /path/to/arch-backup-YYYYMMDD-HHMMSS
BKDIR="${1:-}"
[[ -z "${BKDIR}" ]] && { echo "backup directory required"; exit 1; }

PKG_MAIN="${BKDIR}/pkglist-pacman.txt"
PKG_AUR="${BKDIR}/pkglist-aur.txt"
DOTS="${BKDIR}/dotfiles"
ETC_DIR="${BKDIR}/etc"
SYS_SVC="${BKDIR}/enabled-services-system.txt"
USR_SVC="${BKDIR}/enabled-services-user.txt"
USER_CRON="${BKDIR}/user-crontab.txt"

echo "[0] ensure yay"
if ! command -v yay >/dev/null 2>&1; then
  sudo pacman -Syu --needed base-devel git
  tmpdir="$(mktemp -d)"; trap 'rm -rf "$tmpdir"' EXIT
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  (cd "$tmpdir/yay" && makepkg -si --noconfirm)
fi

echo "[1] restore pacman packages"
if [[ -f "${PKG_MAIN}" ]]; then
  sudo pacman -Syu --needed - < "${PKG_MAIN}"
fi

echo "[2] restore AUR packages (yay)"
if [[ -f "${PKG_AUR}" ]]; then
  yay -S --needed - < "${PKG_AUR}"
fi

echo "[3] restore dotfiles"
if [[ -d "${DOTS}" ]]; then
  rsync -a "${DOTS}/" "${HOME}/"
fi
# 폰트 캐시 갱신
if [[ -d "${HOME}/.local/share/fonts" ]]; then
  fc-cache -f || true
fi

echo "[4] review and merge /etc (safe mode)"
if [[ -d "${ETC_DIR}" ]]; then
  # 기존 파일은 보존. 없는 것만 채움.
  sudo rsync -a --ignore-existing "${ETC_DIR}/" /etc/
  echo "diff preview: sudo diff -ruN '${ETC_DIR}' /etc"
fi

echo "[5] re-enable services"
if [[ -f "${SYS_SVC}" ]]; then
  while read -r unit; do
    [[ -n "$unit" ]] && sudo systemctl enable "$unit" || true
  done < "${SYS_SVC}"
fi
if [[ -f "${USR_SVC}" ]]; then
  while read -r unit; do
    [[ -n "$unit" ]] && systemctl --user enable "$unit" || true
  done < "${USR_SVC}"
fi

echo "[6] restore crontab"
[[ -s "${USER_CRON}" ]] && crontab "${USER_CRON}" || true

echo "[7] recommend reboot after review"
echo "restore staged. check diffs, then reboot."
