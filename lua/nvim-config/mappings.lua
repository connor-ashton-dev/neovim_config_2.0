local opts = { noremap = true, silent = true }

--local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--MOVES BLOCKS OF TEXT
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

--KEEPS CURSOR IN THE MIDDLE OF SCREEN WHEN...
--jumping around with c and d
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-e>", "10zl", opts)
keymap("n", "<C-w>", "10zh", opts)

--remove highlight with ESC
keymap("n", "<ESC>", ":nohl<CR>", opts)

-- grepping
-- keymap("n", "n", "nzzzv", opts)
-- keymap("n", "N", "Nzzzv", opts)

--FILE STUFF
--save and format
-- keymap("n", "<leader>w", ":w<CR>", opts)
--mega quit
-- keymap("n", "<leader>K", ":xa!<CR>", opts)
--kinda quit
-- keymap("n", "<leader>q", ":q!<CR>", opts)

--keeps current item in buffer when you past over something
keymap("x", "<leader>p", [["_dP]], opts)

--see all todo comments
-- keymap("n", "<leader>vc", ":TodoTelescope<CR>", opts)

--see errors
-- keymap("n", "<leader>ve", ":TroubleToggle<CR>", opts)

--BUFFERS
--list buffers and switch
-- keymap("n", "<leader>bc", ":Bdelete<CR>", opts)
-- keymap("n", "<leader>bp", ":bprevious<CR>", opts)
-- keymap("n", "<leader>bn", ":bnext<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- PWD
-- keymap("n", "<leader>d", ":! pwd<CR>", opts)

--explorer
-- keymap("n", "<leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

--copilot STUFF
-- keymap("n", "<leader>gce", ":Copilot enable<CR>", { silent = false })
-- keymap("n", "<leader>gcd", ":Copilot disable<CR>", { silent = false })
-- keymap("n", "<leader>gcs", ":Copilot status<CR>", opts)

--TELESCOPE BINDINGS
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
-- vim.keymap.set("n", "<leader>fg", builtin.git_files, opts)
-- vim.keymap.set("n", "<leader>bl", builtin.buffers, opts)
-- vim.keymap.set("n", "<leader>ft", builtin.live_grep, opts)
-- vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
-- vim.keymap.set("n", "<leader>vk", builtin.keymaps, opts)
-- vim.keymap.set("n", "<leader>fv", builtin.treesitter, opts)
-- vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, opts)
-- vim.keymap.set("n", "<leader>vh", builtin.command_history, opts)
-- vim.keymap.set("n", "<leader>fo", builtin.oldfiles, opts)
-- vim.keymap.set("n", "<leader>vo", builtin.vim_options, opts)

vim.keymap.set("v", "cr", "<Plug>SnipRun", opts)
vim.keymap.set("n", "<leader>co", "<Plug>SnipRunOperator", opts)
vim.keymap.set("n", "<leader>cr", "<Plug>SnipRun", opts)
