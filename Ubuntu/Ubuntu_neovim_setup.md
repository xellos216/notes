좋다. 그럼 **Ubuntu + Python 개발용 네오빔 풀 가이드 (설치 → 설정 → 사용)** 를 단계별로 정리해주겠다.
처음 쓰는 입장에서 **최소한의 세팅으로 LSP, 자동완성, 포맷팅**까지 다 되는 걸 목표로 한다.

---

# 1. 네오빔 설치

Ubuntu 22.04 기준:

```bash
sudo apt update
sudo apt install neovim python3-venv python3-pip -y
```

* `neovim` → 편집기 본체
* `python3-venv`, `pip` → 파이썬 관련 플러그인 동작에 필요

확인:

```bash
nvim --version
```

---

# 2. 기본 설정 디렉토리 준비

네오빔 설정은 `~/.config/nvim` 에 들어간다.

```bash
mkdir -p ~/.config/nvim
```

---

# 3. 플러그인 관리기 설치 (lazy.nvim)

```bash
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
```

---

# 4. 최소 init.lua 작성

`~/.config/nvim/init.lua` 파일을 만들고 다음 내용 붙여넣는다:

```lua
-- ===== 기본 옵션 =====
vim.opt.number = true        -- 줄번호
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- ===== lazy.nvim 로드 =====
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- 플러그인 목록
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "nvimtools/none-ls.nvim" }, -- 최신 null-ls 유지
})

-- ===== mason 세팅 =====
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "pyright" },
}

-- ===== LSP (Python) =====
local lspconfig = require("lspconfig")
lspconfig.pyright.setup{}

-- ===== 자동완성 =====
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }),
})

-- ===== 포맷터 & 린터 =====
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.ruff,
  },
})
```

---

# 5. 플러그인 설치

네오빔 실행:

```bash
nvim
```

첫 실행 시 lazy.nvim이 자동으로 플러그인을 설치한다.
설치 끝날 때까지 기다린다.

---

# 6. Python 관련 도구 설치

LSP, 포맷터, 린터를 실제로 깔아야 한다:

```bash
# LSP 서버
:!MasonInstall pyright

# 포맷터 & 린터
pip install black ruff
```

---

# 7. 사용 방법

* 파일 열기: `nvim main.py`
* 자동완성: 입력 중 `<C-Space>` (Ctrl+Space)
* 포맷팅: `:lua vim.lsp.buf.format()`
* 에러/경고: 자동으로 LSP/ruff가 표시

---

# 8. 확인

테스트용 `hello.py`:

```python
def add(x:int,y:int)->int:
    return x+y
print(add(1,2))
```

* 저장 시 black이 자동 포맷
* `x+y` 같은 부분에서 LSP가 타입추론/자동완성 제공
* `ruff`가 PEP8 스타일 위반 잡아줌
