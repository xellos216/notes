# Bash sh basic

## 1. 실행 선언과 안전 설정

```bash
#!/bin/bash
set -Eeuo pipefail
```

* `#!/bin/bash` → Bash 스크립트로 실행하라는 선언 (shebang).
* `set -e` → 명령어 실패 시 스크립트 즉시 종료.
* `set -u` → 정의되지 않은 변수 사용 시 에러.
* `set -o pipefail` → 파이프라인에서 앞 단계라도 실패하면 전체 실패 처리.
* `set -E` → 함수/서브셸에서도 `ERR` trap 유지.

---

## 2. 인자 처리

```bash
dir="${1:-.}"
shift
```

* `$1`, `$2` … → 스크립트 실행 시 받은 인자.
* `${1:-.}` → `$1`이 비어 있으면 기본값 `.` 사용.
* `shift` → 인자 하나 제거, 나머지를 앞으로 이동. (`$2 → $1`, `$3 → $2` …).

---

## 3. 조건문

```bash
[[ -e "$dir" ]] || die "경로가 없음"
[[ -d "$dir" ]] || die "디렉토리가 아님"
```

* `[[ … ]]` → 조건식.
* `-e` → 경로 존재 여부.
* `-d` → 디렉토리 여부.
* `||` → 앞이 실패하면 뒤 실행.

---

## 4. 함수

```bash
usage() { echo "사용법: $0 [옵션]" >&2; }
ensure_file() { [[ -f "$TODO_FILE" ]] || : >"$TODO_FILE"; }
```

* `함수명() { … }` → 함수 정의.
* `$0` → 스크립트 파일 이름.
* `>&2` → 표준 에러로 출력.
* `: >file` → 파일을 빈 내용으로 생성.

---

## 5. case 문 (서브커맨드 분기)

```bash
case "$1" in
  add) shift; add "$@";;
  list) list;;
  grep) shift; do_grep "$@";;
  count) count_items;;
  *) usage; exit 1;;
esac
```

* `case` … `esac` → 여러 명령 중 하나 실행.
* `shift` → `add`, `grep`처럼 인자가 뒤따르는 경우 소비.
* `"$@"` → 남은 인자 전체.

---

## 6. 날짜와 문자열

```bash
now=$(date "+%F %H:%M")
echo "$now - $msg" >> "$TODO_FILE"
```

* `$( … )` → 명령어 치환.
* `date "+%F %H:%M"` → `YYYY-MM-DD HH:MM`.
* `>>` → 파일에 append.

---

## 7. 파일 탐색과 집계

```bash
find "$dir" -type f | wc -l
find "$dir" -type d | wc -l
ls -t "$dir" | head -1
```

* `find` → 파일/디렉토리 검색.
* `-type f` → 파일만, `-type d` → 디렉토리만.
* `wc -l` → 줄 수 세기.
* `ls -t` → 수정 시간순 정렬.
* `head -1` → 첫 줄만 출력.

---

## 8. grep/awk

```bash
grep -E "INFO|WARN|ERROR" file
awk -v pat="$pattern" '...'
```

* `grep -E` → 정규식 매칭 (확장 정규식).
* `^$level` → 줄 시작이 특정 문자열.
* `awk` → 라인 단위 필터링 및 카운트.
* `-v pat="$pattern"` → 쉘 변수 → awk 변수 전달.

---

## 9. 입출력 제어

* `2>/dev/null` → 에러 메시지 버리기.
* `>&2` → 표준에러로 출력.
* `|| true` → 실패해도 스크립트 에러로 처리하지 않음.

---

## 10. 변수 규칙

* `local var=value` → 함수 내부 한정 변수.
* `${var#* }` → 문자열에서 첫 번째 공백 전까지 제거.
* `${var^^}` → 문자열을 대문자로 변환.

---

# 요약

* **안전성**: `set -Eeuo pipefail`
* **인자 처리**: `$1`, `${1:-.}`, `shift`, `"$@"`
* **조건문**: `[[ -e ]]`, `||`, `&&`
* **함수화**: `usage()`, `ensure_file()`, `count_files()` 등
* **서브커맨드 분기**: `case "$1" in … esac`
* **파일 연산**: `find`, `wc`, `ls`, `head`, `echo >>`
* **텍스트 필터링**: `grep`, `awk`
* **문자열 조작**: `${var#}`, `${var^^}`
