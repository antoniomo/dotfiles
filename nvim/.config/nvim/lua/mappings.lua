require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "window left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "window up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "window right" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "window previous" })
