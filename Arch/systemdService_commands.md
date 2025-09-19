# systemd Service 사용법

## 1. 개념

* **systemd**: 현대 리눅스 배포판에서 쓰이는 init 시스템.
* **service unit**: systemd가 관리하는 실행 단위. 특정 프로세스(데몬/스크립트)를 정의하고 systemctl로 제어할 수 있다.
* 장점: 상태 확인, 자동 재시작, 의존성 관리 가능. cron과 달리 **상태 기반 관리**에 특화.

---

## 2. 서비스 종류

* **시스템 단위**: `/etc/systemd/system/`, `/usr/lib/systemd/system/`
  → root 권한 필요, 전체 시스템에 적용.
* **사용자 단위**: `~/.config/systemd/user/`
  → 개인 계정 범위에서 적용, root 불필요.

---

## 3. 서비스 유닛 파일 구조

```ini
[Unit]
Description=간단한 설명
After=network.target   # 이 서비스가 시작되기 전에 필요한 조건

[Service]
Type=simple            # 단순히 실행 (기본값)
# Type=oneshot         # 실행 후 바로 종료 (스크립트 실행용)
ExecStart=/path/to/script.sh
Restart=on-failure     # 실패 시 자동 재시작

[Install]
WantedBy=multi-user.target  # 시스템 부팅 시 활성화 (시스템 단위 예시)
WantedBy=default.target     # 사용자 로그인 시 활성화 (사용자 단위 예시)
```

---

## 4. 주요 명령어

### 시스템 단위

```bash
sudo systemctl start service_name
sudo systemctl stop service_name
sudo systemctl restart service_name
sudo systemctl status service_name
sudo systemctl enable service_name   # 부팅 시 자동 실행
sudo systemctl disable service_name
```

### 사용자 단위

```bash
systemctl --user daemon-reload        # 설정 반영
systemctl --user start hello.service
systemctl --user stop hello.service
systemctl --user status hello.service
systemctl --user enable hello.service # 로그인 시 자동 실행
```

---

## 5. 예시

### 단발성 스크립트 실행 (oneshot)

`~/.config/systemd/user/hello.service`

```ini
[Unit]
Description=hello test

[Service]
Type=oneshot
ExecStart=/home/h/bin/hello.sh

[Install]
WantedBy=default.target
```

실행:

```bash
systemctl --user daemon-reload
systemctl --user start hello.service
```

→ `/home/h/bin/hello.sh`가 한 번 실행되고 끝남.

---

### 지속 실행 데몬 (simple)

`/etc/systemd/system/myapp.service`

```ini
[Unit]
Description=My Custom App
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python /opt/myapp/server.py
Restart=always

[Install]
WantedBy=multi-user.target
```

실행:

```bash
sudo systemctl enable --now myapp.service
```

→ 시스템 부팅 시 자동 실행, 죽으면 다시 살아남.

---

## 6. 로그 확인

```bash
journalctl -u hello.service --user   # 사용자 단위
journalctl -u myapp.service          # 시스템 단위
```

---

## 7. 비교 (cron vs systemd service)

* cron: 특정 시각/주기 실행 → 예약 작업에 적합
* systemd service: 프로세스 실행·상태 관리 → 장시간 실행 서비스에 적합
