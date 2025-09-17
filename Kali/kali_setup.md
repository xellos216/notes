# Kali Linux VM 설치 체크리스트 (virt-manager + Arch 호스트)

## 1. 설치 메뉴 선택
- **Graphical install** 선택 (GUI 기반 설치, 직관적).  
- `Install with speech synthesis`는 절대 선택하지 말 것 → 음성 출력 계속 따라옴.  

---

## 2. 설치 과정 단계별

### (1) 언어 / 로케일
- Language: English (추천, 도큐먼트 참고 쉽다)  
- Location: Korea  
- Keyboard: Korean (Hangul) or English (US) → 필요에 맞게.  

### (2) 네트워크
- Hostname: `kali` (또는 원하는 이름)  
- Domain name: 비워둬도 됨.  

### (3) 사용자 계정
- root 비밀번호 설정 가능 (요즘 Kali는 root 대신 일반 사용자 생성 → sudo 사용 권장).  
- `kali` 사용자 생성, 비밀번호 지정.  

### (4) 파티션
- Guided – use entire disk  
- 디스크: `kali-lab.qcow2` (virt-install에서 만든 가상 디스크)  
- 별도 요구 없으면 “All files in one partition” 선택 → 깔끔.  

### (5) 소프트웨어 선택
- **Desktop Environment**: XFCE (Kali 기본, 가볍고 VM에 적합)  
- **Tools**: "Kali Linux" 기본 선택 두면 됨.  
  (나중에 `sudo apt install kali-tools-top10` 같은 식으로 확장 가능)  

### (6) GRUB 부트로더
- Yes 선택.  
- 디스크: `/dev/vda` (qcow2 디스크)  

---

## 3. 설치 완료 후 필수 설정

### (1) 시스템 업데이트
```bash
sudo apt update && sudo apt full-upgrade -y
```

### (2) VM 통합 기능
- Spice agent (화면/클립보드 공유):
```bash
sudo apt install spice-vdagent
```

- 파일 공유 원하면:
```bash
sudo apt install spice-webdavd
```

### (3) 게스트 툴
- 기본 드라이버/비디오 드라이버 패키지:
```bash
sudo apt install xserver-xorg-video-qxl
```

---

## 4. virt-manager 설정 확인
- Display: **Spice**  
- Video: **QXL** (또는 Virtio)  
- Channel: **Spice agent** 추가 (클립보드 공유)  
- Memory/CPU: 최소 2 vCPU, 4GB RAM (권장 8GB)  

---

## 5. 배경화면, Kali tools
```bash
sudo apt install kali-wallpapers-all
sudo apt install kali-linux-large 
```

---

## 6. 한글입력기
```bash
sudo apt install -y ibus ibus-hangul im-config fonts-nanum

im-config -n ibus

cat >> ~/.xprofile <<'EOF'
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drx
EOF
```
