-- LSP settings

local lspconfig = require('lspconfig')

-- Formatting{{{
-- Map :Format to vim.lsp.buf.formatting()
FormattingOptions = {
	tabSize = 4;
    insertSpaces = false;
}

FormattingParams = vim.lsp.util.make_formatting_params(FormattingOptions)

vim.cmd[[command! Format execute 'lua vim.lsp.buf.formatting(FormattingParams)']]
--}}}

-- Aesthetics{{{
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type

    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
--}}}

-- lsp-installer{{{
local lsp_installer = require("nvim-lsp-installer")

-- Provide settings first!
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

lsp_installer.on_server_ready(
    function(server)
        server:setup {}
    end
)
--}}}

-- Extra server config{{{
-- Typescript{{{
-- I have no idea if this works
lspconfig.tsserver.setup {
    cmd = { "npx", "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },

    init_options = {
        hostInfo = "neovim"
    },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
--}}}

-- lua{{{
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, ".config/nvim/lua/?.lua")
table.insert(runtime_path, ".config/nvim/lua/?/init.lua")

require'lsp_signature'.on_attach()
--}}}
--}}}

-- Float border {{{
-- Leaving in case I want to use this later cause it was a pain to get all the chars
-- local border = {
--       {"▛", "FloatBorder"},

--       {"▀", "FloatBorder"},

--       {"▜", "FloatBorder"},

--       {"▐", "FloatBorder"},

--       {"▟", "FloatBorder"},

--       {"▄", "FloatBorder"},

--       {"▙", "FloatBorder"},

--       {"▌", "FloatBorder"},
-- }
-- -- }}}

