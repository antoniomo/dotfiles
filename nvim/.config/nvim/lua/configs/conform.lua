local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		markdown = { "mdformat" },
		python = { "ruff" },
		rust = { "rustfmt" },
		sh = { "shfmt" },
		yaml = { "yamlfmt" },
	},
	format_on_save = {
		async = true,
		lsp_fallback = true,
	},
	formatters = {
		ruff = {
			command = "ruff",
			args = { "format", "$FILENAME" },
			stdin = false,
		},
	},
}

require("conform").setup(options)
