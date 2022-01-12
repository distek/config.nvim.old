local walPath = vim.fn.expand("~/.cache/wal")
package.path = walPath.."/?.lua;" .. package.path

local walColors = require("colors")

local wallyImport = require("wally")
local darken = require('wally.util').darken
local lighten = require('wally.util').lighten

vim.cmd("autocmd UIEnter * highlight! VertSplit guifg=" .. walColors.foreground)
vim.cmd("autocmd UIEnter * highlight! CursorLine guibg=" .. darken(wallyImport.colors.bg_highlight, 0.3))
vim.cmd("autocmd UIEnter * highlight! Visual guibg=" .. wallyImport.colors.bg_highlight)

vim.cmd("highlight! NvimTreeNormal guibg=" .. darken(wallyImport.colors.bg_highlight, 0.5))

-- gray
vim.cmd("autocmd UIEnter * highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=" .. wallyImport.colors.bg_highlight )
-- blue
vim.cmd("autocmd UIEnter * highlight! CmpItemAbbrMatch guibg=NONE guifg=" .. wallyImport.colors.green )
vim.cmd("autocmd UIEnter * highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=" .. wallyImport.colors.green )
-- light blue
vim.cmd("autocmd UIEnter * highlight! CmpItemKindVariable guibg=NONE guifg=" .. wallyImport.colors.blue )
vim.cmd("autocmd UIEnter * highlight! CmpItemKindInterface guibg=NONE guifg=" .. wallyImport.colors.red1 )
vim.cmd("autocmd UIEnter * highlight! CmpItemKindText guibg=NONE guifg=" .. wallyImport.colors.green1 )
-- pink
vim.cmd("autocmd UIEnter * highlight! CmpItemKindFunction guibg=NONE guifg=" .. wallyImport.colors.cyan )
vim.cmd("autocmd UIEnter * highlight! CmpItemKindMethod guibg=NONE guifg=" .. wallyImport.colors.magenta )
-- front
vim.cmd("autocmd UIEnter * highlight! CmpItemKindKeyword guibg=NONE guifg=" .. lighten(wallyImport.colors.yellow, 0.8) )
vim.cmd("autocmd UIEnter * highlight! CmpItemKindClass guibg=NONE guifg=" .. wallyImport.colors.red )
vim.cmd("autocmd UIEnter * highlight! CmpItemKindProperty guibg=NONE guifg=" .. wallyImport.colors.teal )
vim.cmd("autocmd UIEnter * highlight! CmpItemKindUnit guibg=NONE guifg=" .. wallyImport.colors.purple )

