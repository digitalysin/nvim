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

require("global")
require("lazy").setup("plugins")

require("configs/mappings")

vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

vim.g.OmniSharp_server_stdio = 1
vim.g.OmniSharp_server_parth = home .. "/.local/share/omnisharp"
-- vim.api.nvim.set_var("OmniSharp_server_stdio", 0)
-- vim.api.nvim.set_var("OmniSharp_server_path", home .. "/.local/share/omnisharp")
