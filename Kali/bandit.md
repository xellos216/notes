# Bandit Lv0–Lv5

## 개요

실습 범위: Bandit Level0 → Level5
목적: 파일·권한·텍스트·바이너리·네트워크 기초 숙달.
사용 환경: Kali VM (호스트는 격리된 NAT 권장).

---

## SSH 접속

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

* 언제: 실습 서버 접속할 때.
* 왜: 레벨별 계정으로 로그인해야 문제 진행 가능.
* 어떻게: 첫 접속 시 호스트 키 확정(yes). 레벨별 비밀번호로 다음 사용자로 ssh 전환.

---

## 파일 탐색 · 출력

### `pwd`

* 언제: 현재 작업 디렉터리 확인 시.
* 왜: 상대경로 혼동 방지.
* 예: SSH 접속 후 홈 디렉터리 확인.

### `ls`, `ls -la`

* 언제: 디렉터리 내용·숨김파일 확인.
* 왜: 권한·소유자·파일명 파악.
* 예: `ls -la ~`

### `ls -lab`

* 언제: 파일명에 제어문자·특수공백 의심될 때.
* 왜: `-b`가 비가시문자를 이스케이프로 보여줌.
* 예: `ls -lab`

### `cat <파일>`

* 언제: 텍스트 내용 빠르게 확인할 때.
* 왜: 단일라인 비밀번호 확인에 가장 간단.
* 주의: `cat -`는 stdin. 파일명이 `-`로 시작하면 `cat ./-name` 또는 `cat -- -name`.

### `less`, `more`

* 언제: 긴 파일 페이지 단위로 볼 때.
* 왜: 검색·스크롤 편리.

### `stat <파일>`

* 언제: 메타정보(크기·inode·타임스탬프) 확인.
* 왜: 누가 언제 수정했는지, inode로 접근 필요시 사용.

---

## 파일명·경로 문제 해결

### `./파일`, 따옴표, 이스케이프

* 언제: 파일명이 `-` 시작하거나 공백 포함될 때.
* 어떻게:

  ```bash
  cat ./--spaces\ in\ this\ filename--
  cat -- "./-file"
  cat "name with spaces"
  ```

### inode 접근

* 언제: 파일명이 읽기 불가능하거나 특수문자 포함 시.
* 어떻게:

  ```bash
  ls -li
  find . -maxdepth 1 -inum <INO> -exec cat {} \;
  ```

---

## 텍스트 검색·가공

### `grep -R "패턴" .`

* 언제: 트리 내 문자열 찾을 때.
* 왜: 설정·스크립트·힌트 검색에 유용.
* 예: `grep -R "password" . 2>/dev/null`

### `awk '{print $1}' file`

* 언제: 칼럼 단위로 값 추출.
* 예: 사용자명만 뽑을 때: `awk -F: '{print $1}' /etc/passwd`

### `sed -n '1,10p' file`, `head`, `tail`

* 언제: 파일 일부만 볼 때.
* 예: `sed -n '1,10p' file` 또는 `head -n 20 file`

---

## 바이너리·바이트 검사

### `file <파일>`

* 언제: 파일 타입(텍스트/ELF/압축 등) 확인.
* 왜: 적절한 도구 선택(예: strings, tar, unzip).

### `strings <파일>`

* 언제: 바이너리에서 사람이 읽을 수 있는 텍스트 추출.
* 왜: 토큰·비밀번호 조각 찾을 때.
* 예: `strings /bin/ls | head`

### `xxd` / `hexdump`

* 언제: 헥스 뷰가 필요할 때.
* 예: `xxd -l 64 /bin/ls | head`

---

## 탐색·조건 검색 (자동화 핵심)

### 와일드카드 + `./` 안전 처리

```bash
cat ./-file*
```

* 언제: `-`로 시작하는 파일들 한꺼번에 읽을 때.

### `find` 고급 필터

* SUID 파일 찾기:

  ```bash
  find / -perm -4000 2>/dev/null
  ```

  * 언제: 권한상승 벡터 탐색.
* 특정 크기·권한·실행여부로 찾기:

  ```bash
  find . -type f -readable -size 1033c ! -executable -print -ls
  ```

  * 언제: Bandit 문제처럼 정확한 조건의 파일을 고를 때.

### 파일형태로 필터 후 내용 출력 (안전)

```bash
find . -maxdepth 1 -type f -name 'maybehere*' -print0 \
  | xargs -0 file | grep -i ASCII | cut -d: -f1 \
  | xargs -I{} cat "{}"
```

* 언제: 패턴 파일 중 사람 읽을 수 있는 텍스트만 골라서 출력.

### null-safe xargs (공백 안전)

```bash
find . -name 'pattern' -print0 | xargs -0 <command>
```

---

## 프로세스·서비스·네트워크

### `ps aux`

* 언제: 실행중 프로세스 확인.
* 예: `ps aux --sort=-%mem | head`

### `ss -tuln`

* 언제: 리스닝 포트·프로토콜 확인.
* 예: `ss -tuln`

### `systemctl status ssh`

* 언제: SSH 서비스 상태 확인.
* 왜: 접속 이슈 진단.

### `sudo -l`

* 언제: 현재 계정의 sudo 권한 확인.
* 주의: Bandit에서는 보통 제한됨.

---

## 문제해결 팁(핵심)

* 파일명이 `-`로 시작하면 `./-name` 또는 `cat -- -name`.
* 공백 있으면 따옴표 또는 백슬래시로 이스케이프.
* 출력 깨지면 `file`로 타입 확인 후 `strings` 사용.
* 여러 파일에서 텍스트만 뽑을 때는 `file` → `grep ASCII` → `xargs cat`.
* 특수문자 파일은 `ls -lab`로 내부 문자 확인.
* inode가 필요하면 `ls -li` → `find -inum`.

---

## 실습 체크리스트 (짧고 실전)

1. VM 스냅샷 생성(실습 전).
2. Kali에서 SSH 접속 연습.
3. `ls -la`, `stat`, `file`, `strings` 사용해 파일 유형 판별.
4. 공백·옵션 충돌 파일 처리법 숙지.
5. `find`로 SUID·조건 파일 검색.
6. 비밀번호 찾으면 `ssh banditN+1@... -p 2220`로 로그인.
7. writeup: 명령·발견·증명(스크린샷 또는 출력) 정리.

