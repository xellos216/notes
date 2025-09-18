#!/bin/bash

usage() {
    echo "사용법: $0 <file_path> [keyword]" >&2
    exit 1
}

filter_log() {
    local file="$1" kw="$2"

    if [ ! -f "$file" ]; then
        echo "Error: file not fount: $file" >&2
        exit 1
    fi

    echo "=== Log filter ==="
    echo "File: $file"
    [ -n "$kw" ] && echo "Keyword: $kw"

    if [ -z "$kw" ]; then
        echo "Total $(wc -l <"$file") lines"
    else
        local matches count
        matches=$(grep -n "$kw" "$file")
        count=$(echo "$matches" | wc -l)
        echo "Total $count matches"
        echo "$matches"
    fi
}

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    usage
fi

file="$1"
kw="$2"
filter_log "$file" "$kw"
