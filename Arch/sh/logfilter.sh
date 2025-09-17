#!/bin/bash

set -Eeuo pipefail

usage() {
    echo "사용법: $0 FILE [LEVEL(INFO|WARN|ERROR)]" >&2
    exit 2
}
die() {
    echo "오류: $*" >&2
    exit 1
}

[[ $# -ge 1 && $# -le 2 ]] || usage
file="$1"
[[ -f "$file" ]] || die "파일이 없음: $file"

if [[ $# -eq 2 ]]; then
    level="${2^^}"
    [[ "$level" =~ ^(INFO|WARN|ERROR)$ ]] || die "LEVEL은 INFO|WARN|ERROR 중 하나"
    pattern="^$level"
else
    pattern="INFO|WARN|ERROR"
fi

awk -v pat="$pattern" '
    BEGIN{ n=0 }
    $0 ~ pat { print; n++ }
    END{ printf("Matched: %d\n", n) }
' "$file"
