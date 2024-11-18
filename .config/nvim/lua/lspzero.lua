local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
end)

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['html'] = { 'html' },
        ['cssls'] = { 'css', 'scss' },
        ['tsserver'] = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        ['jsonls'] = { "json", "jsonc" },
        ['bashls'] = { "sh" },
        ['gopls'] = { "go", "gomod", "gowork", "gotmpl" }
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').html.setup { capabilities = capabilities }
require('lspconfig').cssls.setup { capabilities = capabilities }
require('lspconfig').tsserver.setup {}
require('lspconfig').jsonls.setup {}
require('lspconfig').bashls.setup {}
require('lspconfig').gopls.setup {}

lsp.setup()
