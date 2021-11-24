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
    local start_buffer = vim.api.nvim_buf_get_number("%")

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

