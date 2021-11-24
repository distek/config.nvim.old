-- Defaults

-- Sets{{{
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.mouse = "a"
vim.o.autoread = true
vim.o.wrap = true
vim.o.showtabline = 2
vim.o.foldmethod = "marker"
vim.o.updatetime = 250
vim.o.cmdheight = 1
vim.o.encoding = "utf-8"
vim.backspace={"indent","eol","start"}
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.fileformats="unix,dos,mac"
vim.o.ruler = true
vim.o.number = true
vim.o.scrolloff=2
vim.o.laststatus=2
vim.o.modeline = true
vim.o.modelines = 5
vim.o.showmode = false
vim.o.showbreak="↪ "
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.termguicolors = false
vim.o.breakindent = true
vim.o.timeoutlen = 250
vim.o.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"
vim.o.wildmode = "list:longest,list:full"
vim.o.clipboard = "unnamedplus"
vim.o.syntax = "on"
vim.wo.colorcolumn = "99999"
vim.o.fillchars = "vert:│,fold:-,eob: "
vim.o.pumblend = 15

vim.cmd[[set sessionoptions-=blank]]

vim.o.swapfile = false
vim.o.undodir = os.getenv("HOME").."/.cache/nvim/undodir"
vim.o.undofile = true

vim.o.splitright = true
vim.o.splitbelow = true

-- Remove cursorline in insert mode
vim.cmd[[autocmd InsertLeave,WinEnter * set cursorline]]
vim.cmd[[autocmd InsertEnter,WinLeave * set nocursorline]]

-- Cursor shape:
-- Insert - line; Normal - block; Replace - underline
-- Works with tmux as well
vim.cmd[[
    if empty($TMUX)
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
        let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    else
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
]]

-- Neovide
vim.cmd[[set guifont=PerfectDOSVGA437\ Nerd\ Font:w2]]
vim.cmd[[set guicursor+=a:blinkon650]]

-- netrw Sexplore or Lexplore
vim.cmd[[let g:netrw_winsize = 20]]
--}}}

-- Disabled builtins {{{
-- Improves startup time just ever so slightly
local disabled_built_ins = {
    -- Need netrw for certain things, like remote editing
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
--}}}

-- Autocommands {{{
-- https://github.com/nanotee/nvim-lua-guide#defining-autocommands
--   Augroups and autocommands do not have an interface yet but it is being worked on:
--
--   Pull request https://github.com/neovim/neovim/pull/12378
--   Pull request (lua: autocmds take 2) https://github.com/neovim/neovim/pull/14661

-- The above is why these are all still wrapped in vim.cmd

-- Return to previous line in file
-- line_return defined in functions.lua
vim.cmd[[
    augroup line_return
        au!
        au BufReadPost * lua _autocommands.line_return()
    augroup END
]]

-- Deal with quickfix
-- set nobuflisted and close if last window
vim.cmd[[
    augroup qf
        autocmd!
        autocmd FileType qf set nobuflisted
        autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
    augroup END
]]

-- Terminal
vim.cmd[[
    augroup Terminal
        autocmd!
        " au BufEnter term://* startinsert
        au TermOpen * setlocal nonumber norelativenumber wrap list
    augroup end
]]

vim.cmd[[
    function! NeatFoldText()
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
        let foldtextend = lines_count_text . repeat(foldchar, 8)
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    endfunction
    
    set foldtext=NeatFoldText()
]]
