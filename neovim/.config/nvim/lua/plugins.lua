return require('packer').startup(function(use)
	use 'rebelot/kanagawa.nvim'
	use 'nvim-lua/plenary.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {'neoclide/coc.nvim', branch = 'release'}
	use {
		'tanvirtin/vgit.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}
	use {
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
end)
