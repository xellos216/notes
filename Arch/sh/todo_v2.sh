#!/bin/bash

TODO_FILE="$HOME/.todo.txt"

usage() {
    echo "Usage: $0 {add <text>|list|grep <kw>|count|done <num>}" >&2
    exit 1
}

ensure_file() {
    [ -f "$TODO_FILE" ] || touch "$TODO_FILE"
}

add_item() {
    echo "$(date '+%F %R') - $*" >>"$TODO_FILE"
}

list_items() {
    nl -w2 -s'. ' "$TODO_FILE"
}

grep_items() {
    grep -n "$1" "$TODO_FILE"
}

count_items() {
    wc -l <"$TODO_FILE"
}

mark_done() {
    local num="$1"
    [ -n "$num" ] || {
        echo "Error: need item number" >&2
        exit 1
    }
    [ "$num" -ge 1 ] 2>/dev/null || { echo "Error: invalid number" >&2; }
    local tmp
    tmp=$(mktemp)
    awk -v n="$num" 'NR==n[$0="[x] "$0} {print $0}' "$TODO_FILE" >"$tmp" && mv "$tmp" "$TODO_FILE"
}

ensure_file

case "$1" in
add)
    shift
    add_item "$@"
    ;;
list) list_items ;;
grep)
    shift
    grep_items "$@"
    ;;
count) count_items ;;
done)
    shift
    mark_done "$1"
    ;;
*) usage ;;
esac
