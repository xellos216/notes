#!/bin/bash

# 사용자 정의
ALIAS_NAME="tp"
SCRIPT_PATH="$HOME/gh/Notes/Typer/Typer-Python3.sh"
BASHRC="$HOME/.bashrc"

# 1. 파일 존재 여부 확인
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "❌ 스크립트가 존재하지 않습니다: $SCRIPT_PATH"
  exit 1
fi

# 2. 기존 alias 중복 제거
if grep -q "alias $ALIAS_NAME=" "$BASHRC"; then
  echo "🧹 기존 alias '$ALIAS_NAME' 제거 중..."
  sed -i "/alias $ALIAS_NAME=/d" "$BASHRC"
fi

# 3. alias 추가
echo "📌 alias $ALIAS_NAME 등록 중..."
echo "alias $ALIAS_NAME='$SCRIPT_PATH'" >> "$BASHRC"

# 4. 즉시 반영
echo "🔄 source $BASHRC 적용 중..."
source "$BASHRC"

# 5. 확인 메시지
echo "✅ alias '$ALIAS_NAME' 등록 완료!"
echo "👉 이제 '$ALIAS_NAME' 명령어로 실행할 수 있습니다."
