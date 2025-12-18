return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "echasnovski/mini.icons",
        "bwpge/lualine-pretty-path",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            blue = "#65D1FF",
            green = "#3EFFDC",
            violet = "#FF61EF",
            yellow = "#FFDA7B",
            red = "#FF4A4A",
            fg = "#c3ccdc",
            bg = "#112638",
            inactive_bg = "#2c3043",
        }

        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.inactive_bg, fg = colors.fg },
            },
        }

        -- Helper function to get diagnostics count
        local function diagnostics_count(severity)
            local count = vim.diagnostic.count(0, { severity = severity })
            return count > 0 and tostring(count) or ""
        end

        -- Helper function to get LSP client names
        local function lsp_client()
            local clients = {}
            for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                table.insert(clients, client.name)
            end
            return table.concat(clients, ", ")
        end

        -- configure lualine with modified theme
        lualine.setup({
            options = {
                theme = my_lualine_theme,
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'alpha', 'dashboard' },
                    winbar = {},
                },
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 100,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    { 'branch', icon = '' },
                    { 'pretty_path' },
                    {
                        'diff',
                        symbols = { added = '󰐕 ', modified = '󰍴 ', removed = '󰍵 ' },
                        diff_color = {
                            added = { fg = colors.green },
                            modified = { fg = colors.yellow },
                            removed = { fg = colors.red },
                        },
                    },
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        shorting_target = 40,
                        symbols = {
                            modified = ' ●',
                            readonly = ' 󰈡',
                            unnamed = ' [No Name]',
                            newfile = ' [New]',
                        },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        symbols = {
                            error = '󰅚 ',
                            warn = '󰀪 ',
                            info = '󰋽 ',
                            hint = '󰌵 ',
                        },
                        colored = true,
                        update_in_insert = false,
                        always_visible = false,
                    },
                },
                lualine_x = {
                    {
                        function()
                            return vim.bo.filetype ~= '' and vim.bo.filetype or 'no ft'
                        end,
                        icon = '󰨞',
                        color = { fg = colors.fg, gui = 'bold' },
                    },
                    {
                        'encoding',
                        cond = function()
                            return vim.bo.fileencoding ~= ''
                        end,
                    },
                    {
                        'fileformat',
                        symbols = {
                            unix = '󰘧',
                            dos = '󰘧',
                            mac = '󰘧',
                        },
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        function()
                            return ('%s %d events'):format(Snacks.profiler.config.icons.status,
                                #Snacks.profiler.core.events)
                        end,
                        color = 'DiagnosticError',
                        cond = function()
                            return Snacks.profiler.core.running
                        end,
                    },
                    {
                        function()
                            local reg = vim.fn.reg_recording()
                            return ' recording to ' .. reg
                        end,
                        color = 'DiagnosticInfo',
                        cond = function()
                            return vim.fn.reg_recording() ~= ''
                        end,
                    },
                },
                lualine_y = {
                    {
                        lsp_client,
                        icon = '󰒋',
                        color = { fg = colors.green },
                        cond = function()
                            return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
                        end,
                    },
                    {
                        'location',
                        padding = { left = 0, right = 1 },
                    },
                    {
                        'progress',
                        padding = { left = 1, right = 0 },
                    },
                },
                lualine_z = {
                    {
                        'datetime',
                        style = '%H:%M',
                        cond = function()
                            return vim.fn.strftime('%H') ~= '00' or vim.fn.strftime('%M') ~= '00'
                        end,
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    { 'branch', icon = '' },
                    { 'pretty_path' },
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        symbols = {
                            modified = ' ●',
                            readonly = ' 󰈡',
                            unnamed = ' [No Name]',
                        },
                    },
                },
                lualine_x = {
                    {
                        function()
                            return vim.bo.filetype ~= '' and vim.bo.filetype or 'no ft'
                        end,
                    },
                    {
                        'location',
                    },
                },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
