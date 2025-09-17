#!/bin/bash

set -Eeuo pipefail

TODO_FILE="${HOME}/.todo.txt"

usage() {
    cat >&2 <<'USAGE'
사용법:
    ./todo.sh add "메모"
    ./todo.sh list
    ./todo.sh grep KEYWORD
    ./todo.sh count
USAGE
}

ensure_file() {
    [[ -f "$TODO_FILE" ]] || {
        umask 077
        : >"$TODO_FILE"
    }
}

add() {
    ensure_file
    [[ $# -ge 1 ]] || {
        echo "오류: 메모가 비어 있음" >&2
        exit 1
    }
    local msg="$*"
    local now
    now=$(date "+%F %H:%M")
    echo "$now - $msg" >>"$TODO_FILE"
}

list() {
    ensure_file
    cat "$TODO_FILE"
}

do_grep() {
    ensure_file
    [[ $# -eq 1 ]] || {
        echo "오류: KEYWORD 필요" >&2
        exit 1
    }
    local kw="$1"
    grep -n -- "$kw" "$TODO_FILE" || true
}

count_items() {
    ensure_file
    wc -l <"$TODO_FILE"
}

[[ $# -ge 1 ]] || {
    usage
    exit 1
}

case "$1" in
add)
    shift
    add "$@"
    ;;
list) list ;;
grep)
    shift
    do_grep "$@"
    ;;
count) count_items ;;
*)
    usage
    exit 1
    ;;
esac
