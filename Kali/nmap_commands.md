# nmap 

* 용도: 네트워크 호스트 탐지, 포트·서비스 탐지, OS/버전 지문, 스크립트 기반 취약점 검사
* 권한: 일부 스캔(`-sS`, `-sU`)는 root 권한 필요, 무분별한 스캔은 타인 네트워크에서 금지

## 자주 쓰는 옵션

* `-sn`
  호스트 발견(ping 스캔). 포트 스캔 없이 살아있는 호스트만 확인
* `-sV`
  서비스/버전 탐지(포트 열림 시 배너·응답으로 서비스 추정)
* `-p <포트>`
  특정 포트 또는 리스트 지정. (`-p 22,80,443` 또는 `-p 1-1024`)
* `-T<0..5>`
  타이밍 템플릿. `-T4` 빠름, `-T1` 보수적
* `-oG <file>`
  grepable 출력(간단 요약 저장)
* `-oN <file>`
  normal 출력 파일 저장
* `-A`
  공격적 스캔 (OS, 버전, 스크립트, traceroute 등 통합)
* `-Pn`
  ping 무시. 모든 호스트를 up으로 가정하고 바로 포트 스캔
* `--script <name>`
  NSE 스크립트 실행 (ex: `--script vuln`)

## 사용한 명령어

> `postscan.py` 최종 코드 참조:&#x20;

* `ip -o -f inet addr show dev <iface> | awk '{print $4}'`
  인터페이스의 IPv4 주소(CIDR) 확인. 네트워크 범위(CIDR) 계산용
  예: `192.168.0.104/24` → 네트워크 `192.168.0.0/24`

* `ip route | grep default`
  기본 게이트웨이(라우터) 확인. 라우터 IP로 서비스 스캔할 때 사용

* `nmap -sn 192.168.0.0/24` **(자주 사용)**
  같은 서브넷의 살아있는 호스트 목록만 빠르게 얻음

* `nmap -sV -p 1-1024 192.168.0.232`
  특정 호스트의 지정 포트 범위에서 서비스 버전 탐지

* `nmap -T3 --min-rate 50 -p 22,80,443 211.219.36.0/24 -oG scan.gnmap`
  부하 조절·출력 저장을 함께 한 예시

* `tmux new -s pentest` / `Ctrl+a %` / `Ctrl+a "` / `Ctrl+a d` / `tmux attach -t pentest`
  tmux 세션 생성·수직/수평 분할·detach(분리)·재접속
  **자주 사용**: 여러 툴(스캔·크래킹·로그) 동시 실행 관리

* `nvim postscan.py`
  스크립트 편집

* `python3 postscan.py -t 192.168.0.232 -p 22,80,443 --timeout 0.5 --workers 50 --out result.csv` **(자주 사용)**
  직접 구현한 병렬 포트 스캐너 실행. 결과를 `result.csv`로 저장

* `jobs` / `fg %1` / `bg %1` / `kill %1`
  쉘 작업 제어. 백그라운드/중단·재개·종료 관리

* `ip neigh show` / `arp -n`
  같은 L2(같은 물리 LAN) 장치 ARP 테이블로 빠르게 확인

* `nmcli device wifi list` / `nmcli device wifi connect "SSID" password "PW"`
  NetworkManager CLI로 무선 AP 목록·연결. (무선 설정에 사용)

* `sudo pacman -S <packages>`
  Arch에서 패키지 설치(예: `nmap`, `wireshark-qt`, `tmux`, `neovim`).

* `sudo systemctl enable --now NetworkManager`
  NetworkManager 서비스 활성화·시작

* `sudo gpasswd -a $USER wireshark` / `newgrp wireshark`
  Wireshark 캡처 권한을 사용자에게 추가

* `traceroute <ip>`
  대상까지의 경로 확인(네트워크 홉/지연 분석)

## 사용 빈도 높은 명령어

* **`nmap`**
  네트워크/서비스 조사 기본 도구, `-sn`으로 호스트 목록 확인 → `-sV`로 서비스 조사. 권한·부하 주의

* **`tmux`**
  실습·스캔·분석을 동시에 관리하는 핵심, 세션 분리로 장시간 작업 유지 가능

* **`python3 postscan.py ...`**
  학습용으로 직접 만든 스캐너, 타임아웃·동시성·배너·서비스 추정 등을 실험할 때 사용

* **`ip` / `ip route`**
  네트워크 정보(할당 IP, CIDR, 기본 게이트웨이) 확인의 출발점, 스캔 대상 범위를 결정할 때 필수

## 권장 워크플로우 (단계별)

1. `ip -o -f inet addr show dev <iface>` 로 내 IP/CIDR 확인
2. `ip route | grep default` 로 게이트웨이 확인
3. `nmap -sn <CIDR>` 로 같은 LAN의 살아있는 장치 조회
4. 관심 호스트에 대해 `nmap -sV -p 22,80,443 <IP>` 또는 `python3 postscan.py` 로 포트/배너 확인
5. tmux에서 위 작업들을 분할 창으로 병렬 실행·기록 저장

## 주의사항(간단)

* 반드시 소유·허가된 네트워크에서만 스캔
* 대규모 병렬 스캔은 라우터·ISP에 부담, `--workers` 및 `-T` 조절
* 일부 nmap 옵션은 관리자 권한 필요

