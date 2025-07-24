return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true, },
      ensure_installed = {
        "c", "cpp", "cmake", "make",
        "lua", "vim", "vimdoc",
        "javascript", "html", "css",
        "markdown",
        "glsl",
        "python",
        "rust",
        "zig",
      },
    })
  end
}
