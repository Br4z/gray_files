return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { {"nvim-tree/nvim-web-devicons"} },
		opts = {
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
						icon    = " ",
						desc    = "file browser",
						group   = "Label",
						action  = "Telescope find_files",
						key     = "f",
					},
					{
						icon   = " ",
						desc   = "find file",
						group  = "Label",
						action = "lua require('telescope.builtin').find_files({hidden=true})",
						key    = "a",
					},
					{
						icon   = " ",
						desc   = "dotfiles",
						group  = "Label",
						action = function()
							require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
						end,
						key    = "d",
					}
				},
				footer = {
					"NOW THE MOON IS RISING",
				}
			}
		}
	}
}
