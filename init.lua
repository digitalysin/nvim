local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local home = os.getenv("HOME")

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.o.foldmethod = 'manual'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false

require("global")
require("lazy").setup("plugins")

require("configs/mappings")

vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

local neotest_golang_opts = {
  testify_enabled = true,
}

require("lspconfig").gleam.setup({})
require("neotest").setup({
  adapters = {
    require("neotest-golang")(neotest_golang_opts),
    require("neotest-java")({
      incremental_build = true,
    }),
  },
})
