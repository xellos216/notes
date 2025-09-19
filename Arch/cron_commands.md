# cron 사용법

## 1. 개념

* **cron**: 리눅스에서 **정해진 시간·주기**에 작업을 자동 실행하는 스케줄러.
* **crontab**: 사용자가 등록한 작업 목록을 담는 테이블.

주로 로그 백업, 임시파일 삭제, 주기적 업데이트 같은 자동화를 위해 사용된다.

---

## 2. cron 서비스 관리 (Arch Linux 기준)

```bash
sudo systemctl enable --now cronie   # cron 서비스 활성화 및 즉시 시작
systemctl status cronie              # 상태 확인
journalctl -u cronie --since "1 hour ago"   # 최근 한 시간 로그 보기
```

---

## 3. crontab 명령어

```bash
crontab -e     # 현재 사용자 crontab 편집
crontab -l     # 현재 등록된 crontab 확인
crontab -r     # 현재 사용자 crontab 전체 삭제
```

---

## 4. crontab 문법

```
분 시 일 월 요일 명령어
```

* **분**: 0–59
* **시**: 0–23
* **일**: 1–31
* **월**: 1–12
* **요일**: 0–7 (0과 7은 일요일)

### 특수문자

* `*` → 모든 값
* `,` → 여러 값 지정 (예: `1,15`)
* `-` → 범위 지정 (예: `1-5`)
* `/` → 주기 지정 (예: `*/10` = 10분마다)

---

## 5. 예시

### 매일 밤 11시에 로그 백업

```cron
0 23 * * * tar -czf /home/h/backup/logs-$(date +\%Y\%m\%d).tar.gz -C /home/h logs >> /home/h/cron_job.log 2>&1
```

### 매주 일요일 새벽 3시에 시스템 업데이트

```cron
0 3 * * 0 sudo pacman -Syu --noconfirm >> /home/h/update.log 2>&1
```

### 매일 10분마다 `/tmp` 정리

```cron
*/10 * * * * rm -rf /tmp/*
```

### 매달 1일 00:00에 데이터베이스 덤프

```cron
0 0 1 * * pg_dump mydb > /home/h/db-backup/db-$(date +\%Y\%m).sql
```

---

## 6. cron 로그 확인

* 실행 결과 자체는 **명령어에서 리다이렉션(>>)로 파일에 남겨야** 확인 가능.
* cron 서비스 자체 로그는 `journalctl -u cronie`로 확인.
