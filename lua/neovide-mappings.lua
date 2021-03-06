-- Mappings

-- inits{{{
local opts = {noremap = true, silent = true}
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

local exmap = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, {noremap = true, expr = true, silent = true})
end
--}}}

-- Vim maps {{{

-- Remap for dealing with word wrap
-- Allows for navigating through wrapped lines without skipping over wrap
exmap('n', 'k',          "v:count == 0 ? 'gk' : 'k'")
exmap('n', 'j',          "v:count == 0 ? 'gj' : 'j'")

exmap('v', ">",          "'>gv'")
exmap('v', "<",          "'<gv'")

-- Page up/down (more comfortable than C-u/d)
map("n", "<S-J>",        "<C-d>")
map("n", "<S-K>",        "<C-u>")
map("v", "<S-J>",        "<C-d>")
map("v", "<S-K>",        "<C-u>")

-- Better incsearch
map("n", "N",            "Nzzzv")
map("n", "n",            "nzzzv")

-- mksession
map("n", "<leader>mk",   ":mksession!")

-- Split Terminal
map("n", "<leader>st",   ":lua split('split term://vimterm.sh')<CR>")
map("n", "<leader>vt",   ":lua split('vsplit term://vimterm.sh')<CR>")

-- Current window terminal
map("n", "<leader>tt",   ":lua split('term')<CR>")

-- Term escape
map("t", "Ω",        "<c-\\><c-n>")

-- Move buffers
map('n', '<leader>>',    ':BufferLineMoveNext<CR>')
map('n', '<leader><',    ':BufferLineMovePrev<CR>')

-- switch tabs
map("n", "<Tab>",        ':lua skipQFAndTerm("next")<cr>')
map("n", "<S-Tab>",      ':lua skipQFAndTerm("prev")<cr>')

-- Window/buffer stuff
map("n", "<leader>vs",   ":lua split('vsplit')<cr>")
map("n", "<leader>ss",   ":lua split('split')<cr>")

-- Window movement
map("n", "Ó",      '<cmd>WinShift left<cr>')
map("n", "Ô",      '<cmd>WinShift down<cr>')
map("n", "",      '<cmd>WinShift up<cr>')
map("n", "Ò",      '<cmd>WinShift right<cr>')

-- Close window(split)
map("n", "∑",        '<cmd>wincmd c<cr>')

-- Delete buffer
map("n", "œ",        ':BDelete! this<cr>')

-- Navigate windows/panes incl. tmux
map("n", "∆",        ":TmuxNavigateDown<CR>")
map("n", "˚",        ":TmuxNavigateUp<CR>  ")
map("n", "¬",        ":TmuxNavigateRight<CR>")
map("n", "˙",        ":TmuxNavigateLeft<CR> ")

map("v", "∆",        ":TmuxNavigateDown<CR>")
map("v", "˚",        ":TmuxNavigateUp<CR>  ")
map("v", "¬",        ":TmuxNavigateRight<CR>")
map("v", "˙",        ":TmuxNavigateLeft<CR> ")

map("t", "∆",        "<c-\\><c-n>:TmuxNavigateDown<CR>")
map("t", "˚",        "<c-\\><c-n>:TmuxNavigateUp<CR>  ")
map("t", "¬",        "<c-\\><c-n>:TmuxNavigateRight<CR>")
map("t", "˙",        "<c-\\><c-n>:TmuxNavigateLeft<CR> ")

map("n", "<C-j>",      '<cmd>lua require("tmux").resize_bottom()<cr>')
map("n", "",      '<cmd>lua require("tmux").resize_top()<cr>')
map("n", "",      '<cmd>lua require("tmux").resize_right()<cr>')
map("n", "",      '<cmd>lua require("tmux").resize_left()<cr>')

map("v", "<C-j>",      '<cmd>lua require("tmux").resize_bottom()<cr>')
map("v", "<C-k>",      '<cmd>lua require("tmux").resize_top()<cr>')
map("v", "<C-l>",      '<cmd>lua require("tmux").resize_right()<cr>')
map("v", "<C-h>",      '<cmd>lua require("tmux").resize_left()<cr>')

map("t", "<C-j>",      '<c-\\><c-n>:lua require("tmux").resize_bottom()<cr>')
map("t", "<C-k>",      '<c-\\><c-n>:lua require("tmux").resize_top()<cr>')
map("t", "<C-l>",      '<c-\\><c-n>:lua require("tmux").resize_right()<cr>')
map("t", "<C-h>",      '<c-\\><c-n>:lua require("tmux").resize_left()<cr>')
-- }}}

-- Plugin maps {{{

-- EasyMotion
-- map("n", "<leader>f",    '<cmd>lua require("hop").hint_words()<cr>')

vim.cmd[[
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
]]
-- Commentary
map("n", "<leader>cm",   ':Commentary<cr><esc>')
map("v", "<leader>cm",   ':Commentary<cr><esc>')

-- nvim-tree
map("n", "<leader>1",        ":NvimTreeToggle<CR>")

-- Floaterm
map("n", "<leader>2",        '<cmd>lua require("FTerm").toggle()<CR>')
map("t", "<leader>2",        '<cmd>lua require("FTerm").toggle()<CR>')

-- Tagbar
map("n", "<leader>4",        ":call vista#sidebar#Toggle()<CR>")

-- Fugitive
map("n", "<leader>Fi",  ":GFiles<CR>")
map("n", "<leader>Fa",   ":Gwrite<CR>")
map("n", "<leader>Fc",   ":Git commit<CR>")
map("n", "<leader>Fp",   ":Git push<CR> ")
map("n", "<leader>Fll",  ":Git pull<CR>")
map("n", "<leader>Fs",   ":Git<CR>")
map("n", "<leader>Fb",   ":Gblame<CR>")
map("n", "<leader>Fvd",  ":Gvdiff<CR>")
map("n", "<leader>Fr",   ":Gremove<CR>")
map("n", "<leader>Fo",   ":.Gbrowse<CR")
map("n", "<leader>Fj",   ":diffget //3<CR>")
map("n", "<leader>Ff",   ":diffget //2<CR>")

map("n", "<leader>lg",   ":lua __fterm_gitui()<cr>")

-- Undotree
map("n", "<leader>ud",   ":UndotreeToggle<CR>")

-- LSP {{{
map('n', '<leader>gy',   '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>gd',   '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>sd',   "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
map('n', '<leader>pd',   "<cmd>lua require('lspsaga.provider').preview_definition()<CR>")
map("n", "<leader>gr",   "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
map('n', '<leader>sD',   '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>g[',   '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>g]',   '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

map('n', '<leader>rn',   "<cmd>lua require('lspsaga.rename').rename()<CR>")
map('n', '<leader>ca',   '<cmd>lua vim.lsp.buf.code_action()<CR>')

--}}}

-- FZF
map('n', '<leader>pr',   [[:Rg<cr>]])
map('n', '<leader>pw',   [[:FindWord><cr>]])

-- Limelight toggles with '!!'
map('n', '<leader>li',   '<cmd>Limelight!!<CR>')

-- Obsession
map('n', '<leader>Ob',   '<cmd>Obsess<CR>')
map('n', '<leader>OB',   '<cmd>Obsess!<CR>')

map("n","<leader>tf","<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n","<leader>tg","<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n","<leader>tb","<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n","<leader>th","<cmd>lua require('telescope.builtin').help_tags()<cr>")

map("n", "<leader>qf",    "<cmd>lua require('telescope.builtin').quickfix()<cr>")
map('n', '<leader>ql',    "<cmd>lua require('telescope.builtin').loclist()<cr>")
map('n', '<leader>ql',    "<cmd>lua require('telescope.builtin').loclist()<cr>")

-- }}}

-- Debug maps {{{
map("n", "<leader>db",   "<cmd>lua require('dap').toggle_breakpoint()<CR>")
map("n", "<leader>di",   "<cmd>lua require('dap').step_into()<CR>")
map("n", "<leader>dn",   "<cmd>lua require('dap').step_over()<CR>")
map("n", "<leader>do",   "<cmd>lua require('dap').step_out()<CR>")
map("n", "<leader>du",   "<cmd>lua require('dap').up()<CR>")
map("n", "<leader>drn",  "<cmd>lua require('dap').run_to_cursor()<CR>")
map("n", "<leader>dd",   "<cmd>lua require('dap').down()<CR>")
map("n", "<leader>dc",   "<cmd>lua require('dap').continue()<CR>")
map("n", "<leader>ds",   "<cmd>lua require('dapui').open()<cr>")
map("n", "<leader>dS",   "<cmd>lua dapStop()<cr>")
-- }}}

-- Language specific maps {{{
    -- Go {{{
-- map("n", "<leader>Gie", ":lua goIfErr()<CR>")
-- map("n", "<leader>Gfs", ":lua goFillStruct()<CR>")
    --}}}
-- }}}

-- Custom Function maps{{{

map("n", "<leader>sn",   ":call SynStack()<cr>")

--}}}
