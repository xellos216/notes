#Typer v1.5 by Xellos216
#!/bin/bash


# 경로 정의
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROBLEMS_DIR="$SCRIPT_DIR/Python3"
TMP_FILE="/tmp/typer_input_$$.txt"


# 입력 인자가 없을 경우
if [ -z "$1" ]; then
  echo "❌ Please enter a problem number or 'random'."
  echo "📘 Usage: ./typer.sh [problem_number|random]"
  exit 1
fi


# 분기 확인
if [[ "$1" =~ ^([0-9]{2})(e|x)$ ]]; then
  PROBLEM_NUM="${BASH_REMATCH[1]}"
  MODE="explanation"
else
  PROBLEM_NUM="$1"
  MODE="default"
fi


# 풀이 출력
echo ""
if [ "$MODE" = "explanation" ]; then
  BASE_DIR=$(find "$PROBLEMS_DIR" -maxdepth 1 -type d -name "$PROBLEM_NUM" | head -n 1)
  EXPLAIN_FILE="$BASE_DIR/Explanations.md"
  if [ -f "$EXPLAIN_FILE" ]; then
awk '
  BEGIN {
    in_code = 0
    yellow = "\033[33m"
    reset = "\033[0m"
  }
  /^\`\`\`python/ { in_code = 1; next }
  /^\`\`\`/ { in_code = 0; next }
  {
    if (!in_code && /^\#\# /) {
      print yellow $0 reset
    } else {
      print
    }
  }
' "$EXPLAIN_FILE"
  else
    echo "❌ Explanations.md not found for problem $PROBLEM_NUM"
  fi
    echo ""
  exit 0
fi

PROBLEM_NUM="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROBLEMS_DIR="$SCRIPT_DIR/Python3"
TMP_FILE="/tmp/typer_input_$$.txt"


# 랜덤 문제 선택 처리
if [ "$1" = "random" ]; then
  RANDOM_DIR=$(ls -d "$PROBLEMS_DIR"/[0-9][0-9]/ 2>/dev/null | shuf -n1)
  BASE_DIR="$RANDOM_DIR"
  PROBLEM_NUM=$(basename "$RANDOM_DIR")
  echo ""
  echo "🎲 Random Question: $(basename "$BASE_DIR")"
else
  BASE_DIR=$(find "$PROBLEMS_DIR" -maxdepth 1 -type d -name "${PROBLEM_NUM}*" | head -n 1)
fi

README_FILE="$BASE_DIR/README.md"


# 문제 설명 출력
if [ -f "$README_FILE" ]; then
  awk '
    BEGIN {
      CYAN = "\033[35m"
      RESET = "\033[0m"
    }

    # 강조 색상 추가 조건
    /^## 🧠 Problem/    { print CYAN $0 RESET; next }
    /^### Constraints/  { print CYAN $0 RESET; next }
    /^### Example/      { print CYAN $0 RESET; next }

    # 기본 출력
    /^---$/             { print; exit }  # 첫 구분선 전까지만 출력
    { print }
  ' "$README_FILE"
  echo ""
else
  echo "❌ README.md not found in: $BASE_DIR"
  exit 1
fi


# 사용자 입력 유도
echo -e "✍️  \033[36m[Enter your code below, then press Ctrl + D to submit]\033[0m"
cat > "$TMP_FILE"
echo ""
echo ""
echo "---"


# Reference Code 출력
echo ""
echo -e "✅ \033[32m[Reference Code]\033[0m"

awk '
  BEGIN {
    in_code=0
    seen_title=0
    yellow="\033[33m"
    reset="\033[0m"
  }

  /^\#\#\# [0-9]+\./ {
    if (seen_title) print ""
    print yellow $0 reset
    seen_title++
    next
  }

  /^\`\`\`python/ { in_code=1; next }

  /^\`\`\`/ {
    if (in_code) {
      in_code=0
      print ""
    }
    next
  }

  in_code { print }
' "$README_FILE"

echo -e "📝 \033[36m[Your Input]\033[0m"
cat "$TMP_FILE"
echo ""

rm "$TMP_FILE"
echo ""
