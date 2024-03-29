-- Completion Plugin Setup
local cmp = require("cmp")

local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "󱀆",
	Class = "󱆀",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "󰇽",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "󰛦",
}
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		-- ["<Tab>"] = cmp.mapping.select_next_item(),

		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	-- Installed sources:

	sources = {
		{ name = "path" }, -- file paths
		-- { name = "nvim_lsp", keyword_length = 3 }, -- from language server
		{ name = "nvim_lsp" }, -- from language server
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "nvim_lua" }, -- complete neovim's Lua runtime API such vim.lsp.*
		-- { name = "buffer", keyword_length = 2 }, -- source current buffer
		{ name = "buffer" }, -- source current buffer
		-- { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		--{ name = "vsnip" }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" }, -- source for math calculation
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "[LSP]",
				luasnip = "[SNIPPET]",
				buffer = "[BUFF]",
				path = "[PATH]",
				calc = "[CALC]",
			}
			-- Kind icons
			item.kind = string.format("%s", kind_icons[item.kind])
			--	item.kind = string.format("%s %s", kind_icons[item.kind], item.kind) -- This concatonates the icons with the name of the item kind

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
})
