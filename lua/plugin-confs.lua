-- Plugin configs

-- ALE {{{
vim.g.ale_hover_cursor = 0
-- }}}

-- Bufferline{{{
require("bufferline").setup{
    options = {
        view = "multiwindow",
        close_command = "BDelete! %d",
        show_tab_indicators = false,
        enforce_regular_tabs = false,
        offsets = {
            {filetype = "NvimTree", text="Explorer", highlight = "Directory"},
            {filetype = "tagbar", text="TagBar", highlight = "Directory"},
        },
        diagnostics = "lsp",
        indicator_icon = "█"
    },
}
--}}}

-- DAP{{{

--}}}

-- FTerm (floating terminal){{{
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
    lazygit:toggle()
end
-- }}}

-- gitsigns {{{
require('gitsigns').setup ()
-- }}}

-- indent_blankline{{{
-- vim.g.indent_blankline_char_highlight = {"Comment"}
-- vim.g.indent_blankline_space_char_highlight_list = {"Comment"}

vim.g.indent_blankline_context_patterns = {
    '^if',
    '^for',
    '^class',
    '^function',
    '^method',
    '^var',
    '^struct',
    '^object',
    '^table',
    '^block',
    '^arguments',
    '^while',
    '^operand',
    '^element'
}

require("indent_blankline").setup {
    char = "▏",
    filetype_exclude = {"help", "terminal", "startify", "packer", "markdown"},
    buftype_exclude = {"terminal"},
    use_treesitter = true,
    show_current_context = true,
    show_trailing_blankline_indent = false,
    show_current_context_start = true,
    show_first_indent_level = true,
    context_highlight_list = {
        "rainbowcol1",
        "rainbowcol2",
        "rainbowcol3",
        "rainbowcol4",
        "rainbowcol5",
        "rainbowcol6",
        "rainbowcol7",
    },
    -- char_highlight_list = {
    --     "rainbowcol1",
    --     "rainbowcol2",
    --     "rainbowcol3",
    --     "rainbowcol4",
    --     "rainbowcol5",
    --     "rainbowcol6",
    --     "rainbowcol7",
    -- },
}
--}}}

-- lightspeed.nvim {{{
require'lightspeed'.setup {
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  exit_after_idle_msecs = { labeled = 1500, unlabeled = 1000 },
  highlight_unique_chars = true,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 4,
  x_mode_prefix_key = '<c-x>',
  substitute_chars = { ['\r'] = '¬' },
  instant_repeat_fwd_key = nil,
  instant_repeat_bwd_key = nil,
  -- If no values are given, these will be set at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil,
}
-- }}}

-- lsp_signature {{{
require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_enable = false,
    handler_opts = {
        border = "single"
    },
})
--
-- }}}

-- lspkind {{{
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

-- }}}

-- nvim-autopairs {{{
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
    disable_in_macro = true,
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
    enable_moveright = true,
    enable_afterquote = true,  -- add bracket pairs after quote,
    enable_check_bracket_line = true,  --- check bracket in same line,
    map_bs = true,  -- map the <BS> key,
    map_c_w = false, -- map <c-w> to delete an pair if possible,
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

-- require('nvim-autopairs.ts-conds').add_rules({
--     Rule("%", "%", "lua")
--         :with_pair(ts_conds.is_ts_node({'string','comment'})),
--     Rule("$", "$", "lua")
--         :with_pair(ts_conds.is_not_ts_node({'function'}))
-- })

-- require("nvim-autopairs.completion.cmp").setup({
--     map_cr = true,
--     map_complete = true,
--     auto_select = true,
--     insert = false,
--     map_char = {
--         all = '(',
--         tex = '{'
--     }
-- })
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require('cmp').event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
-- }}}

-- nvim-cmp {{{
local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- cmp.register_source('look', require('cmp_look').new())
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end
    },
    formatting = {
        format = require('lspkind').cmp_format({
            with_text = true,
            maxwidth  = 50,
            menu = ({
                buffer    = "[Buffer]",
                nvim_lsp  = "[LSP]",
                vsnip     = "[Vsnip]",
                nvim_lua  = "[Lua]",
                look      = "[Look]",
                spell     = "[Spell]",
                cmdline   = "[CmdLine]",
                path      = "[Path]",
                calc      = "[Calc]",
            })
        })
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"]() == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                end
            end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                end
            end, { "i", "s" }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'look', keyword_length=2, options={convert_case=true, loud=true}},
        { name = 'spell' },
        { name = 'cmdline' },
        { name = 'path' },
        { name = 'calc' },
    })
})
-- }}}

-- nvim-dap {{{
local dap = require('dap')

dap.adapters.go = function(callback, config)
  local handle
  local pid_or_err
  local port = 38697
  handle, pid_or_err = vim.loop.spawn("dlv", {
    args = {"dap", "-l", "127.0.0.1:" .. port},
    detached = true
  }, function(code)
    handle:close()
    print("Delve exited with exit code: " .. code)
  end)
  -- Wait 100ms for delve to start
  vim.defer_fn(function()
    dap.repl.open()
    callback({type = "server", host = "127.0.0.1", port = port})
  end, 100)
end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "go",
        name = "Debug test",
        request = "launch",
        mode = "test", -- Mode is important
        program = "${file}"
    }
}

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      { id = "scopes", size = 0.50, },
      { id = "breakpoints", size = 0.25 },
      { id = "watches", size = 0.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

dap.adapters.dlv_spawn = function(cb)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = {nil, stdout},
    args = {"dap", "-l", "127.0.0.1:" .. port},
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end)
  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        --- You could adapt this and send `chunk` to somewhere else
        require('dap.repl').append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(
    function()
      cb({type = "server", host = "127.0.0.1", port = port})
    end,
    100)
end

dap.configurations.go = {
  {
    type = 'dlv_spawn',
    name = 'Launch dlv & file',
    request = 'launch',
    program = "${workspaceFolder}";
  },
}

require('nvim-dap-virtual-text').setup()
-- }}}

-- nvim-notify{{{
vim.notify = require("notify")
require("notify").setup({
  -- Animation style (see below for details)
  stages = "slide",

  -- Default timeout for notifications
  timeout = 5000,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- background_colour = "Comment",

  -- Icons for the different levels
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
--}}}

-- nvim-tree{{{
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require'nvim-tree'.setup {
    disable_netrw       = false,
    hijack_netrw        = false,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    update_to_buf_dir   = {
        enable = true,
        auto_open = true,
    },
    auto_close          = true,
    open_on_tab         = false,
    hijack_cursor       = true,
    update_cwd          = false,
    update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    view = {
        width = 30,
        side = 'left',
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {
                { key = {"<2-RightMouse>", "C"},    cb = tree_cb("cd") },
            }
        }
    },
}

--}}}

-- Rg{{{
-- This is gross. Not rg, just the configuration I do here
vim.api.nvim_exec([[
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    command! -bang -nargs=* FindWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(expand('<cword>')).'| tr -d "\017"', 1, <bang>0)
endif
]], false)
--}}}

-- startify {{{
function StartifyHeader()
  local v = vim.version()
  v = v.major .. '.' .. v.minor .. '.' .. v.patch
  -- https://patorjk.com/software/taag/#p=display&h=0&v=0&f=Bloody&t=NVIM%0A
  return {
    '',
    '',
    ' ███▄    █  ██▒   █▓ ██▓ ███▄ ▄███▓',
    ' ██ ▀█   █ ▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
    '▓██  ▀█ ██▒ ▓██  █▒░▒██▒▓██    ▓██░',
    '▓██▒  ▐▌██▒  ▒██ █░░░██░▒██    ▒██ ',
    '▒██░   ▓██░   ▒▀█░  ░██░▒██▒   ░██▒',
    '░ ▒░   ▒ ▒    ░ ▐░  ░▓  ░ ▒░   ░  ░',
    '░ ░░   ░ ▒░   ░ ░░   ▒ ░░  ░      ░',
    '   ░   ░ ░      ░░   ▒ ░░      ░   ',
    '         ░       ░   ░         ░   ',
    '  ░             ░                  ',
    '       ░                           ',
    '                             ░     ',
    '',
    '            Neovim v' .. v .. '',
    '',
  }
end

vim.g.startify_custom_header = "startify#center(luaeval('StartifyHeader()'))"

vim.g.startify_relative_path = 1
vim.g.startify_use_env = 1
vim.g.startify_change_to_dir = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_relative_path = 1
vim.g.startify_session_autoload = 1
vim.g.startify_session_before_save = { 'silent! tabdo NvimTreeClose' }
vim.g.startify_session_persistence = 1

local function startifyExtras()
    return {
        {
        line = 'golang - local',
        path = os.getenv("GOME")
        },
        {
        line = 'nvim config',
        path = "~/.config/nvim/"
        },
    }
end

vim.g.startify_lists = {
    {
        type = 'dir',
        header = {' - MRU ' .. os.getenv("PWD")}
    },
    {
        type = startifyExtras,
        header = {' - Bookmarks'},
    },
    {
        type = 'files',
        header = {' - MRU'}
    },
    {
        type = 'sessions',
        header = {' - Sessions'}
    },
}

--}}}

-- Treesitter{{{
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {'haskell'}, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        -- custom_captures = {
        --     ["variable"] = "Constant",
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
}
--}}}

-- vsnip {{{
vim.g.vsnip_snippet_dir = os.getenv('HOME') .. "/.config/nvim/vsnip/"
-- }}}

-- which-key{{{
require("which-key").setup{
    triggers_blacklist = {
        i = { "<" },
        c = { "h" },
    }
}
--}}}

-- winresizer{{{
vim.cmd[[ 
    let g:winresizer_enable = 1
    let g:winresizer_finish_with_escape = 1
    let g:winresizer_vert_resize = 1
    let g:winresizer_horiz_resize = 1
    let g:winresizer_start_key = '<A-r>'
]]
--}}}
