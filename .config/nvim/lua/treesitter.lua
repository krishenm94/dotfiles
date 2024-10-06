-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end
--...
-- configure treesitter
treesitter.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        use_languagetree = false,
        disable = function(_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
            return file_size > 256 * 1024
        end,
    },
    indent = { enable = true },
    ensure_installed = {
        "c",
        "cpp",
        "json",
        "javascript",
        "typescript",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "go"
    },
    auto_install = true,
    ignore_install = {},
    modules = {},
    sync_install = true,
})
