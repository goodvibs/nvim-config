return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "folke/lazydev.nvim",
    },
    config = function()
        local keymap = vim.keymap


        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end


        vim.diagnostic.config({
            virtual_text = { prefix = "●", spacing = 4 },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = { border = "rounded", source = true, header = "", prefix = "" },
        })


        local capabilities = vim.lsp.protocol.make_client_capabilities()


        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_option_value(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            local opts = { buffer = bufnr, remap = false }

            if client.server_capabilities.documentFormattingProvider then
                keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ bufnr = bufnr }) end,
                    vim.tbl_extend("force", opts, { desc = "Format document" }))
            end
        end


        require("mason").setup()
        local mason_lspconfig = require("mason-lspconfig")


        local function default_handler(server_name)
            vim.lsp.config(server_name, { capabilities = capabilities, on_attach = on_attach })
            vim.lsp.enable(server_name)
        end


        local function lua_ls_handler()
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")
        end


        mason_lspconfig.setup({
            handlers = {
                lua_ls = lua_ls_handler,
                default_handler,
            },
        })

        lua_ls_handler()
    end,
}
