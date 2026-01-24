--[[ return {
	"f4z3r/gruvbox-material.nvim",
	name = "gruvbox-material",
	lazy = false,
	priority = 1000,
	opts = {},
}
]]
--

return {
	"thesimonho/kanagawa-paper.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("kanagawa-paper")
	end,
	opts = { ... },
}
