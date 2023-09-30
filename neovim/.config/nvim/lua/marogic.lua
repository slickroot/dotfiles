require('telescope').setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = { height = 1 },
		theme = 'dropdown',
	},
	pickers = {
		git_files = {
			theme = 'dropdown',
		},
		buffers = {
			theme = 'dropdown',
		}
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>o', function() builtin.git_files({ show_untracked = true}) end, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

-- Coc.nvim
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
local keyset = vim.keymap.set
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- VGit
require('vgit').setup()

-- Tree Sitter 
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "vue" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.treesitter.language.register("bash", "zsh")
