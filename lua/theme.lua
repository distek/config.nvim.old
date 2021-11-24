-- -- Theme config

-- lualine {{{
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore

local colors = require('colors')

local colorOpts = {
    bg       = colors.color8,
    fg       = colors.foreground,
    yellow   = colors.color3,
    cyan     = colors.color6,
    darkblue = colors.color13,
    green    = colors.color2,
    orange   = colors.color12,
    violet   = colors.color14,
    magenta  = colors.color5,
    blue     = colors.color4,
    red      = colors.color1,
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .    So we
            -- are just setting default looks o statusline
        normal = {
            a = { fg = colorOpts.fg, bg = colorOpts.bg, gui = 'bold' },
            b = { fg = colorOpts.fg, bg = colorOpts.bg },
            c = { fg = colorOpts.fg, bg = colorOpts.bg },
        },
        },
        always_divide_middle = true,
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = { fg = colorOpts.blue, bg = colorOpts.bg }, -- Sets highlighting of component
    padding = { left = 0, right = 0 }, -- We don't need space before this
}

ins_left {
    -- mode component
    function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colorOpts.red,
            i = colorOpts.green,
            v = colorOpts.blue,
            [''] = colorOpts.blue,
            V = colorOpts.blue,
            c = colorOpts.magenta,
            no = colorOpts.red,
            s = colorOpts.orange,
            S = colorOpts.orange,
            [''] = colorOpts.orange,
            ic = colorOpts.yellow,
            R = colorOpts.violet,
            Rv = colorOpts.violet,
            cv = colorOpts.red,
            ce = colorOpts.red,
            r = colorOpts.cyan,
            rm = colorOpts.cyan,
            ['r?'] = colorOpts.cyan,
            ['!'] = colorOpts.red,
            t = colorOpts.red,
        }
        vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colorOpts.bg)
        return ''
    end,
    color = 'LualineMode',
    padding = { right = 1, left = 1 },
}

ins_left {
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
    color = { bg = colorOpts.bg, gui = 'bold' },
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colorOpts.magenta, bg = colorOpts.bg, gui = 'bold' },
}

ins_left { 'location' , color = { fg = colorOpts.fg, bg = colorOpts.bg, gui = 'bold' }}

ins_left { 'progress', color = { fg = colorOpts.fg, bg = colorOpts.bg, gui = 'bold' } }

ins_left {
    'diagnostics',
    sources = { 'nvim_lsp' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        color_error = { fg = colorOpts.red, bg = colorOpts.bg },
        color_warn = { fg = colorOpts.yellow, bg = colorOpts.bg },
        color_info = { fg = colorOpts.cyan, bg = colorOpts.bg },
    },
    color = { bg = colorOpts.bg, gui = 'bold' },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
    function()
        return '%='
    end,
    color = { bg = colorOpts.bg, gui = 'bold' },
}

ins_left {
    -- Lsp server name .
    function()
        local msg = 'none'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = { fg = colorOpts.fg, bg = colorOpts.bg, gui = 'bold' },
}

-- Add components to right sections
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colorOpts.green, bg = colorOpts.bg, gui = 'bold' },
}

ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colorOpts.green, bg = colorOpts.bg, gui = 'bold' },
}

ins_right {
    'branch',
    icon = '',
    color = { fg = colorOpts.violet, bg = colorOpts.bg, gui = 'bold' },
}

ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '柳 ', removed = ' ' },
    diff_color = {
        added = { fg = colorOpts.green, bg = colorOpts.bg },
        modified = { fg = colorOpts.orange, bg = colorOpts.bg },
        removed = { fg = colorOpts.red, bg = colorOpts.bg },
    },
    cond = conditions.hide_in_width,
}

ins_right {
    function()
        return '▊'
    end,
    color = { fg = colorOpts.blue, bg = colorOpts.bg },
    padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
-- }}}

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

