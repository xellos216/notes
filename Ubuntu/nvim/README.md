# 0) 필수 패키지

```bash
sudo apt update
sudo apt install -y neovim git curl ripgrep fd-find python3-venv python3-pip
```

# 1) NVIM 초기화

```bash
# 설정 디렉터리
mkdir -p ~/.config/nvim

# 설정 열기(여기에 기존 init.lua 붙여넣기)
nano ~/.config/nvim/init.lua
```

```bash
# 플러그인 동기화(헤드리스)
nvim --headless "+Lazy! sync" +qa
```

# 2) LSP/자동완성/문법하이라이트 준비

```bash
# Pyright 설치(Mason)
nvim --headless "+MasonInstall pyright" +qa

# Treesitter 파서(파이썬)
nvim --headless "+TSInstallSync python" +qa
```

# 3) 프로젝트 파이썬 환경

## A. 가장 단순(프로젝트별 venv)

```bash
cd /path/to/project
python3 -m venv .venv
. .venv/bin/activate
pip install -U pip black
```

## B. direnv + pyenv(원하는 버전 고정)

```bash
cd /path/to/project
pyenv install -s 3.12.6
printf 'layout python ~/.pyenv/versions/3.12.6/bin/python\n' > .envrc
direnv allow
python -V
pip install -U pip black
```

# 4) 사용/검증

```bash
# 프로젝트에서 NVIM 실행
nvim

# NVIM 안에서 확인
:LspInfo          " Pyright 연결 확인
:ConformInfo      " black 발견 여부 확인
:TSModuleInfo     " treesitter 파서 확인
```

# 5) 단축키(요약)

* 포맷: `<leader>f` (너는 `\f`)
* 터미널 분할: `\t` (가로), `\v` (세로)
* 창 이동: `Ctrl+←/→/↑/↓`
* 터미널 종료: `exit` 또는 `<C-\><C-n>` 후 `:bd!`

# 6) 문제 시 빠른 점검

```bash
which black && black --version        # 포매터 경로/버전
nvim --headless "+checkhealth" +qa    # NVIM 헬스체크
```

---

# 📌 Neovim 기본 단축키 요약

## 모드 전환

* `i` → 입력 모드 (insert)
* `ESC` → 노멀 모드 (normal)
* `v` → 비주얼 모드 (visual)
* `V` → 비주얼 라인 모드
* `Ctrl-v` → 비주얼 블록 모드
* `:` → 명령 모드 (ex)
* `R` → 대체 모드 (replace)

---

## 이동

* `h` / `l` → 왼쪽 / 오른쪽 한 칸
* `j` / `k` → 아래 / 위 한 줄
* `w` / `e` → 다음 단어의 시작 / 끝
* `0` / `^` / `$` → 줄 맨 앞 / 첫 글자 / 줄 끝
* `gg` / `G` → 문서 맨 처음 / 맨 끝
* `:{숫자}` → 특정 줄로 이동 (예: `:42`)
* `%` → 괄호 매칭 이동

---

## 편집

* `x` → 커서 위치 문자 삭제
* `dd` → 현재 줄 잘라내기(삭제)
* `yy` → 현재 줄 복사
* `p` → 붙여넣기 (커서 뒤/아래)
* `P` → 붙여넣기 (커서 앞/위)
* `u` → Undo
* `Ctrl-r` → Redo
* `ggVG`  → 전체 선택
* `ggVGy`  →  전체 복사
* `ggVGd`  →  전체 잘라내기

---

## 검색/치환

* `/word` → 아래 방향으로 검색
* `?word` → 위 방향으로 검색
* `n` / `N` → 같은 방향 / 반대 방향으로 다음 결과
* `:%s/foo/bar/g` → 문서 전체에서 foo를 bar로 치환

---

## 창/탭 관리

* `:split` / `:vsplit` → 수평/수직 분할
* `Ctrl-w h/j/k/l` → 분할 창 간 이동
* `:tabnew` → 새 탭 열기
* `gt` / `gT` → 다음/이전 탭

---

## 파일/저장/종료

* `:e {파일명}` → 파일 열기
* `:w` → 저장
* `:q` → 종료
* `:wq` → 저장 후 종료
* `:q!` → 저장하지 않고 종료
* `:qa` / `:qa!` → 모든 창 종료 (저장 / 강제 종료)
