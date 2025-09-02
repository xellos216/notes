## 1. 백업 만드는 법

### 준비

1. 백업 스크립트(`backup.sh`) 작성
2. 실행 권한 부여

   ```bash
   chmod +x backup.sh
   ```

### 실행

```bash
./backup.sh <저장할_경로>
```

예시 (Downloads 안에 백업 생성):

```bash
./backup.sh ~/Downloads
```

### 결과

* `<저장할_경로>/<호스트명>-backup-YYYYmmdd_HHMMSS/` 폴더 생성
* 내부 구조:

  * `home/` : 홈 디렉토리 설정 백업
  * `lists/` : 설치된 패키지, Snap/Flatpak, pip, npm 목록

→ 이 폴더를 **구글드라이브, 외장디스크** 등에 복사해두면 안전.

---

## 2. 복구하는 법

### 1단계: 패키지 재설치

```bash
sudo cp -a <백업>/lists/sources.list* /etc/apt/ 2>/dev/null || true
sudo apt update
sudo dpkg --set-selections < <백업>/lists/apt_selections.txt
sudo apt-get -y dselect-upgrade
```

### 2단계: 홈 디렉토리 복원

```bash
rsync -aHAX --info=progress2 <백업>/home/ ~/
```

### 3단계: Dotfiles 빠른 복원 (선택)

```bash
tar -xzf <백업>/archives/dotfiles_min.tar.gz -C ~/
```

---

## 3. 백업 전략 요약

* **단기 보관**: 홈(`~/backup` 또는 `~/Downloads`)에 만들고 구글드라이브로 업로드
* **장기 보관**: 외장디스크(`/mnt/backup`)나 NAS에 저장
* **중요 원칙**: 반드시 **로컬+외부** 두 벌 이상 보관


