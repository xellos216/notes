#!/bin/bash

usage() {
    echo "사용법: $0 [단] 또는 $0 [시작단] [끝단]" >&2
    exit 1
}

is_valid_1to9() {
	local x="$1"
	[[ "$x" =~ ^[0-9]+$ ]] && [ "$x" -ge 1 ] && [ "$x" -le 9 ]
}

print_dan() {
	local dan="$1"
	for ((i=1; i<=9; i++)); do
		echo "$dan x $i = $((dan * i))"
	done
}

case "$#" in
	0)
		read -r -p "단을 입력하세요 [기본 2]: " n
		[ -z "$n" ] && n=2
		if ! is_valid_1to9 "$n"; then
			echo "오류: 1~9 사이의 정수만 허용" >&2; exit 1
		fi
		print_dan "$n"
		;;
    1)
        n="$1"
        if ! is_valid_1to9 "$n"; then
            echo "오류: 1~9 사이의 정수만 허용" >&2; exit 1
        fi
        print_dan "$n"
        ;;
    2)
        start="$1"; end="$2"
        if ! is_valid_1to9 "$start" || ! is_valid_1to9 "$end"; then
            echo "오류: 시작단과 끝단 모두 1~9 사이의 정수여야 함" >&2; exit1
        fi
        if [ "$start" -gt "$end" ]; then
            echo "오류: 시작단이 끝단보다 클 수 없음" >&2; exit 1
        fi
        for ((d=start; d<=end; d++)); do
            print_dan "$d"
            [ "$d" -lt "$end" ] && echo
        done
        ;;

    *) 
        usage
        ;;
esac
