-- -- Theme config

-- disabled {{{
-- -- onedark
-- vim.cmd[[
--     let g:onedark_style = 'darker'

--     " autocmd ColorScheme * highlight NormalFloat guibg=#30363f
--     " autocmd ColorScheme * highlight FloatBorder guifg=#7d899f guibg=#30363f
--     " autocmd TermOpen * setlocal winhighlight=Normal:NvimTreeNormal
-- ]]

-- -- gruvbox
-- vim.cmd[[
--     let g:gruvbox_bold = 1
--     let g:gruvbox_italic = 1

--     let g:gruvbox_underline = 1
--     let g:gruvbox_contrast_dark = 'soft' "soft, medium, hard
-- ]]

-- -- material
-- vim.g.material_style = "deep ocean"

-- require('material').setup({
--     borders = true,
--     disable = {
--         eob_lines = true
--     }
-- })

-- -- Nord
-- vim.g.nord_contrast = true
-- vim.g.nord_borders = true
-- vim.g.nord_disable_background = false
-- vim.g.nord_italic = true

-- -- Example config in Lua
-- vim.g.wally_wal_dir = "~/.cache/wal"
-- vim.g.wally_italic_functions = true
-- vim.g.wally_sidebars = { "qf", "vista_kind", "terminal", "Nvimtree", "Trouble", "packer", }

-- Load the colorscheme
-- require("wally").colorscheme()
-- require('nord').set()
-- vim.cmd[[colorscheme onedark]]
-- vim.cmd[[colorscheme gruvbox]]
-- vim.cmd[[colorscheme wal]]
-- vim.cmd[[
-- set termguicolors
-- highlight Normal ctermbg=none ctermfg=15
-- highlight clear CursorLine
-- highlight CursorLine ctermbg=235 ctermfg=none
-- highlight Pmenu ctermbg=238 ctermfg=7
-- highlight markdownCode ctermfg=2
-- highlight Title ctermfg=3
-- highlight ALEError cterm=underline ctermbg=none
-- highlight MatchParen ctermfg=0
-- highlight CursorLineNr ctermfg=7
-- highlight LineNr ctermfg=8
-- highlight VertSplit cterm=none ctermfg=7 ctermbg=none
-- highlight Comment ctermfg=8
-- highlight rainbowcol1 ctermfg=1
-- highlight rainbowcol2 ctermfg=2
-- highlight rainbowcol3 ctermfg=3
-- highlight rainbowcol4 ctermfg=4
-- highlight rainbowcol5 ctermfg=5
-- highlight rainbowcol6 ctermfg=6
-- highlight rainbowcol7 ctermfg=2
-- highlight IndentBlanklineChar ctermfg=8

-- highlight BufferLineFill ctermbg=8
-- highlight BufferLineBufferSelected ctermbg=243 ctermfg=0
-- -- highlight BufferLineDevIcon*Selected ctermbg=243 ctermfg=0
-- set fillchars+=vert:⎪

-- ]]

-- require('nightfox').load('nightfox')

-- }}}
vim.g.wally_wal_dir = "~/.cache/wal"

vim.g.wally_italic_functions = true
vim.g.wally_italic_comments = true
vim.g.wally_italic_keywords = true
vim.g.wally_dark_sidebar = true
vim.g.wally_dark_float = true
vim.g.wally_transparent = true
vim.g.wally_transparent_sidebar = false
vim.g.wally_sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "NvimTree",
    "packer",
}

require("wally").colorscheme()

vim.cmd[[colorscheme wally]]

