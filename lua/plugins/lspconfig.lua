return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    -- Ensure mason loads first
    after = { "mason.nvim", "mason-lspconfig.nvim" },
    config = function()
        local keymap = vim.keymap
        local lspconfig = require("lspconfig")

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Configure diagnostic display
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 4,
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Enhanced LSP capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- Add snippet support for better completion
        capabilities.textDocument.completion.completionItem = {
            snippetSupport = true,
        }

        -- Helper function to setup LSP keymaps
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            -- Buffer local mappings
            local opts = { buffer = bufnr, remap = false }

            -- Go to definition
            keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))

            -- Go to declaration
            keymap.set("n", "gD", function()
                vim.lsp.buf.declaration()
            end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

            -- Go to type definition
            keymap.set("n", "gt", function()
                vim.lsp.buf.type_definition()
            end, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

            -- Go to implementation
            keymap.set("n", "gi", function()
                vim.lsp.buf.implementation()
            end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

            -- Show hover information
            keymap.set("n", "K", function()
                vim.lsp.buf.hover()
            end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

            -- Show signature help
            keymap.set("n", "<C-k>", function()
                vim.lsp.buf.signature_help()
            end, vim.tbl_extend("force", opts, { desc = "Signature help" }))

            -- Find references
            keymap.set("n", "gr", function()
                vim.lsp.buf.references()
            end, vim.tbl_extend("force", opts, { desc = "Find references" }))

            -- Rename symbol
            keymap.set("n", "<leader>lr", function()
                vim.lsp.buf.rename()
            end, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

            -- Code actions
            keymap.set({ "n", "v" }, "<leader>la", function()
                vim.lsp.buf.code_action()
            end, vim.tbl_extend("force", opts, { desc = "Code actions" }))

            -- Format document
            keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ async = true })
            end, vim.tbl_extend("force", opts, { desc = "Format document" }))

            -- Show diagnostics in floating window
            keymap.set("n", "<leader>ld", function()
                vim.diagnostic.open_float()
            end, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))

            -- Go to next diagnostic
            keymap.set("n", "]d", function()
                vim.diagnostic.goto_next()
            end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

            -- Go to previous diagnostic
            keymap.set("n", "[d", function()
                vim.diagnostic.goto_prev()
            end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))

            -- Set diagnostics list
            keymap.set("n", "<leader>lq", function()
                vim.diagnostic.setloclist()
            end, vim.tbl_extend("force", opts, { desc = "Diagnostics list" }))

            -- Document highlights (highlight all references to symbol under cursor)
            if client.server_capabilities.documentHighlightProvider then
                local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = function()
                        vim.lsp.buf.document_highlight()
                    end,
                })

                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = function()
                        vim.lsp.buf.clear_references()
                    end,
                })

                vim.api.nvim_create_autocmd("LspDetach", {
                    group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                    callback = function(event)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event.buf })
                    end,
                })
            end
        end

        -- Setup LSP servers
        -- Install servers with :Mason, then configure them here or use mason-lspconfig.setup_handlers
        
        -- Example: Lua LSP configuration
        -- Uncomment and modify as needed when you install lua_ls via Mason
        -- lspconfig.lua_ls.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = {
        --         Lua = {
        --             runtime = { version = "LuaJIT" },
        --             diagnostics = { globals = { "vim" } },
        --             workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        --             telemetry = { enable = false },
        --         },
        --     },
        -- })
        
        -- To automatically configure servers installed via Mason, uncomment below
        -- after verifying mason-lspconfig.setup_handlers exists:
        -- local mason_lspconfig = require("mason-lspconfig")
        -- mason_lspconfig.setup_handlers({
        --     function(server_name)
        --         lspconfig[server_name].setup({
        --             capabilities = capabilities,
        --             on_attach = on_attach,
        --         })
        --     end,
        --     ["lua_ls"] = function()
        --         lspconfig.lua_ls.setup({
        --             capabilities = capabilities,
        --             on_attach = on_attach,
        --             settings = {
        --                 Lua = {
        --                     runtime = { version = "LuaJIT" },
        --                     diagnostics = { globals = { "vim" } },
        --                     workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        --                     telemetry = { enable = false },
        --                 },
        --             },
        --         })
        --     end,
        -- })
    end,
}
