-- packages
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/sainnhe/everforest" },
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- configs for packages
require("lualine").setup({})
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = {
    "c", "cpp", "cmake", "make",
    "lua", "vim", "vimdoc",
    "javascript", "html", "css",
    "markdown",
    "glsl",
    "python",
    "rust",
    "zig"
  }
})
require("mason").setup({})
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
  },
  signs_staged_enable = false,
})

-- language servers
vim.lsp.enable("lua_ls")

-- lsp
-- vim.api.nvim_create_autocmd('LspAttach', {
  -- callback = function(args)
    -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  -- end,
-- })

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- colour/theme stuff
vim.cmd("colorscheme vague")
vim.cmd("syntax on")
vim.opt.bg = "dark"
vim.opt.hlsearch = true
vim.opt.colorcolumn = "80"
-- vim.opt.winborder = "bold"

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- no swapfile or mouse
vim.opt.swapfile = false
vim.opt.mouse = ""

-- 2-space tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- clear search buffer
-- vim.api.nvim_create_user_command(
--   "ClearSearch",
--   function()
--     vim.cmd("let @/ =''")
--   end,
--   {nargs = 0}
-- )
vim.keymap.set("n", "<C-c>", "<CMD>let @/ = ''<CR>")

-- exit terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
-- split screen
vim.keymap.set("n", "<C-n>", "<C-w>w")
vim.keymap.set("n", "<C-l>", "<C-w><")
vim.keymap.set("n", "<C-h>", "<C-w>>")
vim.keymap.set("n", "<C-k>", "<C-w>+")
vim.keymap.set("n", "<C-j>", "<C-w>-")
-- tabs
vim.keymap.set("n", "<C-o>t", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-Left>", "<CMD>tabprev<CR>")
vim.keymap.set("n", "<C-Right>", "<CMD>tabnext<CR>")
