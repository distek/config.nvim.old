-- Theme config

---- gruvbox{{{
--vim.g.gruvbox_bold = 1
--vim.g.gruvbox_italic = 1
--vim.g.gruvbox_transparent_bg = 1
--vim.g.gruvbox_underline = 1
--vim.g.gruvbox_undercurl = 1
--vim.g.gruvbox_termcolors = 0
--vim.g.gruvbox_contrast_dark = "medium"
--vim.g.gruvbox_contrast_light = "medium"
--vim.g.gruvbox_hls_cursor = "orange"
--vim.g.gruvbox_number_column = "bg1"
--vim.g.gruvbox_sign_column = "bg2"
--vim.g.gruvbox_color_column = "bg2"
--vim.g.gruvbox_vert_split = "bg0"
--vim.g.gruvbox_italicize_comments = 1
--vim.g.gruvbox_italicize_strings = 0
--vim.g.gruvbox_invert_selection = 0
--vim.g.gruvbox_invert_signs = 0
--vim.g.gruvbox_invert_indent_guides = 0
--vim.g.gruvbox_invert_tabline = 0
--vim.g.gruvbox_improved_strings = 0
--vim.g.gruvbox_improved_warnings = 0
--vim.g.gruvbox_guisp_fallback = 'NONE'

--vim.cmd[[highlight link TSError Normal]]
---- vim.cmd[[autocmd VimEnter * highlight Normal guibg=#282828 guifg=#ebdbb1]]
--vim.cmd("colorscheme gruvbox")

--vim.cmd('highlight NvimTreeNormal guibg='..Darken(getColor("Normal", "bg#"), 0.8))

----}}}

-- nightfox{{{

-- local nightfox = require('nightfox')

-- nightfox.setup({
--     -- nightfox, nordfox, dayfox, dawnfox, duskfox
--     fox = "nordfox",
--     transparent = false,
--     alt_nc = false,
--     terminal_colors = true,
--     styles = {
--         comments = "italic",
--         functions = "bold",
--         keywords = "italic",
--         strings = "NONE",
--         variables = "bold",
--     },
--     inverse = {
--         match_paren = true,
--         visual = false,
--         search = false,
--     },
--     colors = {},
--     hlgroups = {},
-- })

-- nightfox.load()
--}}}

-- onedark{{{

-- require('onedark').setup  {
--     -- Main options --
--     style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--     transparent = false,  -- Show/hide background
--     term_colors = true, -- Change terminal color as per the selected theme style
--     ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden

--     -- Change code style ---
--     -- Options are italic, bold, underline, none
--     -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
--     code_style = {
--         comments = 'italic',
--         keywords = 'italic',
--         functions = 'bold',
--         strings = 'none',
--         variables = 'bold'
--     },

--     -- Custom Highlights --
--     colors = {}, -- Override default colors
--     highlights = {}, -- Override highlight groups

--     -- Plugins Config --
--     diagnostics = {
--         darker = true, -- darker colors for diagnostic
--         undercurl = true,   -- use undercurl instead of underline for diagnostics
--         background = true,    -- use background color for virtual text
--     },
-- }

-- require('onedark').load()
--}}}

-- material{{{
-- darker, lighter, oceanic, palenight, deep ocean
-- vim.g.material_style = "deep ocean"

-- require('material').setup({
-- 	contrast = {
-- 		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
-- 		floating_windows = true, -- Enable contrast for floating windows
-- 		line_numbers = true, -- Enable contrast background for line numbers
-- 		sign_column = true, -- Enable contrast background for the sign column
-- 		cursor_line = false, -- Enable darker background for the cursor line
-- 		non_current_windows = false, -- Enable darker background for non-current windows
-- 		popup_menu = true, -- Enable lighter background for the popup menu
-- 	},

-- 	italics = {
-- 		comments = true, -- Enable italic comments
-- 		keywords = false, -- Enable italic keywords
-- 		functions = false, -- Enable italic functions
-- 		strings = false, -- Enable italic strings
-- 		variables = false -- Enable italic variables
-- 	},

-- 	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
-- 		"terminal", -- Darker terminal background
-- 		"packer", -- Darker packer background
-- 		"qf" -- Darker qf list background
-- 	},

-- 	high_visibility = {
-- 		lighter = false, -- Enable higher contrast text for lighter style
-- 		darker = false -- Enable higher contrast text for darker style
-- 	},

-- 	disable = {
-- 		borders = false, -- Disable borders between verticaly split windows
-- 		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
-- 		term_colors = false, -- Prevent the theme from setting terminal colors
-- 		eob_lines = false -- Hide the end-of-buffer lines
-- 	},

-- 	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

-- 	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

-- 	custom_highlights = {} -- Overwrite highlights with your own
-- })

-- vim.cmd('colorscheme material')
--}}}

-- kanagawa {{{

-- Default options:
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = true,        -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
-- }}}
