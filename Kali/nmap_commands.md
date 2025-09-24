# nmap

## 목적

네트워크 호스트 탐지. 포트·서비스 탐지. OS/버전 지문. NSE 스크립트 기반 검사.

## 권한

일부 스캔(`-sS`, `-sU`)은 root 권한 필요. 허가 없는 대상 스캔 금지.

## 자주 쓰는 옵션 (한줄 설명)

* `-sn` : 호스트 발견(포트 스캔 없이 살아있는 호스트만).
* `-sS` : SYN 스캔. 빠르고 은닉성 높음. 루트 필요.
* `-sT` : TCP connect 스캔. 루트 불필요. 느리고 노출됨.
* `-sU` : UDP 스캔. 루트 권한 권장.
* `-sV` : 서비스/버전 탐지. 배너·프로브로 서비스 식별.
* `-p <포트|리스트|범위>` : 특정 포트(예: `-p 22,80,443` 또는 `-p 1-65535` 또는 `-p-` 전체).
* `-T<0..5>` : 타이밍 템플릿. `-T4`는 빠름.
* `-Pn` : ping 무시. 모든 호스트를 up으로 간주.
* `-A` : 공격적 스캔(OS, 버전, 스크립트, traceroute).
* `--script <name|category>` : NSE 스크립트 실행(예: `--script vuln`).
* `-oN <file>` : normal 출력 저장.
* `-oG <file>` : grepable 출력 저장(.gnmap 스타일).
* `-oX <file>` : XML 출력 저장.
* `-oA <basename>` : `.nmap`, `.gnmap`, `.xml` 모두 생성.

## CIDR 표기

* `192.168.1.0/24` : 프리픽스 길이 24비트. 서브넷 `192.168.1.0`\~`192.168.1.255`. 일반 호스트 `.1`\~`.254`.

## 예제 명령

* 전체 포트·버전·빠른 스캔(루트 필요)

```bash
sudo nmap -sS -sV -p- -T4 -oA hosts 192.168.1.0/24
```

* 루트 없이 동일한 목표(느림)

```bash
nmap -sT -sV -p- -T4 -oA hosts 192.168.1.0/24
```

* 같은 서브넷의 살아있는 호스트만

```bash
nmap -sn 192.168.1.0/24 -oG live.gnmap
```

* 특정 호스트의 기본 포트에서 버전 탐지

```bash
nmap -sV -p 1-1024 192.168.0.232 -oN svc.txt
```

* NSE 취약점 스캔(예)

```bash
sudo nmap --script vuln -sV 10.0.0.5 -oN vuln_scan.txt
```

## 출력 후 처리

* `.gnmap`에서 IP,포트 추출

```bash
perl -nle 'print "$1,$2" if /^Host: (\S+).*Ports: (.*)$/' hosts.gnmap > result.csv
```

* `-oA basename`로 생성된 `basename.gnmap` 사용 권장.

## 권장 워크플로우

1. 로컬 IP/CIDR 확인:
   `ip -o -f inet addr show dev <iface> | awk '{print $4}'`
2. 게이트웨이 확인:
   `ip route | grep default`
3. 호스트 발견:
   `nmap -sn <CIDR>`
4. 관심 호스트에 대해 포트/서비스 조사:
   `nmap -sV -p 22,80,443 <IP>`
5. 결과 저장 후 후처리 `.gnmap` → CSV 등

## 성능·안전 팁

* `-T4`는 빠르다. 네트워크·장비에 부담을 줄 수 있음.
* 대규모 스캔은 ISP·장비에 영향. `--min-rate`나 `--max-retries`로 조절.
* `setcap`으로 nmap에 권한 부여 가능(관리자 권한 필요):
  `sudo setcap cap_net_raw,cap_net_admin+eip "$(which nmap)"`
  단 보안정책과 파일시스템 제약 확인할 것.

## 주의사항

* 소유·허가된 네트워크에서만 스캔.
* 일부 옵션은 관리자 권한 필요.
* 스캔 로그는 증거가 될 수 있음. 기록 관리에 유의.
