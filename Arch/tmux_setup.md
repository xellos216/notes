# tmux + Neovim + aider Python 개발 환경 기록

## 개요

이 문서는 CLI 기반 Python 개발 환경을 구축한 과정을 기록하기 위한 문서이다.

구성 요소:

- **tmux** : 터미널 작업 공간 관리
- **Neovim** : 코드 편집기
- **aider** : AI 코드 보조 도구
- **pytest** : 테스트 실행
- **Python venv** : 프로젝트별 Python 환경

목표는 **하나의 명령어로 개발 환경을 자동 생성하는 워크플로우**를 만드는 것이다.

---

# 개발 환경 구조

스크립트를 실행하면 tmux에서 **3개의 pane이 자동으로 생성된다.**

```

┌───────────────────────────────┬───────────────┐
│                               │               │
│            Neovim             │     aider     │
│          (코드 작성)          │   AI 코딩     │
│                               │               │
│                               ├───────────────┤
│                               │               │
│                               │     pytest    │
│                               │  테스트 실행  │
│                               │               │
└───────────────────────────────┴───────────────┘

```

### Pane 역할

**왼쪽 pane**
- 코드 작성 (Neovim)

**오른쪽 위 pane**
- AI 코드 보조 (aider)

**오른쪽 아래 pane**
- 테스트 / git / 실행용 shell

---

# 스크립트 구조

개발 환경 관리를 위해 다음 세 개의 스크립트를 사용한다.

```

dev-new
dev
dev-kill

```

설치 위치

```

~/.local/bin

````

---

# dev-new 스크립트

새로운 tmux 개발 세션을 생성하고 Python 프로젝트 환경을 준비한다.

### 주요 기능

- 프로젝트 디렉토리 감지
- git repository 초기화
- Python virtualenv 생성
- 기본 프로젝트 파일 생성
- tmux 레이아웃 생성
- Neovim / aider / pytest pane 실행

### 스크립트

```bash
#!/usr/bin/env bash

set -euo pipefail

SESSION_NAME="${1:-}"
INPUT_DIR="${2:-$PWD}"

if [ ! -d "$INPUT_DIR" ]; then
    echo "Project directory not found: $INPUT_DIR"
    exit 1
fi

if git -C "$INPUT_DIR" rev-parse --show-toplevel >/dev/null 2>&1; then
    PROJECT_DIR="$(git -C "$INPUT_DIR" rev-parse --show-toplevel)"
else
    PROJECT_DIR="$INPUT_DIR"
fi

if [ -z "$SESSION_NAME" ]; then
    SESSION_NAME="$(basename "$PROJECT_DIR")"
fi

if [ ! -d "$PROJECT_DIR/.git" ]; then
    git -C "$PROJECT_DIR" init >/dev/null 2>&1
fi

if [ ! -d "$PROJECT_DIR/.venv" ]; then
    python -m venv "$PROJECT_DIR/.venv"
fi

VENV_CMD="source .venv/bin/activate"

if [ ! -f "$PROJECT_DIR/.gitignore" ]; then
cat <<EOF > "$PROJECT_DIR/.gitignore"
.venv/
__pycache__/
*.pyc
.aider*
EOF
fi

if [ ! -f "$PROJECT_DIR/README.md" ]; then
echo "# $(basename "$PROJECT_DIR")" > "$PROJECT_DIR/README.md"
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session already exists: $SESSION_NAME"
    echo "Use: dev $SESSION_NAME"
    exit 1
fi

tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR"

tmux send-keys -t "$SESSION_NAME" "$VENV_CMD" C-m
tmux send-keys -t "$SESSION_NAME" "clear" C-m
tmux send-keys -t "$SESSION_NAME" "nvim ." C-m

tmux split-window -h -t "$SESSION_NAME" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME" "$VENV_CMD" C-m
tmux send-keys -t "$SESSION_NAME" "clear" C-m
tmux send-keys -t "$SESSION_NAME" "aider" C-m

tmux split-window -v -t "$SESSION_NAME" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME" "$VENV_CMD" C-m
tmux send-keys -t "$SESSION_NAME" "clear" C-m
tmux send-keys -t "$SESSION_NAME" "pytest -q || echo install pytest" C-m

tmux select-layout -t "$SESSION_NAME" main-vertical
tmux resize-pane -t "$SESSION_NAME" -L 30
tmux select-pane -L -t "$SESSION_NAME"

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach-session -t "$SESSION_NAME"
fi
````

---

# dev 스크립트

이미 존재하는 tmux 세션에 접속한다.

### 사용법

```
dev
dev 세션이름
```

### 스크립트

```bash
#!/usr/bin/env bash

set -euo pipefail

SESSION_NAME="${1:-}"

if ! tmux ls >/dev/null 2>&1; then
    echo "No tmux sessions found."
    exit 1
fi

if [ -z "$SESSION_NAME" ]; then
    SESSION_NAME=$(tmux ls -F "#{session_name}" | head -n1)
fi

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$SESSION_NAME"
else
    tmux attach-session -t "$SESSION_NAME"
fi
```

---

# dev-kill 스크립트

tmux 세션을 종료한다.

### 사용법

```
dev-kill
dev-kill 세션이름
```

### 스크립트

```bash
#!/usr/bin/env bash

set -euo pipefail

SESSION_NAME="${1:-}"

if [ -z "$SESSION_NAME" ]; then
    SESSION_NAME="$(tmux display-message -p '#S')"
fi

tmux kill-session -t "$SESSION_NAME"
```

---

# 사용 방법

### 새 개발 환경 시작

```
dev-new
```

### 세션 이름 지정

```
dev-new coco
```

### 기존 세션 접속

```
dev coco
```

### tmux 세션에서 잠시 나가기

```
Ctrl+b d
```

### 현재 세션 종료

```
dev-kill
```

### 특정 세션 종료

```
dev-kill coco
```

---

# 개발 환경 특징

이 환경은 다음 기능을 제공한다.

* Python 프로젝트 자동 초기화
* tmux 기반 개발 환경 자동 생성
* virtualenv 자동 생성 및 활성화
* AI 코딩 도구 통합
* 테스트 환경 분리
* 하나의 명령어로 개발 환경 재현 가능

CLI 기반 Python 개발 환경을 빠르게 생성하고 여러 프로젝트 세션을 관리할 수 있는 구조이다.

```
```

