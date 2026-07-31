-- Clone lazy.nvim itself on a fresh machine, otherwise this file blows up
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--branch=stable',
		'https://github.com/folke/lazy.nvim.git', lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000, -- load before everything else so the colorscheme is up early
		config = function()
			vim.cmd.colorscheme('tokyonight-night')
			-- colorscheme resets highlights, so our overrides go after it
			vim.cmd('highlight LineNr ctermfg=DarkGrey')
			vim.cmd('highlight CocErrorHighlight guisp=#FE5F55 gui=undercurl')
		end,
	},
	'rebelot/kanagawa.nvim',
	'lervag/vimtex', -- LaTeX support
	'nvim-lua/plenary.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{ 'neoclide/coc.nvim', branch = 'release' },
	{
		'tanvirtin/vgit.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		-- main branch: needs nvim >= 0.12 and the tree-sitter CLI
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		lazy = false, -- upstream does not support lazy-loading this one
		build = ':TSUpdate',
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
}, {
	-- everything is configured in marogic.lua, which runs right after this,
	-- so plugins load eagerly rather than on demand
	defaults = { lazy = false },
	install = { colorscheme = { 'tokyonight-night' } },
	change_detection = { notify = false },
})
