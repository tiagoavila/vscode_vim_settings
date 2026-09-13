-- LSP server configurations -------------------------------------------------

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("arduino_language_server", {
    cmd = {
        "arduino-language-server",
        "-cli", "arduino-cli",
        "-cli-config", "C:\\Users\\Tiago\\AppData\\Local\\Arduino15\\arduino-cli.yaml",
        "-clangd", "clangd",
        "-fqbn", "arduino:avr:uno",
    },
    capabilities = capabilities,
})

vim.lsp.enable("arduino_language_server")

-- Buffer-local LSP UX --------------------------------------------------------

---Registers a silent, buffer-local normal-mode mapping.
---@param bufnr integer Buffer the mapping applies to.
---@param lhs string Key sequence to bind.
---@param rhs function|string Action to run.
---@param desc string Human-readable description shown by which-key/`:map`.
local function map_buffer(bufnr, lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
end

---Sets up keymaps for a freshly attached LSP client.
---@param event table `LspAttach` autocmd payload (exposes `buf` and `data`).
local function on_lsp_attach(event)
    local bufnr = event.buf

    map_buffer(bufnr, "gd", vim.lsp.buf.definition, "LSP: Go to definition")
    map_buffer(bufnr, "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
    map_buffer(bufnr, "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
    map_buffer(bufnr, "K", vim.lsp.buf.hover, "LSP: Hover documentation")
    map_buffer(bufnr, "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")
    map_buffer(bufnr, "<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
    map_buffer(bufnr, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
    map_buffer(bufnr, "<leader>e", vim.diagnostic.open_float, "LSP: Line diagnostics")
    map_buffer(bufnr, "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "LSP: Previous diagnostic")
    map_buffer(bufnr, "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "LSP: Next diagnostic")
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Configure buffer-local LSP keymaps",
    callback = on_lsp_attach,
})
