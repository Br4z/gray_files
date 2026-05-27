local M = {}

local terminal_colors = {
  "#1C1C1C", -- black
  "#AF5F5F", -- red
  "#5F875F", -- green
  "#87875F", -- yellow
  "#5F87AF", -- blue
  "#5F5F87", -- magenta
  "#5F8787", -- cyan
  "#BCBCBC", -- white
  "#444444", -- black_light
  "#D78787", -- red_light
  "#87AF87", -- green_light
  "#FFFFAF", -- yellow_light
  "#87AFD7", -- blue_light
  "#8787AF", -- magenta_light
  "#5FAFAF", -- cyan_light
  "#FFFFFF", -- white_light
}

local function apply_terminal_colors()
  for index, color in ipairs(terminal_colors) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = "apprentice-modern"

  apply_terminal_colors()

  for group, options in pairs(require("themes.apprentice.groups")) do
    vim.api.nvim_set_hl(0, group, options)
  end
end

return M
