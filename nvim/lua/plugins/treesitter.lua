return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"javascript",
				"html",
				"cpp",
				"json",
				"latex" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		}
	}
}
