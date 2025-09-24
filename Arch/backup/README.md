## 1. 패키지 백업

```bash
# 공식 저장소 패키지 목록
pacman -Qqen > pkglist-pacman.txt

# AUR 패키지 목록
pacman -Qqem > pkglist-aur.txt
```

---

## 2. 커스터마이징 세팅 백업

일반적으로 i3 + CLI 환경에서 중요한 건 `$HOME`의 dotfiles.

```bash
mkdir -p ~/dotfiles-backup

cp -r ~/.config/i3 ~/.config/nvim ~/.zshrc ~/.Xresources ~/dotfiles-backup/ 2>/dev/null
```

필요하다면 `/etc`도 스냅샷:

```bash
sudo rsync -aAXv /etc ~/dotfiles-backup/etc
```

---

## 3. 통합 백업 스크립트 (예시)

`backup-arch.sh`:

```bash
#!/bin/bash
BACKUP_DIR=~/arch-backup-$(date +%Y%m%d)
mkdir -p "$BACKUP_DIR"

# pacman & AUR 목록
pacman -Qqen > "$BACKUP_DIR/pkglist-pacman.txt"
pacman -Qqem > "$BACKUP_DIR/pkglist-aur.txt"

# dotfiles
cp -r ~/.config/i3 ~/.config/nvim ~/.zshrc ~/.Xresources "$BACKUP_DIR/" 2>/dev/null

# etc
sudo rsync -aAXv /etc "$BACKUP_DIR/etc"
```

---

## 4. 복원 절차

1. 기본 Arch 설치 후 `yay` 다시 설치.

   ```bash
   sudo pacman -S --needed base-devel git
   git clone https://aur.archlinux.org/yay.git
   cd yay && makepkg -si
   ```

2. 패키지 복원:

   ```bash
   sudo pacman -S --needed - < pkglist-pacman.txt
   yay -S --needed - < pkglist-aur.txt
   ```

3. dotfiles 복원:

   ```bash
   cp -r ~/arch-backup-20250919/i3 ~/.config/
   cp -r ~/arch-backup-20250919/nvim ~/.config/
   cp ~/arch-backup-20250919/.zshrc ~/
   cp ~/arch-backup-20250919/.Xresources ~/
   ```

4. `/etc` 비교·병합 (주의: 무조건 덮어쓰지 말고 diff 확인):

   ```bash
   diff -ruN ~/arch-backup-20250919/etc /etc
   ```

---

👉 정리:

* **백업**: `pacman -Qqen`, `pacman -Qqem`, dotfiles 복사
* **복원**: `pacman -S`, `yay -S`, dotfiles 복원

