# vim_ide_setup

## 1) Theory

-   목표: vim에서 코딩 편집 효율을 확보하고, 실행은 CLI로 처리.
-   구성:
    -   플러그인 매니저: vim‑plug
    -   코드 인텔리전스: coc.nvim(+ LSP 확장)
    -   Lint/Format: ALE + black/isort/ruff(파이썬),
        google‑java‑format(자바)
    -   최소 단축키: 정의/참조/리네임/포맷/실행

------------------------------------------------------------------------

## 2) Example code

### 2.1 필수 패키지 설치

``` bash
# Vim에 Python3 연동된 버전 권장
sudo apt update
sudo apt install -y vim-nox git curl nodejs npm openjdk-17-jdk

# Python 툴
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install black
pipx install isort
pipx install ruff
pipx install pyright

# google-java-format
GJF_VER=1.22.0
curl -L -o ~/.local/bin/google-java-format.jar \
https://repo1.maven.org/maven2/com/google/googlejavaformat/google-java-format/${GJF_VER}/google-java-format-${GJF_VER}-all-deps.jar
```

### 2.2 vim-plug 설치

``` bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 2.3 `.vimrc` 최소 설정

``` vim
" 기본 옵션
set nocompatible
set number
set relativenumber
set tabstop=4 shiftwidth=4 expandtab
set smartindent
set hidden
set updatetime=300
syntax on
filetype plugin indent on

" 리더키
let mapleader="\<Space>"

" 플러그인
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

" coc 기본 키맵
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> K :call CocActionAsync('doHover')<CR>
nmap <leader>rn <Plug>(coc-rename)
" 포맷
nnoremap <leader>f :ALEFix<CR>

" ALE 설정: 파이썬/자바 포매터·린터
let g:ale_fix_on_save = 1
let g:ale_linters = {
\ 'python': ['ruff'],
\ 'java': ['javac'],
\}
let g:ale_fixers = {
\ 'python': ['isort', 'black'],
\ 'java': ['google_java_format'],
\}
let g:ale_java_google_java_format_executable =
\ 'java -jar ' . expand('~/.local/bin/google-java-format.jar')

" 파일별 실행 단축키
" 파이썬: 저장 후 현재 파일 실행
nnoremap <leader>rp :w<CR>:!python3 %<CR>
" 스프링 부트: git 루트에서 gradle 실행
nnoremap <leader>rs :w<CR>:execute '!cd ' . system('git rev-parse --show-toplevel')->trim() . ' && ./gradlew bootRun'<CR>

" 상태 표시(진단) - 필요 없으면 주석 처리
" autocmd CursorHold * silent call CocActionAsync('diagnosticList')
```

### 2.4 coc.nvim 확장 설치

#### vim 열고 다음 실행:

``` vim
:CocInstall coc-pyright coc-json coc-sh coc-yaml coc-java
```

### 2.5 프로젝트별 권장 폴더 구조 예

    project/
    ├─ .env
    ├─ build.gradle / settings.gradle
    ├─ src/main/java/... (Spring)
    ├─ venv/ (선택, python -m venv venv)
    └─ app.py (예시)

------------------------------------------------------------------------

## 3) Execution_and_testing_method

### 3.1 파이썬 작업

``` bash
# 선택: 가상환경
python3 -m venv venv
source venv/bin/activate
pip install black isort ruff  # 가상환경에도 설치 시 자동 인식 좋음
```

-   파일 열기: `vim app.py`
-   자동 완성/오류: coc‑pyright가 제공
-   저장 시 포맷: black+isort 자동 실행
-   실행: `<Space>rp` 또는 `:!python3 %`

#### 테스트:

``` bash
echo 'print("hello")' > app.py
vim app.py   # 내용 수정 후 저장
# 실행
python3 app.py
```

### 3.2 간단한 Java 수정 + Spring 서버 실행

-   파일 열기: `vim src/main/java/.../App.java`
-   자동 완성/에러: coc‑java가 JDK17 기반으로 제공
-   저장 시 포맷: google‑java‑format 적용
-   실행: 프로젝트 루트에서 `<Space>rs` 또는 `./gradlew bootRun`

#### 테스트:

``` bash
./gradlew clean build
./gradlew bootRun
# 환경변수 필요 시 (예: DB_*):
export DB_URL=... DB_USER=... DB_PASSWORD=...
./gradlew bootRun
```

### 3.3 빠른 워크플로우 요약

-   편집: vim
-   진단/완성: coc.nvim
-   포맷/린트: ALE + black/isort/ruff + google‑java‑format
-   실행: 파이썬 `<Space>rp`, 스프링 `<Space>rs` 또는 터미널 명령
