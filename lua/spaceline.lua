---- Spaceline

---- I think this is now wildly different than from wherever I grabbed it from originally

---- Init{{{
--local gl = require('galaxyline')
--local gls = gl.section

--gl.short_line_list = {
--    'nerdtree',
--    'tagbar',
--    'godebugstacktrace',
--    'godebugvariables',
--    'godebugoutput',
--    'dapui_scopes',
--    'dapui_breakpoints',
--    'dapui_stacks',
--    'dapui_watches',
--    'NvimTree',
--}

--local colors = require('galaxyline.theme').default

--local buffer_not_empty = function()
--    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--        return true
--    end

--    return false
--end

--local checkwidth = function()
--    local squeeze_width    = vim.fn.winwidth(0) / 2
--    if squeeze_width > 40 then
--        return true
--    end
--    return false
--end

----}}}

---- Left side{{{
--gls.left[1] = {
--}

--gls.left[2] = {
--    ViMode = {
--        provider = function()
--            local alias = {
--                n = '  NRM ',
--                i = '  INS ',
--                c = '  CMD ',
--                v = '  VIS ',
--                V = '  VIL ',
--                [''] = '  VIB ',
--                t = '  TRM '
--            }
--            return alias[vim.fn.mode()]
--        end,
--        -- separator = ' ',
--        separator = ' ',
--        separator_highlight = {colors.purple,function()
--            if not buffer_not_empty() then
--                return colors.purple
--            end
--            return colors.darkblue
--        end},
--        highlight = {colors.bg,colors.green,'bold'},
--    },
--}

--gls.left[3] ={
--    FileIcon = {
--        provider = 'FileIcon',
--        condition = buffer_not_empty,
--        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
--    },
--}

--gls.left[4] = {
--    FileName = {
--        provider = {'FileName','FileSize'},
--        condition = buffer_not_empty,
--        -- separator = '',
--        separator = '',
--        separator_highlight = {colors.grey,colors.darkblue},
--        highlight = {colors.magenta,colors.darkblue}
--    }
--}

--gls.left[5] = {
--    GitIcon = {
--        provider = function() return '   ' end,
--        condition = buffer_not_empty,
--        highlight = {colors.orange,colors.grey},
--    }
--}

--gls.left[6] = {
--    GitBranch = {
--        provider = 'GitBranch',
--        condition = buffer_not_empty,
--        highlight = {colors.white,colors.grey},
--    }
--}

--gls.left[7] = {
--    DiffAdd = {
--        provider = 'DiffAdd',
--        condition = checkwidth,
--        icon = '+ ',
--        highlight = {colors.green,colors.grey},
--    }
--}

--gls.left[8] = {
--    DiffModified = {
--        provider = 'DiffModified',
--        condition = checkwidth,
--        icon = '* ',
--        highlight = {colors.orange,colors.grey},
--    }
--}

--gls.left[9] = {
--    DiffRemove = {
--        provider = 'DiffRemove',
--        condition = checkwidth,
--        icon = '- ',
--        highlight = {colors.red,colors.grey},
--    }
--}

--gls.left[10] = {
--    LeftEnd = {
--        -- provider = function() return '' end,
--        -- separator = '',
--        provider = function() return ' ' end,
--        separator = ' ',
--        separator_highlight = {colors.grey,colors.bg},
--        highlight = {colors.grey,colors.grey}
--    }
--}

--gls.left[11] = {
--    DiagnosticError = {
--        provider = 'DiagnosticError',
--        icon = '  ',
--        highlight = {colors.red,colors.bg}
--    }
--}

--gls.left[12] = {
--    Space = {
--        provider = function () return '' end
--    }
--}

--gls.left[13] = {
--    DiagnosticWarn = {
--        provider = 'DiagnosticWarn',
--        icon = '  ',
--        highlight = {colors.blue,colors.bg},
--    }
--}
----}}}

---- Right side{{{
--gls.right[1]= {
--    FileFormat = {
--        provider = function()
--            local battPerc = io.popen([[pmset -g batt | grep '%' | awk -F' ' '{print $3}' | sed 's/;//g']], 'r')
--            local output = battPerc:read('*all')

--            return output
--        end,
--        -- separator = ' ',
--        separator = ' ',
--        separator_highlight = {colors.bg,colors.blue},
--        highlight = {colors.bg,colors.blue},
--    }
--}

--gls.right[2]= {
--    FileFormat = {
--        provider = 'FileFormat',
--        -- separator = ' ',
--        separator = ' ',
--        separator_highlight = {colors.bg,colors.blue},
--        highlight = {colors.bg,colors.blue},
--    }
--}

--gls.right[3] = {
--    LineInfo = {
--        provider = 'LineColumn',
--        separator = ' | ',
--        separator_highlight = {colors.bg,colors.blue},
--        highlight = {colors.bg,colors.blue},
--    },
--}

--gls.right[4] = {
--    PerCent = {
--        provider = 'LinePercent',
--        -- separator = '',
--        separator = ' ',
--        separator_highlight = {colors.darkblue,colors.blue},
--        highlight = {colors.white,colors.bg},
--    }
--}

--gls.right[5] = {
--    ScrollBar = {
--        provider = 'ScrollBar',
--        highlight = {colors.yellow,colors.darkblue},
--    }
--}
----}}}

---- Ends? I think?{{{
--gls.short_line_left[1] = {
--    BufferType = {
--        provider = 'FileTypeName',
--        -- separator = '',
--        separator = ' ',
--        separator_highlight = {colors.purple,colors.bg},
--        highlight = {colors.grey,colors.purple}
--    }
--}

--gls.short_line_right[1] = {
--    BufferIcon = {
--        provider= 'BufferIcon',
--        -- separator = '',
--        separator = ' ',
--        separator_highlight = {colors.purple,colors.bg},
--        highlight = {colors.grey,colors.purple}
--    }
--}
----}}}
