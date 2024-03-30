local configs = require("nvchad.configs.lspconfig")
local util = require("lspconfig.util")

local servers = {
	bashls = {},
	gopls = {},
	jsonls = {},
	lua_ls = {
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- Depending on the usage, you might want to add additional paths here.
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					},
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file("", true)
				},
			})
		end,
		settings = {
			Lua = {},
		},
	},
	pyright = {},
	ruff_lsp = {},
	rust_analyzer = {
		root_dir = util.root_pattern("Cargo.toml"),
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
				},
			},
		},
	},
	vale_ls = {},
	yamlls = {
		settings = {
			yaml = {
				schemas = {
					["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
				},
			},
		},
	},
}

for name, opts in pairs(servers) do
	if not opts.on_init then
		opts.on_init = configs.on_init
	end
	opts.on_attach = configs.on_attach
	opts.capabilities = configs.capabilities

	require("lspconfig")[name].setup(opts)
end
