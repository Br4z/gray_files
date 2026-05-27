require("dashboard").setup({
  shortcut_type = "number",
  config = {
    header = {
      "",
      " ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
      " ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
      "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
      "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
      "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
      "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
      "░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░",
      "   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ",
      "         ░    ░  ░    ░ ░        ░   ░         ░   ",
      "                                ░                  ",
      "",
    },
    shortcut = {
      {
        icon = " ",
        desc = "file browser",
        group = "Label",
        action = "Telescope find_files",
        key = "<leader>ff",
      },
      {
        icon = " ",
        desc = "find file",
        group = "Label",
        action = "lua require('telescope.builtin').find_files({hidden=true})",
        key = "<leader>fa",
      },
      {
        icon = " ",
        desc = "dotfiles",
        group = "Label",
        action = function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        key = "<leader>fd",
      }
    },
    footer = {
      "NOW THE MOON IS RISING",
    }
  }
})
