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

-- Status Line
require('lualine').setup {
  options = { 
    section_separators = '', 
    component_separators = '',
    globalstatus = true
  },
  sections = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}

-- Tree Sitter
-- bash is here so the zsh registration below has a parser to use
require('nvim-treesitter').install {
  'c', 'lua', 'vim', 'vimdoc', 'query', 'bash', 'vue',
  'javascript', 'jsdoc', 'typescript', 'tsx',
  'json', 'html', 'css', 'scss',
  'markdown', 'markdown_inline', 'python', 'yaml', 'toml', 'diff',
}

vim.treesitter.language.register('bash', 'zsh')

-- highlighting comes from neovim itself now, it is not enabled by the plugin.
-- keyed off whatever parser is actually installed rather than a hand-kept
-- filetype list, so adding a parser above is enough; when there is no parser
-- start() fails and the buffer keeps vim's regex syntax
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})

-- VimTEX
vim.g.vimtex_view_method = 'zathura' -- Use Zathura as the PDF viewer
vim.g.vimtex_compiler_method = 'latexmk' -- Use latexmk for compilation
