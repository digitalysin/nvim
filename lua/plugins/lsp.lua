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

			-- setup jdtls
			local jdtls = require("jdtls")
			local root_markers = { "gradlew", ".git" }
			local root_dir = require("jdtls.setup").find_root(root_markers)
			local home = os.getenv("HOME")
			local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

			lspconfig.jdtls.setup({
				settings = {
					java = {
						signatureHelp = { enabled = true },
						contentProvider = { preferred = "fernflower" },
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
							},
							filteredTypes = {
								"com.sun.*",
								"io.micrometer.shaded.*",
								"java.awt.*",
								"jdk.*",
								"sun.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							},
							hashCodeEquals = {
								useJava7Objects = true,
							},
							useBlocks = true,
						},
						configuration = {
							runtimes = {
								{
									name = "JavaSE-1.8",
									path = home .. "/.asdf/installs/java/corretto-8.362.08.1",
								},
								{
									name = "JavaSE-11",
									path = home .. "/.asdf/installs/java/adoptopenjdk-11.0.21+9",
								},
								{
									name = "JavaSE-17",
									path = home .. "/.asdf/installs/java/adoptopenjdk-17.0.10+7",
								},
								{
									name = "JavaSE-20",
									path = home .. "/.asdf/installs/java/openjdk-20.0.1",
								},
								{
									name = "JavaSE-21",
									path = home .. "/.asdf/installs/java/openjdk-21.0.1",
								},
							},
						},
					},
				},
				cmd = {
					home .. "/.asdf/installs/java/adoptopenjdk-17.0.10+7/bin/java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx4g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.glob(home .. "/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
					"-configuration",
					home .. "/.local/share/jdtls/config_mac",
					"-data",
					workspace_folder,
				},
			})

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
