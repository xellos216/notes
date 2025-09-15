## 1. cron (작업 스케줄링)

* **설치 및 실행**

  ```bash
  sudo pacman -S cronie
  sudo systemctl enable --now cronie
  systemctl status cronie
  ```

  → cron 서비스(crond)가 systemd에 의해 실행.

* **작업 등록**

  ```bash
  crontab -e
  ```

  편집기 지정 필요 (`export VISUAL=nano`).

* **예시 작업**

  ```cron
  */1 * * * * echo "cron test: $(date)" >> ~/cron_test.log
  ```

  → 1분마다 현재 시간을 `cron_test.log`에 기록.

* **확인**

  ```bash
  tail -f ~/cron_test.log
  ```

  → 로그가 주기적으로 늘어나면 정상.

---

## 2. tmux (터미널 멀티플렉서)

* **설치 및 실행**

  ```bash
  sudo pacman -S tmux
  tmux new -s test
  ```

  → `test`라는 세션 생성. 상태줄에 세션/창 정보 표시.

* **세션 분리/재접속**

  * 분리: `Ctrl+a d` (네 환경에서 prefix가 `Ctrl+a`)
  * 세션 확인: `tmux ls`
  * 접속: `tmux attach -t test`

* **창(window) 관리**

  * 새 창: `Ctrl+a c`
  * 이동: `Ctrl+a n` (다음), `Ctrl+a p` (이전)
  * 상태줄에 `1:zsh 2:zsh ...` 형태로 표시

* **분할(pane)**

  * 가로: `Ctrl+a %`
  * 세로: `Ctrl+a "`
  * 이동: `Ctrl+a 방향키`

---

## 3. ssh (원격 접속)

* **설치 및 실행**

  ```bash
  sudo pacman -S openssh
  sudo systemctl enable --now sshd
  systemctl status sshd
  ```

  → `sshd` 데몬이 포트 22에서 대기.

* **IP 확인**

  ```bash
  ip addr show
  ```

  → 유효한 네트워크 인터페이스의 `inet` 값 확인 (예: `211.219.36.142`).

* **자기 자신 접속 테스트**

  ```bash
  ssh h@127.0.0.1
  ```

  → 첫 접속 시 fingerprint 경고 → `yes` → 비밀번호 입력.

* **보안 참고**

  * 포트 열려 있고, SSH 서버 켜져 있고, 계정 인증 정보를 알아야만 접속 가능.
  * 실제 서버 운영 시에는 **비밀번호 대신 키 인증**을 권장.

---

## 4. pacman (패키지 관리 심화)

* **검색**

  ```bash
  pacman -Ss tmux
  ```

  → 저장소에서 관련 패키지 검색.

* **정보 확인**

  ```bash
  pacman -Qi tmux
  ```

  → 설치된 패키지의 버전, 빌드 날짜, 의존성, 설치 이유 등 출력.

* **삭제**

  ```bash
  sudo pacman -Rns byobu
  ```

  → 패키지 + 설정파일 + 불필요한 의존성까지 제거.

---

## 5. systemd (서비스 관리)

* **시작**

  ```bash
  sudo systemctl start sshd
  ```

* **중지**

  ```bash
  sudo systemctl stop sshd
  ```

* **상태 확인**

  ```bash
  systemctl status sshd
  ```

  → `active (running)` / `inactive (dead)` 로 상태 확인 가능.

* **특징**
  systemd는 서비스 프로세스를 관리하며, 부팅 시 자동 실행 여부(`enable/disable`)도 제어 가능.

---

### 요약

* cron → 자동 작업 실행
* tmux → 세션/창/분할로 다중 작업
* ssh → 원격 접속 및 보안 고려
* pacman → 설치/검색/삭제 심화
* systemd → 서비스 제어와 상태 관리

