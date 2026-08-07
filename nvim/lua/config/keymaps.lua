--  Layout permutation, shared with the VSCode and Zed configs:
--
--      n e i o -> h j k l  (left / down / up / right)
--      h j k l -> o e n i  (open line / end of word / search / insert)
--
--  The same eight letters are reused uppercase, and in the window-command
--  and resize families below

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- --------------------------------------------------------------------------
--                             LAYOUT PERMUTATION
-- --------------------------------------------------------------------------

for _, mode in ipairs({ "n", "x", "o" }) do
  map(mode, "i", "k", { desc = "Up" })
  map(mode, "o", "l", { desc = "Right" })
  map(mode, "e", "j", { desc = "Down" })
  map(mode, "n", "h", { desc = "Left" })

  map(mode, "l", "i", { desc = "Insert / inner object" })
  map(mode, "L", "I", { desc = "Insert at first non-blank" })

  map(mode, "j", "e", { desc = "End of word" })
  map(mode, "J", "E", { desc = "End of WORD" })

  map(mode, "k", "n", { desc = "Next match" })
  map(mode, "K", "N", { desc = "Previous match" })

  -- Completes the uppercase half of the permutation. Without these, N and O
  -- keep firing vim's own N and O, duplicating K and H
  map(mode, "N", "H", { desc = "Top of screen" })
  map(mode, "O", "L", { desc = "Bottom of screen" })
end

-- h/H are open-line in normal and other-end-of-selection in visual
-- Neither means anything in operator-pending, so "o" is excluded
for _, mode in ipairs({ "n", "x" }) do
  map(mode, "h", "o", { desc = "Open line below / other end" })
  map(mode, "H", "O", { desc = "Open line above / other end" })
end

-- The three permutation slots that are commands rather than key remaps

-- I sits in the K slot. Native K is keywordprg; LSP hover is the modern one
map("n", "I", vim.lsp.buf.hover, { desc = "Hover" })

-- E sits in the J slot
map("n", "E", "J", { desc = "Join lines" })

map("x", "E", ":move '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("x", "I", ":move '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Stay in indent mode
map("x", "<", "<gv", { desc = "Outdent, keep selection" })
map("x", ">", ">gv", { desc = "Indent, keep selection" })

-- --------------------------------------------------------------------------
--                             WINDOW MANAGEMENT
-- --------------------------------------------------------------------------

-- Single-keypress alternative, only if your terminal separates <C-i> from <Tab>:
map("n", "<C-i>", "<C-w>k", { desc = "Window up" })
map("n", "<C-o>", "<C-w>l", { desc = "Window right" })
map("n", "<C-e>", "<C-w>j", { desc = "Window down" })
map("n", "<C-n>", "<C-w>h", { desc = "Window left" })

-- Multi-keypress alternative, works in all terminals:
-- map("n", "<C-w>i", "<C-w>k", { desc = "Window up" })
-- map("n", "<C-w>o", "<C-w>l", { desc = "Window right" })
-- map("n", "<C-w>e", "<C-w>j", { desc = "Window down" })
-- map("n", "<C-w>n", "<C-w>h", { desc = "Window left" })

-- <C-w>o (only) and <C-w>n (new) are shadowed by the above, so they move here
map("n", "<LEADER>so", "<C-w>o", { desc = "Close other windows" })
map("n", "<LEADER>sn", "<C-w>n", { desc = "New empty window" })

-- Splits
map("n", "<LEADER>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<LEADER>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<LEADER>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<LEADER>sw", "<CMD>close<CR>", { desc = "Close split" })

-- Monocle. <LEADER>se above is the way back out
map("n", "<LEADER>m", "<C-w>_<C-w>|", { desc = "Maximize window" })

-- Resize. Same directions as the VSCode alt+ bindings
map("n", "<A-i>", "<CMD>resize -2<CR>", { desc = "Decrease height" })
map("n", "<A-e>", "<CMD>resize +2<CR>", { desc = "Increase height" })
map("n", "<A-o>", "<CMD>vertical resize +2<CR>", { desc = "Increase width" })
map("n", "<A-n>", "<CMD>vertical resize -2<CR>", { desc = "Decrease width" })


-- --------------------------------------------------------------------------
--                                  BUFFERS
-- --------------------------------------------------------------------------

map("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<LEADER>bw", "<CMD>bw<CR>", { desc = "Wipe buffer" })
-- map("n", "<LEADER>w", "<CMD>bw<CR>",   { desc = "Close buffer" })
-- map("n", "<LEADER>W", "<CMD>%bw<CR>",  { desc = "Close all buffers" })

-- Quick write / exit
map("n", "<LEADER>w", "<CMD>w<CR>", { desc = "Write" })
map("n", "<LEADER>q", "<CMD>wq<CR>", { desc = "Write and quit" })
map("n", "<LEADER>Q", "<CMD>q!<CR>", { desc = "Quit without saving" })

-- --------------------------------------------------------------------------
--                                    LSP
-- --------------------------------------------------------------------------

-- Coding
map("n", "<LEADER>cc", "gcc", { remap = true, desc = "Toggle comment" })
map("x", "<LEADER>cc", "gc", { remap = true, desc = "Toggle comment" })
map("n", "<LEADER>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<LEADER>cs", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<LEADER>cas", "<CMD>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

-- Go to
map("n", "<LEADER>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<LEADER>gr", "<CMD>Telescope lsp_references<CR>", { desc = "References" })
map("n", "<LEADER>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

-- --------------------------------------------------------------------------
--                                   SEARCH
-- --------------------------------------------------------------------------

map("n", "<LEADER>h", "<CMD>nohl<CR>", { desc = "Clear search highlight" })

-- Explorer
map("n", "<LEADER>e", "<CMD>Lexplore<CR>", { desc = "Toggle explorer" })

-- Telescope
map("n", "<LEADER>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<LEADER>fs", "<CMD>Telescope live_grep<CR>", { desc = "Grep workspace" })
map("n", "<LEADER>fc", "<CMD>Telescope grep_string<CR>", { desc = "Grep word under cursor" })
map("n", "<LEADER>fb", "<CMD>Telescope buffers<CR>", { desc = "List buffers" })
map("n", "<LEADER>fh", "<CMD>Telescope help_tags<CR>", { desc = "Help tags" })

-- --------------------------------------------------------------------------
--                                   NUMBERS
-- --------------------------------------------------------------------------

map("n", "<LEADER>+", "<C-a>", { desc = "Increment" })
map("n", "<LEADER>-", "<C-x>", { desc = "Decrement" })

-- --------------------------------------------------------------------------
--                                    DEBUG
-- --------------------------------------------------------------------------

-- local dap = require("dap")
-- map("n", "<LEADER>da", dap.continue,          { desc = "Start / continue" })
-- map("n", "<LEADER>dt", dap.terminate,         { desc = "Terminate" })
-- map("n", "<LEADER>do", dap.step_over,         { desc = "Step over" })
-- map("n", "<LEADER>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
-- map("n", "<LEADER>de", function() require("dap.ui.widgets").hover() end, { desc = "Debug hover" })
-- map("n", "<LEADER>dc", dap.continue,          { desc = "Continue" })
