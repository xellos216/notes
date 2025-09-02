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
  "neovim/nvim-lspconfig",            -- LSP
  "williamboman/mason.nvim",          -- Installer
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",                 -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "nvim-treesitter/nvim-treesitter",  -- Syntax
  "stevearc/conform.nvim",            -- Formatter
  { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- Linters
})

-- =========================
-- Mason / LSP
-- =========================
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "pyright" } })

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.pyright.setup({ capabilities = capabilities })

-- =========================
-- Treesitter
-- =========================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- =========================
-- Formatter (conform)
-- =========================
require("conform").setup({
  formatters_by_ft = {
    python = { "isort", "black" }, -- 순서 유지: isort -> black
  },
  format_on_save = { timeout_ms = 1000, lsp_fallback = true },
})

-- =========================
-- Linter (none-ls / null-ls)
-- =========================
local null = require("null-ls")
null.setup({
  sources = {
    null.builtins.diagnostics.ruff, -- Python lint
    -- 필요 시: null.builtins.diagnostics.mypy,
  },
})

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

-- =========================
-- lua parse
-- =========================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "lua" },
  highlight = { enable = true },
  indent = { enable = true },
})

