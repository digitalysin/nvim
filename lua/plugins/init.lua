return {
	-- buffer deletion
	{
		"ojroques/nvim-bufdel",
		config = function()
			require("bufdel").setup({
				next = "tabs",
			})
		end,
	},

	--- theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},

	-- completion
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
				}, {
					{
						name = "buffer",
					},
				}),
			})

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	-- LSP
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
					"omnisharp",
					"lemminx",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
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

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				filtetypes = { "cs", "csproj", "sln" },
				single_file_support = true,
				cmd = { "omnisharp" },
			})
		end,
	},

	-- null ls for formatting linters etc
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- lua formatting
					null_ls.builtins.formatting.stylua,

					-- golang formatting
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.golines,

					-- c# formatting
					null_ls.builtins.formatting.csharpier,

					-- java formatting
					null_ls.builtins.formatting.google_java_format,
				},

				on_attach = function(client, bufnr)
					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})

						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},

	-- lua line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "dracula",
				},
			})
		end,
	},

	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
	},

	-- jdtls
	{
		"mfussenegger/nvim-jdtls",
	},

	-- symbol outline
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({})
		end,
	},

	-- pairs for brackets and square etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- telescope ui
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},

	-- terminal
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup({
				terminals = {
					shell = vim.o.shell,
					list = {},
					type_opts = {
						float = {
							relative = "editor",
							row = 0.3,
							col = 0.25,
							width = 0.5,
							height = 0.4,
							border = "single",
						},
						horizontal = { location = "rightbelow", split_ratio = 0.3 },
						vertical = { location = "rightbelow", split_ratio = 0.5 },
					},
				},
				behavior = {
					autoclose_on_quit = {
						enabled = false,
						confirm = true,
					},
					close_on_exit = true,
					auto_insert = true,
				},
			})
		end,
	},

	-- treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"go",
					"java",
					"rust",
					"python",
					"javascript",
					"typescript",
					"elixir",
					"html",
					"css",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- for ctrl+D like visual studio code
	{
		"mg979/vim-visual-multi",
	},

	-- which key mapping
	{
		"folke/which-key.nvim",
		lazy = true,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
	},

	-- cmd line
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},

	-- comment
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
		config = function()
			local cmt = require("Comment")
			cmt.setup({
				mappings = {
					basic = true,
					extra = false,
				},
			})
		end,
	},

	-- git
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
}
