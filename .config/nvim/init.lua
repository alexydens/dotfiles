-- package manager (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then 
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- colors
vim.cmd("colorscheme everforest")
vim.cmd("syntax on")
vim.opt.bg = "dark"
vim.opt.hlsearch = true
vim.opt.colorcolumn = "80"

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- no swap file, no mouse
vim.opt.swapfile = false
vim.opt.mouse = ""

-- 2-space tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- clear search buffer
vim.api.nvim_create_user_command(
  "ClearSearch",
  function()
    vim.cmd("let @/ =''")
  end,
  {nargs = 0}
)

-- exit terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
-- split screen
vim.keymap.set("n", "<C-n>", "<C-w>w")
vim.keymap.set("n", "<C-l>", "<C-w><")
vim.keymap.set("n", "<C-h>", "<C-w>>")
vim.keymap.set("n", "<C-k>", "<C-w>+")
vim.keymap.set("n", "<C-j>", "<C-w>-")

vim.keymap.set("n", "<C-o>t", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-Left>", "<CMD>tabprev<CR>")
vim.keymap.set("n", "<C-Right>", "<CMD>tabnext<CR>")
