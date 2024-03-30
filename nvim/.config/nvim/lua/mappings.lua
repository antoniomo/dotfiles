require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

local imap = function(keys, func, desc)
	map("i", keys, func, { desc = desc })
end

local nmap = function(keys, func, desc)
	map("n", keys, func, { desc = desc })
end

nmap(";", ":", "CMD enter command mode")
imap("jk", "<ESC>", "Escape insert mode")

nmap("<C-h>", "<cmd>TmuxNavigateLeft<cr>", "window left")
nmap("<C-j>", "<cmd>TmuxNavigateDown<cr>", "window down")
nmap("<C-k>", "<cmd>TmuxNavigateUp<cr>", "window up")
nmap("<C-l>", "<cmd>TmuxNavigateRight<cr>", "window right")
nmap("<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", "window previous")
