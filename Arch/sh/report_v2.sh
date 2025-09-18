#!/bin/bash

usage() {
    echo "Usage: $0 <directory> [N]" >&2
    exit 1
}

make_report() {
    local dir="$1" topn="$2"
    echo "=== File Size Report ==="
    echo "Directory: $dir"
    echo "Top $topn files:"
    local i=1

    while IFS=$'\t' read -r size path; do
        echo "$i. $(numfmt --to=iec $size) $path"
        i=$((i + 1))
    done < <(find "$dir" -type f -printf "%s\t%p\n" 2>/dev/null | sort -nr | head -n "$topn")
}

[ "$#" -lt 1 ] && usage
dir="$1"
topn="${2:-5}"

if [ ! -d "$dir" ]; then
    echo "Error: not a directory: $dir" >&2
    exit 1
fi

make_report "$dir" "$topn"
