return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "go", "java", "rust", "python", "javascript", "typescript", "elixir", "html", "css" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
