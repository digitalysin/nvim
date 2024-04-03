local wk = require("which-key")

local opts = {
	prefix = "<leader>",
}

-- register mapping for file navigation
wk.register({
	f = {
		name = "File Navigation",
		d = { "<cmd>Neotree filesystem reveal left toggle<cr>", "Show file system tree" },
		f = { "<cmd>Telescope find_files<cr>", "Find all files" },
		g = { "<cmd>Telescope live_grep<cr>", "Find all files by grep" },
		b = { "<cmd>Telescope buffers<cr>", "Find all buffers" },
	},
}, opts)

-- register mapping for buffer deletion
wk.register({
	b = {
		name = "Buffer Manipulation",
		d = { "<cmd>BufDel<cr>", "Delete current buffer" },
	},
}, opts)

-- register mapping for code navigation, formatting and linter
wk.register({
	c = {
		name = "Code navigation",
		K = {
			function()
				vim.lsp.buf.hover()
			end,
			"Show documentation",
		},
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
		t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>SymbolsOutline<cr>", "Show structure" },
		f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format source code" },
	},
}, opts)

-- register for debugging
local dap = require("dap")

wk.register({
	d = {
		name = "Debugging",
		t = {
			function()
				dap.toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		c = {
			function()
				dap.continue()
			end,
			"Continue debugging",
		},
		n = {
			function()
				dap.step_over()
			end,
			"Step over",
		},
		i = {
			function()
				dap.step_into()
			end,
			"Step into",
		},
		o = {
			function()
				dap.step_out()
			end,
			"Step out",
		},
		u = { "<cmd>JdtUpdateDebugConfig<cr>", "Update debug config" },
	},
}, opts)

-- register for terminal
local term = require("nvterm.terminal")

wk.register({
	t = {
		h = {
			function()
				term.toggle("horizontal")
			end,
			"Lauch horizontal terminal",
		},
		v = {
			function()
				term.toggle("vertical")
			end,
			"Launch vertical terminal",
		},
		f = {
			function()
				term.toggle("float")
			end,
			"Launch floating terminal",
		},
		g = {
			function()
				term.send("lazygit", "float")
			end,
			"Launch git terminal",
		},
	},
}, opts)

-- neogit
local neogit = require("neogit")

wk.register({
	k = {
		o = {
			function()
				neogit.open()
			end,
			"Open neogit",
		},
		d = {
			"<cmd>DiffviewOpen<CR>",
			"Open diff tool",
		},
		h = {
			"<cmd>DiffviewFileHistory<CR>",
			"Open diff file history",
		},
	},
}, opts)

-- register copilot chat
local chat = require("CopilotChat")
local actions = require("CopilotChat.actions")
local integration = require("CopilotChat.integrations.fzflua")

local function pick(pick_actions)
	return function()
		integration.pick(pick_actions(), {
			fzf_tmux_opts = {
				["-d"] = "45%",
			},
		})
	end
end

wk.register({
	a = {
		a = {
			function()
				chat.toggle()
			end,
			"Toogle Copilot Chat",
		},
		x = {
			function()
				chat.reset()
			end,
			"Reset Copilot Chat",
		},
		h = {
			function()
				pick(actions.help_actions)
			end,
			"AI Help Actions",
		},
		p = {
			function()
				pick(actions.prompt_actions)
			end,
			"AI Help Actions",
		},
	},
}, opts)
