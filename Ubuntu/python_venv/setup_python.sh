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
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
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

echo "[4/8] 환경 적용(비대화형)"
export PATH="$HOME/.local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

echo "[5/8] Python ${PY_VER} 설치"
pyenv install -s "${PY_VER}"
pyenv global "${PY_VER}"
pyenv rehash

echo "[6/8] 기본 pip 업그레이드"
pyenv exec python -m pip install -U pip wheel setuptools

echo "[7/8] pipx 초기화"
pipx ensurepath || true
hash -r || true
pipx install black || true
pipx install ruff || true
pipx install httpie || true

echo "[8/8] 검증 정보"
pyenv exec python -V
pyenv which python
pipx --version || true
direnv --version || true
echo "완료: 새 터미널 열거나 'source ~/.bashrc' 후 사용"
echo "프로젝트에서: 'mkvenv' 로 venv 생성+활성화, 필요시 'use_direnv_here' 로 자동 활성화"
