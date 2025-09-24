# Bash syntax

## 1. 실행 선언과 안전 설정

```bash
#!/bin/bash
set -Eeuo pipefail
```

* `#!/bin/bash` → Bash 스크립트 실행 선언.
* `set -e` → 에러 시 즉시 종료.
* `set -u` → 정의되지 않은 변수 사용 시 에러.
* `set -o pipefail` → 파이프라인 중 하나라도 실패하면 전체 실패.
* `set -E` → 함수/서브셸에서도 `ERR` trap 유지.

---

## 2. 인자 처리

```bash
dir="${1:-.}"
shift
```

* `$1`, `$2` … → 스크립트 실행 시 인자.
* `${1:-.}` → `$1`이 없으면 기본값 `.` 사용.
* `shift` → 인자를 앞으로 이동. (ex: `$2 → $1`)

---

## 3. 조건문

```bash
[[ -e "$dir" ]] || die "경로가 없음"
[[ -d "$dir" ]] || die "디렉토리 아님"
```

* `[[ … ]]` → 조건식.
* `-e` → 경로 존재 여부.
* `-d` → 디렉토리 여부.
* `-f` → 일반 파일 여부.
* `||` → 앞 조건 실패 시 뒤 실행.

---

## 4. 함수

```bash
usage() { echo "사용법: $0 [옵션]" >&2; }
ensure_file() { [[ -f "$TODO_FILE" ]] || : >"$TODO_FILE"; }
```

* `함수명() { … }` → 함수 정의.
* `$0` → 스크립트 파일명.
* `>&2` → 표준 에러 출력.
* `: > file` → 빈 파일 생성/초기화.

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
* `shift` → 불필요한 인자 제거.
* `"$@"` → 남은 인자 전체 전달.

---

## 6. 날짜와 문자열

```bash
now=$(date "+%F %H:%M")
backup_name="backup-$(date +%Y%m%d).tar.gz"
```

* `$( … )` → 명령어 치환.
* `date "+%F %H:%M"` → `YYYY-MM-DD HH:MM`.
* 문자열 결합: `"backup-$변수명"`

---

## 7. 파일 탐색과 집계

```bash
find "$dir" -type f | wc -l
find "$dir" -type d | wc -l
ls -t "$dir" | head -1
```

* `find` → 파일/디렉토리 검색.
* `wc -l` → 줄 수 세기.
* `ls -t` → 최근 수정순 정렬.
* `head -1` → 첫 줄만 출력.

---

## 8. 텍스트 필터링

```bash
grep -E "INFO|WARN|ERROR" file
awk -v pat="$pattern" '...'
```

* `grep -E` → 정규식 매칭.
* `^$level` → 줄 시작 일치.
* `awk` → 라인 단위 처리 및 집계.
* `-v var=value` → 쉘 변수 전달.

---

## 9. 파일/디렉토리 관리

```bash
mkdir -p "$backup_dir"
tar -czf "$backup_dir/$backup_name" "$target"
rm -f "$oldest_file"
```

* `mkdir -p` → 경로 없으면 생성.
* `tar -czf` → 디렉토리 압축(tar+gzip).
* `rm -f` → 강제 삭제, 존재 안 해도 무시.

---

## 10. 배열과 정렬 (`backup_rotate.sh`에서 추가)

```bash
files=("$backup_dir"/*.tar.gz)
oldest_file=$(ls -t "${files[@]}" | tail -1)
```

* `array=( … )` → 배열 선언.
* `"${files[@]}"` → 배열 요소 모두 참조.
* `ls -t` → 최신순 정렬.
* `tail -1` → 가장 오래된 파일 추출.

---

## 11. 입출력 제어

```bash
2>/dev/null
>&2
|| true
```

* `2>/dev/null` → 에러 메시지 버리기.
* `>&2` → 표준 에러 출력.
* `|| true` → 실패해도 스크립트 종료 방지.

---

## 12. 변수 조작

* `local var=value` → 함수 내부 전용 변수.
* `${var#* }` → 첫 공백 전까지 삭제.
* `${var^^}` → 문자열 대문자 변환.

---

# 요약

* **안전 실행**: `set -Eeuo pipefail`
* **인자 처리**: `$1`, `shift`, `${1:-기본값}`
* **조건문**: `[[ -e ]]`, `[[ -d ]]`, `||`
* **함수**: `usage()`, `ensure_file()`, `count_files()`, `backup_rotate()` 등
* **분기**: `case "$1" in`
* **날짜/문자열**: `date`, 변수 치환, 문자열 결합
* **파일 관리**: `find`, `ls`, `wc`, `tar`, `rm`, `mkdir`
* **텍스트 처리**: `grep`, `awk`
* **배열/정렬**: 배열, `ls -t`, `tail`
* **입출력 제어**: `>&2`, `2>/dev/null`, `|| true`
