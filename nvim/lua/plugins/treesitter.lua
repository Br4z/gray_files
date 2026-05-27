-- Native Tree-sitter can highlight a filetype when its parser and query files
-- already exist on runtimepath. This file does not install parsers.
local filetypes = {
  "c",
  "cpp",
  "html",
  "javascript",
  "json",
  "latex",
  "lua",
  "markdown",
  "query",
  "tex",
  "vim",
  "vimdoc",
}

vim.treesitter.language.register("latex", "tex")

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
