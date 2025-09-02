## 1단계. 리눅스 CLI 기본기

* **파일/디렉토리 조작**: `ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `mkdir`, `rmdir`
* **파일 내용 확인**: `cat`, `less`, `head`, `tail`
* **검색/처리**: `grep`, `find`, `cut`, `sort`, `wc`
* **압축/해제**: `tar`, `gzip`, `unzip`
* **권한 관리**: `chmod`, `chown`
* **시스템 상태 확인**: `ps`, `top`, `df`, `du`, `free`, `uptime`

검증 방법: 연습용 디렉토리 만들어서 파일 생성 → 복사/검색/삭제 자동화.

---

## 2단계. Bash 스크립팅 기초

* **셸 스크립트 실행**: `#!/bin/bash`, 실행 권한 주고 `./script.sh`
* **변수/입출력**: `name="user"`, `echo $name`, `read var`
* **조건문**: `if [ ]; then ... fi`
* **반복문**: `for`, `while`
* **함수 정의**: `myfunc() { ... }`
* **명령어 조합**: 파이프(`|`), 명령어 치환(`$( )`)

검증 방법:

* 구구단 출력 스크립트
* 디렉토리 내 파일 개수 세는 스크립트
* 로그에서 특정 단어 필터링

---

## 3단계. 프로그래밍 언어 실습 (Ubuntu에서 바로)

* **Python**: 기본 탑재 → 자료형, 제어문, 함수, 파일 입출력, 패키지(`pip`)
* **C**: `gcc hello.c -o hello` → 리눅스 저수준 학습용
* **Git**: `git init`, `git add`, `git commit`, `git log`, `git remote`, `git push`
* (선택) Node.js, Java 등도 apt/pacman으로 설치 가능

---

## 4단계. 자동화/실전 활용

* **크론(cron)**: 일정 실행. `crontab -e` → 백업 스크립트 자동화
* **tmux**: 세션 분리/멀티태스킹
* **ssh**: 원격 접속
* **패키지 관리 심화**: `apt search`, `apt show`, `apt autoremove`
* **시스템 서비스 관리**: `systemctl start/stop/status`

검증 방법:

* 매일 특정 디렉토리 자동 백업 스크립트 작성
* 서버에 ssh 접속 후 tmux로 프로그램 실행 유지

---

## 5단계. 확장 학습

* **Docker**: 컨테이너 기반 환경 실습
* **간단한 웹 서버**: Python Flask, Node.js Express 실행
* **DB 설치**: PostgreSQL, MySQL → Bash로 데이터 백업/복원 자동화


