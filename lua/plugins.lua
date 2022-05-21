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
    max_jobs = 1,
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
        use 'sindrets/winshift.nvim'
        use 'fidian/hexmode'
        -- use 'liuchengxu/vista.vim'
        -- use 'junegunn/limelight.vim'
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use {
            'mbbill/undotree',
            opt = true
        }
        use {
            "numtostr/FTerm.nvim",
            opt = true,
            config = function ()
                require'FTerm'.setup({
                    border = 'single',
                    dimensions  = {
                        height = 0.5,
                        width = 0.5,
                        x = 0.9,
                        y = 0.1
                    },
                })

                local fterm = require("FTerm")

                local lazygit = fterm:new({
                    cmd = "lazygit",
                    dimensions = {
                        height = 0.9,
                        width = 0.9
                    }
                })

                function _G.__fterm_gitui()
                    lazygit.toggle()
                end
            end
        }
        use {
            "akinsho/toggleterm.nvim",
            opt = false,
            config = function()
                require("toggleterm").setup{
                    -- size can be a number or function which is passed the current terminal
                    -- on_open = fun(t: Terminal), -- function to run when the terminal opens
                    -- on_close = fun(t: Terminal), -- function to run when the terminal closes
                    hide_numbers = true, -- hide the number column in toggleterm buffers
                    shade_filetypes = {},
                    shade_terminals = true,
                    shading_factor = '0.8', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
                    start_in_insert = true,
                    -- insert_mappings = false, -- whether or not the open mapping applies in insert mode
                    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                    persist_size = true,
                    direction = 'horizontal',
                    close_on_exit = true, -- close the terminal window when the process exits
                    shell = vim.o.shell, -- change the default shell
                    -- This field is only relevant if direction is set to 'float'
                    float_opts = {
                        -- The border key is *almost* the same as 'nvim_open_win'
                        -- see :h nvim_open_win for details on borders however
                        -- the 'curved' border is a custom border type
                        -- not natively supported but implemented in this plugin.
                        border = 'single', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
                        -- width = <value>,
                        height = 15,
                        winblend = 3,
                        highlights = {
                            border = "Normal",
                            background = "Normal",
                      }
                    }
                }
            end

        }

        use 'mfussenegger/nvim-dap'
        use 'rcarriga/nvim-dap-ui'
        use 'theHamsta/nvim-dap-virtual-text'

        use 'ggandor/lightspeed.nvim'
        -- use {
        --     "folke/zen-mode.nvim",
        --     config = function()
        --         require("zen-mode").setup {}
        --     end
        -- }
        use 'vimwiki/vimwiki'
--}}}
    -- Aesthetics{{{
        use 'nvim-lualine/lualine.nvim'
        use {
            'akinsho/nvim-bufferline.lua',
            requires = 'kyazdani42/nvim-web-devicons',
        }
        use 'nvim-treesitter/nvim-treesitter'
        -- use 'nvim-treesitter/playground'

        use 'p00f/nvim-ts-rainbow'

        use 'kevinhwang91/nvim-hlslens'
        -- use "petertriho/nvim-scrollbar"

        -- Themes
        use 'ellisonleao/gruvbox.nvim'
        use "rebelot/kanagawa.nvim"
--}}}
    -- Languages & Filetypes{{{
        -- Reduces startup-time by about 50ms
            use "nathom/filetype.nvim"
        -- Ansible
            use {
                'pearofducks/ansible-vim',
                opt = true,
                ft = {'ansible'}
            }
        -- GPG
            use 'jamessan/vim-gnupg'
        -- C
            use {
                'rhysd/vim-clang-format',
                opt = true,
                ft = {'c', 'cpp'}
            }
        -- CSV
            use {
                'chrisbra/csv.vim',
                opt = true,
                ft = {'csv'}
            }
        -- Python
            use {
                'davidhalter/jedi-vim',
                opt = true,
                ft = {'python'}
            }
            use {
                'raimon49/requirements.txt.vim',
                opt = true,
                ft = {'txt'}
            }
            use {
                'mfussenegger/nvim-dap-python',
                opt = true,
                ft = {'python'}
            }
            use {
                'psf/black',
                opt = true,
                ft = {'python'}
            }
        -- Go
            use {
                -- 'fatih/vim-go',
                'ray-x/go.nvim',
                opt = true,
                ft = {'go', 'gomod'}
            }
        -- Rust
            use {
                'rust-lang/rust.vim',
                opt = true,
                ft = {'rust'}
            }
        -- Openscad (kinda)
            use {
                'sirtaj/vim-openscad',
                opt = true,
                ft = {'openscad'}
            }
        -- markdown
            use {
                'plasticboy/vim-markdown',
                requires = 'godlygeek/tabular',
                opt = true,
                ft = {'markdown'}
            }

--}}}
    -- LSP & Completion {{{
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

        use 'tami5/lspsaga.nvim'
--}}}
    -- Misc{{{
        use {
            'powerman/vim-plugin-AnsiEsc',
        }

        use 'tpope/vim-obsession'

        -- use 'windwp/nvim-autopairs'
        -- use 'rcarriga/nvim-notify'

        use 'folke/which-key.nvim'

        use 'kazhala/close-buffers.nvim'

        -- tmux stuff
        use 'christoomey/vim-tmux-navigator'

        -- I literally only use the resize function from this
        -- Should probably just pull it out and remove this
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

        use {
            'junegunn/fzf',
            opt=true
        }
        use {
            'junegunn/fzf.vim',
            opt=true
        }

        use 'nvim-telescope/telescope.nvim'

        use 'tpope/vim-commentary'

        -- use 'mhinz/vim-startify'

        use "lukas-reineke/indent-blankline.nvim"

        use 'lewis6991/gitsigns.nvim'
--}}}
end)
--}}}

