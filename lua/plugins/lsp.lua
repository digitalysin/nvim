return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"elixirls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local neoconf = require("neoconf")

			-- setup neoconf before lsp config
			neoconf.setup({})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			}, {})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "goworkd", "gotmpl" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedParams = true,
						},
					},
				},
			})

			lspconfig.elixirls.setup({
				capabilities = capabilities,
				filetypes = { "elixir", "eelixir", "heex", "surface" },
				single_file_support = true,
				cmd = { "elixir-ls" },
			}, {})

			-- to show documentation
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- for code action
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			-- for code navigation
			vim.keymap.set("n", "<leader>gc", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gdt", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, {})
		end,
	},
}
