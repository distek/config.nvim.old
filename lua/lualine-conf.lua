-- lualine
--
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore
--
 local function hexToRgb(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local utilbg = "#000000"
local utilfg = "#ffffff"

local function blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
    return blend(hex, bg or utilbg, math.abs(amount))
end

local function lighten(hex, amount, bg)
    return blend(hex, bg or utilfg, math.abs(amount))
end

local walPath = vim.fn.expand("~/.cache/wal")
package.path = walPath.."/?.lua;" .. package.path

local colors = require('colors')

local colorOpts = {
    bg       = darken(colors.color0, 0.70),
    fg       = lighten(colors.color8, 0.6),
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
    sources = { 'nvim_diagnostic' },
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

