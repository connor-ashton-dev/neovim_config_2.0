local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
		scroll_left = "<c-a>",
		scroll_right = "<c-e>",
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		n = { "g" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Glo vim.lsp.buf.format({ async = true })bal mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local function toggle_virtual_text()
	local current_config = vim.diagnostic.config()
	current_config.virtual_text = not current_config.virtual_text
	vim.diagnostic.config(current_config)
end

local mappings = {
	["e"] = { ":NvimTreeToggle<CR>", "Explorer" },
	["d"] = { ":! pwd<CR>", "PWD" },
	["w"] = { ":w<CR>", "Save" },
	["q"] = { ":conf q<CR>", "Close File" },
	["L"] = { ":conf qa<CR>", "Leave" },
	["K"] = { ":wqa<CR>", "Save and quit" },
	["u"] = { ":UndotreeToggle<CR>", "UndoTree" },
	["r"] = {
		":YabsDefaultTask<CR>",
		"Run Code",
	},
	g = {
		name = "Git",
		g = { ":LazyGit<CR>", "LazyGit" },
		f = { ":Git<CR>", "Fugitive" },
		c = {
			name = "Copilot",
			e = { ":Copilot enable<CR>", "Enable Copilot" },
			d = { ":Copilot disable<CR>", "Disable Copilot" },
			s = { ":Copilot status<CR>", "Copilot Status" },
			p = { ":Copilot panel<CR>", "Copilot Panel" },
		},
	},
	-- d = {
	-- 	name = "diagnostics",
	-- 	--goto next diagnostic but don't display float
	-- 	n = { "<cmd>lua vim.diagnostic.goto_next({float = true})<CR>", "Next Diagnostic" },
	-- 	--get previous diagnostic
	-- 	p = { "<cmd>lua vim.diagnostic.goto_prev({float = true})<CR>", "Previous Diagnostic" },
	-- },
	l = {
		name = "LSP",
		t = { toggle_virtual_text, "Toggle Virtual Text" },
	},
	v = {
		name = "View",
		c = { ":TodoTelescope<CR>", "View Comments" },
		e = { ":TroubleToggle<CR>", "View Errors" },
		d = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "View Diagnostics" },
		--get next diagnostic
		l = { ":set relativenumber!<CR>", "Toggle Relative Line Numbers" },
		k = {
			"<cmd>lua require('telescope.builtin').keymaps()<cr>",
			"View Keymaps",
		},
		h = {
			"<cmd>lua require('telescope.builtin').command_history()<cr>",
			"Command History",
		},
		o = {
			"<cmd>lua require('telescope.builtin').vim_options()<cr>",
			"Vim Opts",
		},
	},
	b = {
		name = "Buffers",
		c = { ":Bdelete<CR>", "Close Buffer" },
		p = { ":bprevious<CR>", "Previous Buffer" },
		n = { ":bnext<CR>", "Next Buffer" },
		l = {
			"<cmd>lua require('telescope.builtin').buffers()<cr>",
			"List",
		},
	},
	G = {
		name = "Go",
		r = { ":GoRun<CR>", "Run" },
		b = { ":!go build<CR>", "Build" },
	},
	n = {
		name = "Neovim",
		r = {
			name = "Reload",
			a = { ":bufdo :e!<CR>", "Reload All Buffers" },
			o = { ":e!<CR>", "Reload Current Buffer" },
		},
	},
	o = {
		name = "Obsidian",
		s = { ":ObsidianQuickSwitch<CR>", "Search For File" },
		o = { ":ObsidianOpen<CR>", "Open File" },
		n = { "ObsidianNew", "New File" },
	},
	f = {
		name = "File",
		d = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
		f = {
			":Telescope find_files<CR>",
			"Find Files",
		},
		g = {
			"<cmd>lua require('telescope.builtin').git_files()<cr>",
			"Git Files",
		},
		t = {
			"<cmd>lua require('telescope.builtin').live_grep()<cr>",
			"Grep Text",
		},
		h = {
			"<cmd>lua require('telescope.builtin').man_pages()<cr>",
			"Man Pages",
		},
		r = {
			"<cmd>lua require('telescope.builtin').lsp_references()<cr>",
			"Find References",
		},
		v = {
			"<cmd>lua require('telescope.builtin').treesitter()<cr>",
			"List Variables/Functions",
		},
		s = {
			"<cmd>lua require('telescope.builtin').spell_suggest()<cr>",
			"Spellcheck",
		},
		a = {
			"<cmd>lua local task = vim.fn.input('Enter task name: '); vim.cmd(':YabsTask ' .. task)<cr>",
			"File actions(Yabs)",
		},
		o = {
			"<cmd>lua require('telescope.builtin').oldfiles()<cr>",
			"Old Files",
		},
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
