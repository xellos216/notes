# 🐧 Arch Linux 설치 & i3 커스터마이징 요약

## 1. 설치 준비
- Windows + Ubuntu 듀얼부팅 → **Windows + Arch**로 교체  
- Ventoy USB + `archlinux.iso` 준비  
- BIOS → UEFI 모드로 부팅  

---

## 2. 파티션 작업
- `lsblk -f` → 파티션 구조 확인  
- `sda1` → EFI (FAT32, 유지)  
- `sda3, sda4` → Windows (NTFS, 유지)  
- `sda5` → Ubuntu (ext4, 삭제 후 Arch용)  

```bash
fdisk /dev/sda   # Ubuntu 파티션 삭제 후 새로 생성
mkfs.ext4 -L arch-root /dev/sda5
mount /dev/sda5 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

---

## 3. 베이스 시스템 설치
```bash
pacstrap -K /mnt base linux linux-firmware networkmanager grub efibootmgr os-prober sudo neovim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

---

## 4. 기본 설정
```bash
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc

# Locale
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Hostname
echo "arch" > /etc/hostname
cat >> /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   arch.localdomain arch
EOF
```

---

## 5. 계정 & 서비스
```bash
passwd                   # root 비번
useradd -m -G wheel -s /bin/bash h
passwd h
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10-wheel
chmod 440 /etc/sudoers.d/10-wheel

systemctl enable NetworkManager
systemctl enable systemd-timesyncd
```

---

## 6. 부트로더 (GRUB)
```bash
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
```

※ `/boot`에 커널 없을 시:
```bash
pacman -S linux linux-firmware
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 7. Xorg + i3 (경량 GUI)
```bash
sudo pacman -S xorg-server xorg-xinit xterm i3 dmenu
```

`.xinitrc`:
```bash
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

fcitx5 &     # 한글 입력기
exec i3
```

---

## 8. 추가 프로그램
```bash
# 터미널
sudo pacman -S alacritty

# 한글 폰트 & 입력기
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji
sudo pacman -S fcitx5 fcitx5-im fcitx5-hangul fcitx5-configtool

# 캡처
sudo pacman -S flameshot

# 클립보드
sudo pacman -S clipmenu xclip

# 파일 매니저
sudo pacman -S ranger     # CLI
sudo pacman -S thunar     # GUI (옵션)
```

---

## 9. i3 config 주요 설정 (`~/.config/i3/config`)
```conf
# 터미널
bindsym $mod+Return exec alacritty

# 스크린샷
bindsym Print        exec flameshot gui -c
bindsym Shift+Print  exec flameshot full -c -p ~/Pictures

# 클립보드 매니저
exec --no-startup-id clipmenud
bindsym $mod+v exec clipmenu

# 한글 입력기
exec --no-startup-id fcitx5

# 파일 매니저 단축키 (예: Mod+e → Thunar)
bindsym $mod+e exec thunar

# 상태바
bar {
    status_command i3status
}
```

---

## 10. ranger 단축키 요약
- 이동: `h/l` (상위/하위), `j/k` (위/아래)  
- 선택: `space` (토글), `v` (전체 선택)  
- 복사/이동: `yy` (복사), `dd` (잘라내기), `pp` (붙여넣기)  
- 삭제: `dD`  
- 숨김파일 토글: `zh`  

---

✅ 최종 결과:  
- Windows + Arch 듀얼부팅 성공  
- CLI 주력 환경에 i3 최소 GUI, Firefox/Wireshark 실행 가능  
- 한글 폰트 + 입력기, 스크린샷, 클립보드, 파일매니저 세팅 완료  
