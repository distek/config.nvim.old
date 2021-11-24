-- Language configurations
    -- Go {{{
    require("go").setup()
    -- }}}

    -- C {{{
vim.cmd[[
    let g:clang_format#code_style = 'google'
    let g:clang_format#style_options = { "AccessModifierOffset" : -4, "AllowShortIfStatementsOnASingleLine" : "true", "AlwaysBreakTemplateDeclarations" : "true", "Standard" : "C++11", "BreakBeforeBraces" : "Custom", "BraceWrapping": { "AfterEnum": "false", "AfterStruct": "false", "SplitEmptyFunction": "false", }, }
    au filetype *.c,*.h set filetype c.doxygen
    au filetype *.c,*.h set tabstop=4
    au filetype *.c,*.h set softtabstop=4
    au filetype *.c,*.h set shiftwidth=4
    au filetype *.c,*.h set noexpandtab=4
    "autocmd BufWritePre *.c,*.h ClangFormat
    autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
]]
    -- }}}

-- Python {{{
vim.cmd[[
    autocmd BufWritePre *.py execute ':Black'
]]
-- }}}

-- Typescript {{{
vim.cmd[[
    autocmd BufNewFile,BufRead *.ts setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 textwidth=80
]]
-- }}}
