return {
	"folke/neoconf.nvim",
	config = function()
		-- keybinding
		vim.keymap.set("n", "<leader>nl", ":Neoconf local<CR>")
		vim.keymap.set("n", "<leader>ng", ":Neoconf global<CR>")
    vim.keymap.set("n", "<leader>ns", ":Neoconf show<CR>")
	end,
}
