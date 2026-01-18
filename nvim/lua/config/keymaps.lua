local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- --------------------------------- NORMAL --------------------------------- --

-- Better window navigation
keymap("n", "<A-i>", "<C-w>k", opts)
keymap("n", "<A-o>", "<C-w>l", opts)
keymap("n", "<A-e>", "<C-w>j", opts)
keymap("n", "<A-n>", "<C-w>h", opts)
keymap("n", "<LEADER>p", "<C-w>p", opts)

-- Quick exit
keymap("n", "<LEADER>q", ":wq<CR>", opts)
keymap("n", "<LEADER>Q", ":q!<CR>", opts)

-- Quick write
keymap("n", "<LEADER>w", ":w<CR>", opts)

-- Resize with arrows
keymap("n", "<C-UP>", ":resize -2<CR>", opts)
keymap("n", "<C-RIGHT>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-DOWN>", ":resize +2<CR>", opts)
keymap("n", "<C-LEFT>", ":vertical resize -2<CR>", opts)

-- Buffers
keymap("n", "<S-o>", ":bnext<CR>", opts)
keymap("n", "<S-n>", ":bprevious<CR>", opts)
keymap("n", "<LEADER>c", ":bw<CR>", opts)

-- --------------------------------- VISUAL --------------------------------- --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-e>", ":m .+1<CR>==", opts)
keymap("v", "<A-i>", ":m .-2<CR>==", opts)

-- ------------------------------ VISUAL BLOCK ------------------------------ --

-- Move text up and down
keymap("x", "<A-e>", ":move \">+1<CR>gv-gv", opts)
keymap("x", "<A-i>", ":move \"<-2<CR>gv-gv", opts)

-- Delete single character without copying into register
keymap("n", "x", '_x', opts)

-- Increment/decrement numbers
keymap("n", "<LEADER>+", "<C-a>", opts)
keymap("n", "<LEADER>-", "<C-x>", opts)

-- Window management
keymap("n", "<LEADER>sv", "<C-w>v", opts) -- Split window vertically
keymap("n", "<LEADER>sh", "<C-w>s", opts) -- Split window horizontally
keymap("n", "<LEADER>se", "<C-w>=", opts) -- Make split windows equal width and height
keymap("n", "<LEADER>sx", ":close<CR>", opts) -- Close current split window

-- Clear search highlights
keymap("n", "<LEADER>h", ":nohl<CR>", opts)

-- Explorer
keymap("n", "<LEADER>e", ":Lexplore<CR>", opts)

-- Telescope
keymap("n", "<LEADER>ff", ":Telescope find_files<CR>", opts) -- Find files within current working directory, respects .gitignore
keymap("n", "<LEADER>fs", ":Telescope live_grep<CR>", opts) -- Find string in current working directory as you type
keymap("n", "<LEADER>fc", ":Telescope grep_string<CR>", opts) -- Find string under cursor in current working directory
keymap("n", "<LEADER>fb", ":Telescope buffers<CR>", opts) -- List open buffers in current neovim instance
keymap("n", "<LEADER>fh", ":Telescope help_tags<CR>", opts)

-- ------------------------------- COLEMAK DH ------------------------------- --
-- n = h, e = j, i = k, o = l

local modes = { "n", "v", "x", "o" }
for _, mode in ipairs(modes) do
	-- Navigation
	keymap(mode, "n", "h", opts)
	keymap(mode, "e", "j", opts)
	keymap(mode, "i", "k", opts)
	keymap(mode, "o", "l", opts)

	-- k -> n (Next search)
	keymap(mode, "k", "n", opts)
	keymap(mode, "K", "N", opts)

	-- j -> e (End of word)
	keymap(mode, "j", "e", opts)
	keymap(mode, "J", "E", opts)

	-- l -> i (Insert)
	keymap(mode, "l", "i", opts)
	keymap(mode, "L", "I", opts)

	-- h -> o (Open line)
	keymap(mode, "h", "o", opts)
	keymap(mode, "H", "O", opts)
end
