-- Plugins

-- Packer - init{{{
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost *nvim/init.lua,*nvim/lua/*.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use

require("packer").config = {
    profile = {
        enable = true,
        threshold = 1
    }
}
--}}}

-- Plugins{{{
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    -- Modes{{{
        use 'simeji/winresizer'
        use 'sindrets/winshift.nvim'
        use 'fidian/hexmode'
        use 'liuchengxu/vista.vim'
        use 'junegunn/limelight.vim'
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use 'mbbill/undotree'
        use "numtostr/FTerm.nvim"

        use 'mfussenegger/nvim-dap'
        use 'rcarriga/nvim-dap-ui'
        use 'theHamsta/nvim-dap-virtual-text'

        use 'mfussenegger/nvim-dap-python'

        use 'ggandor/lightspeed.nvim'
--}}}
    -- Aesthetics{{{
        use 'nvim-lualine/lualine.nvim'
        use {
            'akinsho/nvim-bufferline.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use 'nvim-treesitter/nvim-treesitter'
        use 'nvim-treesitter/playground'

        use 'p00f/nvim-ts-rainbow'

        -- Themes
        -- use 'EdenEast/nightfox.nvim'
        -- use 'navarasu/onedark.nvim'
        -- use 'shaunsingh/nord.nvim'
        -- use 'morhetz/gruvbox'
        -- use 'marko-cerovac/material.nvim'
        use "atalazer/wally.nvim"

        -- use 'code-biscuits/nvim-biscuits'
--}}}
    -- Languages & Filetypes{{{
        -- Ansible
            use 'pearofducks/ansible-vim'
        -- GPG
            use 'jamessan/vim-gnupg'
        -- C
            use 'rhysd/vim-clang-format'
        -- CSV
            use 'chrisbra/csv.vim'
        -- Python
            use {
                'davidhalter/jedi-vim',
                'raimon49/requirements.txt.vim',
                'psf/black',
                ft = {'py', 'requirements'}
            }
        -- Go
            use {
            --     -- 'fatih/vim-go',
                'ray-x/go.nvim'
            }
        -- Rust
            use {
                'rust-lang/rust.vim',
                ft = {'rust'}
            }
        -- Openscad (kinda)
            use 'sirtaj/vim-openscad'
        -- markdown
            use {'plasticboy/vim-markdown',
                requires = 'godlygeek/tabular'
            }

--}}}
    -- LSP & Completion {{{
        -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
        use 'neovim/nvim-lspconfig'
        use 'williamboman/nvim-lsp-installer'

        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-look'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-calc'
        use 'hrsh7th/cmp-nvim-lua'
        use 'f3fora/cmp-spell'

        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'
        use 'rafamadriz/friendly-snippets'

        use 'ray-x/lsp_signature.nvim'

        use 'onsails/lspkind-nvim'

        use 'windwp/nvim-autopairs'

        -- use 'mfussenegger/nvim-lint'
        use 'dense-analysis/ale'

        use 'tami5/lspsaga.nvim'
--}}}
    -- Misc{{{
        use 'powerman/vim-plugin-AnsiEsc'

        use 'tpope/vim-obsession'

        -- use 'windwp/nvim-autopairs'
        use 'rcarriga/nvim-notify'

        use 'folke/which-key.nvim'

        use 'kazhala/close-buffers.nvim'

        -- tmux stuff
        use 'christoomey/vim-tmux-navigator'
        use({
            "aserowy/tmux.nvim",
            config = function()
                require("tmux").setup({
                    copy_sync = {
                        enable = false,
                    },
                    navigation = {
                        enable_default_keybindings = false,
                    },
                    resize = {
                        enable_default_keybindings = false,
                    }
                })
            end
        })

        use 'edluffy/specs.nvim'

        use 'norcalli/nvim-colorizer.lua'

        use 'nvim-lua/plenary.nvim'

        use 'junegunn/fzf'
        use 'junegunn/fzf.vim'

        use 'nvim-telescope/telescope.nvim'

        use 'tpope/vim-fugitive'
        use 'tpope/vim-rhubarb'
        use 'tpope/vim-commentary'

        use 'mhinz/vim-startify'

        use "lukas-reineke/indent-blankline.nvim"

        use 'lewis6991/gitsigns.nvim'
--}}}
end)
--}}}

