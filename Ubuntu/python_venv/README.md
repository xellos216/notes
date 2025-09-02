# Ubuntu에서 파이썬 편하게 쓰는 방법 정리

## 불편한 이유

-   **시스템 파이썬 제약**: Ubuntu 기본 Python은 시스템 의존성이 많아
    버전 교체나 패키지 관리가 어렵다.\
-   **패키지 충돌**: `apt`와 `pip`가 혼용되면 환경 꼬임 발생.\
-   **IDE/에디터 세팅 번거로움**: Windows/macOS보다 초기 세팅이 불편.\
-   **한글/입출력 문제**: locale 설정 때문에 로그나 matplotlib
    그래프에서 한글 깨짐.

------------------------------------------------------------------------

## 해결 전략

1.  **pyenv**로 시스템 파이썬과 분리, 원하는 버전 설치.\
2.  **venv**로 프로젝트별 독립 환경.\
3.  **pipx**로 전역 CLI 툴과 프로젝트 패키지 분리.\
4.  **direnv**로 폴더 진입 시 자동 venv 활성화.\
5.  **UTF-8/폰트 세팅**으로 한글 깨짐 제거.\
6.  **IDE 연동**: VSCode, PyCharm에서 `.venv` 자동 인식.\
7.  **Docker (선택)**: 프로젝트 실행 환경 완전 격리.

------------------------------------------------------------------------

## 자동 세팅 스크립트

```bash
#!/usr/bin/env bash
set -euo pipefail

PY_VER="${PY_VER:-3.12.5}"
BASHRC="${HOME}/.bashrc"
MARK="# >>> python-ubuntu-setup >>>"

echo "[1/8] apt 기본 준비"
sudo apt update
sudo apt install -y \
  build-essential \
  curl \
  git \
  ca-certificates \
  pkg-config \
  xz-utils \
  tk-dev \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libffi-dev \
  liblzma-dev \
  libxml2-dev \
  libxmlsec1-dev \
  libncurses-dev \
  llvm \
  fonts-nanum \
  locales \
  pipx \
  direnv \
  libgdbm-dev \
  libgdbm-compat-dev \
  libnss3-dev \
  uuid-dev

echo "[2/8] 로케일 UTF-8"
sudo locale-gen en_US.UTF-8 ko_KR.UTF-8
sudo update-locale LANG=en_US.UTF-8
grep -q "$MARK" "$BASHRC" || cat <<'EOF' >> "$BASHRC"
# >>> python-ubuntu-setup >>>
export LANG=en_US.UTF-8
export PYTHONIOENCODING=utf-8
export PATH="$HOME/.local/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(direnv hook bash)"

mkvenv() { python -m venv .venv && . .venv/bin/activate && python -m pip install -U pip; }
use_direnv_here() { echo 'source .venv/bin/activate' > .envrc && direnv allow; }
# >>> python-ubuntu-setup >>>
EOF

echo "[3/8] pyenv 설치"
if [ ! -d "${HOME}/.pyenv" ]; then
  git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
fi

echo "[4/8] 셸 재적용"
# shellcheck source=/dev/null
source "$BASHRC"

echo "[5/8] Python ${PY_VER} 설치"
pyenv install -s "${PY_VER}"
pyenv global "${PY_VER}"
pyenv rehash

echo "[6/8] 기본 pip 업그레이드"
python -m pip install -U pip wheel setuptools

echo "[7/8] pipx 초기화"
pipx ensurepath || true
hash -r || true
pipx install black || true
pipx install ruff || true
pipx install httpie || true

echo "[8/8] 검증 정보"
python -V
pyenv which python
pipx --version || true
direnv --version || true
echo "완료: 새 터미널 열거나 'source ~/.bashrc' 후 사용"
echo "프로젝트에서: 'mkvenv' 로 venv 생성+활성화, 필요시 'use_direnv_here' 로 자동 활성화"

```

------------------------------------------------------------------------

## 사용법

### 스크립트 실행

```bash
chmod +x setup_python.sh
bash ./setup_python.sh
PY_VER=3.12.5 기본 \# 다른 버전 원하면 PY_VER=3.11.9
```

### 경로 막힌 경우

```export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
```

### 프로젝트 워크플로

```bash
 cd /path/to/project
```

# 1. 가상환경 생성 + 활성화

* ```mkvenv```

# 2. 패키지 설치

* ```pip install -r requirements.txt```

# 3. direnv 사용 (자동 활성화)

#### 가상환경이 제대로 생성되어 있는지 확인

```
ls .venv/bin/activate
```

#### 없으면 다시 생성:

```
python3 -m venv .venv
```

####  `.envrc` 수정

```
layout python3 .venv
```

####  또는

```
layout python .venv
```

####  (Ubuntu에서 python3만 있을 때는 `layout python3`가 더 안전)

####  적용

```
direnv allow
```

------------------------------------------------------------------------

## 세팅 후 효과

-   시스템 파이썬과 분리 → apt 충돌 없음.
-   프로젝트별 독립 환경 → 서로 다른 패키지 버전 공존 가능.
-   CLI 툴과 라이브러리 분리 → 환경 오염 방지.
-   IDE 자동 인식 → VSCode/PyCharm에서 바로 실행·디버깅.
-   UTF-8/폰트 적용 → 한글 로그·그래프 깨짐 방지.
-   필요시 Docker로 완벽한 실행환경 복제 가능.
