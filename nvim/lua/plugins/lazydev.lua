return {
	"folke/lazydev.nvim",
	ft = "lua",
	opt = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
