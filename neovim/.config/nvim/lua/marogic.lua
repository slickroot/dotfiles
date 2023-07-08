require('telescope').setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = { height = 1 },
		theme = 'dropdown',
	},
	pickers = {
		find_files = {
			theme = 'dropdown',
		},
		buffers = {
			theme = 'dropdown',
		}
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>o', builtin.find_files, {})

-- Coc.nvim
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
local keyset = vim.keymap.set
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- VGit
require('vgit').setup()
