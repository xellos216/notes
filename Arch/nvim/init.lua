-- =========================
-- Leader
-- =========================
vim.g.mapleader = "\\"

-- =========================
-- lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
require("lazy").setup({
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",

  -- Syntax/AST
  "nvim-treesitter/nvim-treesitter",

  -- Formatter
  "stevearc/conform.nvim",

  -- Lint (null-ls 제거, nvim-lint 사용)
  "mfussenegger/nvim-lint",

  -- DAP stack
  "mfussenegger/nvim-dap",
  { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
  "mfussenegger/nvim-dap-python",

  -- Refactoring
  "ThePrimeagen/refactoring.nvim",

  -- Fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
})

-- =========================
-- Mason / LSP
-- =========================
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "bashls" },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup({
  capabilities = capabilities,
  settings = { python = { analysis = { typeCheckingMode = "basic" } } },
})

lspconfig.bashls.setup({
  capabilities = capabilities,
})

-- =========================
-- Treesitter
-- =========================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "lua", "bash" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- =========================
-- Formatter (conform)
-- =========================
require("conform").setup({
  formatters_by_ft = {
    python = { "isort", "black" },
    sh = { "shfmt" },
  },
  format_on_save = { timeout_ms = 1000, lsp_fallback = true },
})

-- =========================
-- Linter (nvim-lint)
-- =========================
local lint = require("lint")
lint.linters_by_ft = { python = { "ruff" } }
lint.linters_by_ft.sh = { "shellcheck" }
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function() require("lint").try_lint() end,
})

-- =========================
-- DAP + UI + Python
-- =========================
local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
require("dap-python").setup("python") -- .envrc 가정: 현재 python 사용

-- DAP keymaps
vim.keymap.set("n", "<F5>",  function() dap.continue() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc="Toggle BP" })
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("breakpoint condition: "))
end, { desc="Cond BP" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc="DAP UI" })

-- =========================
-- Refactoring
-- =========================
require("refactoring").setup({})
vim.keymap.set({ "n", "x" }, "<leader>rr",
  function() require("refactoring").select_refactor() end,
  { desc="Refactor actions" })

-- =========================
-- Completion (nvim-cmp)
-- =========================
local cmp = require("cmp")
cmp.setup({
  snippet = { expand = function(_) end },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
    ["<Tab>"]     = cmp.mapping.select_next_item(),
    ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- =========================
-- Keymaps (기존 유지)
-- =========================
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Format code" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>t", ":split | resize 10 | terminal<CR>", {
  noremap = true, silent = true, desc = "Open terminal in horizontal split",
})
vim.keymap.set("n", "<leader>v", ":vsplit | vertical resize 80 | terminal<CR>", {
  noremap = true, silent = true, desc = "Open terminal in vertical split",
})
vim.keymap.set("n", "<leader>c", function()
  if vim.bo.buftype == "terminal" then vim.cmd("bd!") else print("Not a terminal buffer") end
end, { noremap = true, silent = true, desc = "Close terminal" })

vim.keymap.set("n", "<C-Left>",  "<C-w>h")
vim.keymap.set("n", "<C-Down>",  "<C-w>j")
vim.keymap.set("n", "<C-Up>",    "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")
vim.keymap.set("t", "<C-Left>",  [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-Down>",  [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-Up>",    [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-Right>", [[<C-\><C-n><C-w>l]])

-- =========================
-- UI basics
-- =========================
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

