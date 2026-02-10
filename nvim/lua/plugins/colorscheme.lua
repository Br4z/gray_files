return {
	{
		"romainl/Apprentice",
		lazy = false, -- Make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- Make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme "apprentice"

			if vim.fn.has("termguicolors") == 1 then
				vim.opt.termguicolors = true
			end
		end
	}
}
