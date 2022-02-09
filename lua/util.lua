-- User-defined Functions and stuff

_G._autocommands = {}

_G._autocommands.line_return = function()
    local line = vim.fn.line
    if line("'\"") > 0 and line("'\"") <= line("$") then
        vim.cmd("normal! g`\"zvzz'")
    end
end

-- Skips over quickfix buf when tabbing through buffers
_G.skipQFAndTerm = function(dir)
    if dir == "prev" then
        vim.cmd[[BufferLineCyclePrev]]
    else
        vim.cmd[[BufferLineCycleNext]]
    end

    while vim.api.nvim_buf_get_option(0, "buftype") == "quickfix" do
        if dir == "prev" then
            vim.cmd[[BufferLineCyclePrev]]

            -- I have no idea why this is needed
            vim.cmd[[stopinsert]]
        else
            vim.cmd[[BufferLineCycleNext]]

            vim.cmd[[stopinsert]]
        end
    end
end

-- Useful for determining highlight names
vim.cmd[[
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
]]

_G.split = function(cmd)
    if vim.g.is_zoomed == true then
        vim.notify("Currently zoomed")
    else
        vim.cmd(cmd)
    end
end

_G.zoom = function()
    if vim.g.is_zoomed == true then
        vim.cmd[[tabclose]]
        vim.g.is_zoomed = false
    else
        vim.cmd[[tabnew %]]
        vim.g.is_zoomed = true
    end
end

_G.dapStop = function()
    local dap = require('dap')
    local dapui = require('dapui')

    if dap.session() then
        dap.disconnect()
    end

    dap.close()
    dapui.close()
end

_G.nvimTreeToggle = function()
    vim.g.nvimtreeOpen = not vim.g.nvimtreeOpen

    vim.cmd[[NvimTreeToggle]]
end

_G.vistaToggle = function()
    vim.g.vistaOpen = not vim.g.vistaOpen

    vim.cmd[[Vista!!]]
end

_G.toggleTerm = function()
    local doWinCmd = false
    if vim.g.nvimtreeOpen then
        vim.cmd[[NvimTreeClose]]
    end

    if vim.g.vistaOpen then
        vim.cmd[[Vista!]]
    end

    vim.cmd[[ToggleTerm]]

    if vim.g.nvimtreeOpen then
        doWinCmd = true
        vim.cmd[[NvimTreeOpen]]
    end

    if vim.g.vistaOpen then
        doWinCmd = true
        vim.cmd[[Vista]]
    end

    if doWinCmd then
        vim.cmd[[silent wincmd p]]
    end
end

local utilbg = "#000000"
local utilfg = "#ffffff"

local function hexToRgb(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function Darken(hex, amount)
    return blend(hex, utilbg, math.abs(amount))
end

function Lighten(hex, amount)
    return blend(hex, utilfg, math.abs(amount))
end

_G.getColor = function(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end
