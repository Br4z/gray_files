-- If Neovim is reading from stdin (e.g., kitty scrollback_pager uses "-")
local is_stdin = (vim.fn.argc() >= 1 and vim.fn.argv(0) == "-")
if is_stdin then
  return
end

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvimdev/dashboard-nvim",
}, {
  load = true,
  confirm = false,
})

require("plugins.colorscheme")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.dashboard")
