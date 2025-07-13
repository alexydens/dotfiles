return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        autoformat = false,
        ensure_installed = {
          "ccls",
          "zls",
          "rust_analyzer",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = true,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfnig", {}),
        callback = function(ev)
          local lsp_opts = { buffer = ev.buf }
          vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format, lsp_opts)
          vim.keymap.set("n", "K", vim.losp.buf.hover, lsp_opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaraction, lsp_opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, lsp_opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, lsp_opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts)
          vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, lsp_opts)
        end,
      })
    end
  }
}
