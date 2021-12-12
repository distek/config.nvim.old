local walColors = require("colors")

local wallyImport = require("wally")
local darken = require('wally.util').darken
local lighten = require('wally.util').lighten

vim.cmd("autocmd UIEnter * highlight! VertSplit guifg=" .. walColors.foreground)
vim.cmd("autocmd UIEnter * highlight! CursorLine guibg=" .. darken(wallyImport.colors.bg_highlight, 0.3))
vim.cmd("autocmd UIEnter * highlight! Visual guibg=" .. wallyImport.colors.bg_highlight)
