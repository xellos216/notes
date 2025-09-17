#!/bin/bash

set -Eeuo pipefail

usage() {
    echo "사용법: $0 [PATH]" >&2
    exit 1
}

die() {
    echo "오류: $*" >&2
    exit 1
}

dir="${1:-.}"

[[ "$#" -le 1 ]] || usage
[[ -e "$dir" ]] || die "경로가 존재하지 않음: $dir"
[[ -e "$dir" ]] || die "디렉토리 가아님: $dir"

count_files() {
    find "$dir" -type f 2>/dev/null | wc -l
}

count_shell() {
    find "$dir" -type f -name '*.sh' 2>/dev/null | wc -l
}

count_dirs() {
    find "$dir" -mindepth 1 -type d 2>/dev/null | wc -l
}

latest_file() {
    local line
    line=$(find "$dir" -type f -printf '%T@ %P\n' 2>/dev/null | sort -nr | head -n 1 || true)
    [[ -n "$line" ]] && printf '%s\n' "${line#* }" || printf '%s\n' "-"
}

total_files=$(count_files)
sh_files=$(count_shell)
subdirs=$(count_dirs)
latest=$(latest_file)

printf '총 파일 수 : %s\n' "$total_files"
printf '.sh 파일 수: %s\n' "$sh_files"
printf '하위 디렉토리 수 : %s\n' "$subdirs"
printf '가장 최근 수정 파일 : %s\n' "$latest"
