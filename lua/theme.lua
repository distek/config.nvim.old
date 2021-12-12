-- -- Theme config

vim.g.wally_wal_dir = "~/.cache/wal"

vim.g.wally_italic_functions = true
vim.g.wally_italic_comments = true
vim.g.wally_italic_keywords = true
vim.g.wally_dark_sidebar = true
vim.g.wally_dark_float = true
vim.g.wally_transparent = true
vim.g.wally_transparent_sidebar = false
vim.g.wally_sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "NvimTree",
    "packer",
}

local walPath = vim.fn.expand(vim.g.wally_wal_dir)
package.path = walPath.."/?.lua;" .. package.path

-- print(walColors)

require("wally").colorscheme()

vim.cmd("colorscheme wally")

